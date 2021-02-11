import 'dart:async';

import 'package:flutter/material.dart';

const Duration _kExpand = const Duration(milliseconds: 200);

class ControllableExpansionTile extends StatefulWidget {
  const ControllableExpansionTile({
    Key key,
    this.title,
    @required this.backgroundColor,
    this.leading,
    this.controller,
    this.first = false,
    this.onExpansionChanged,
    this.children: const <Widget>[],
    this.trailing,
    this.initiallyExpanded: false,
    this.radius,
  })  : assert(initiallyExpanded != null),
        super(key: key);

  final Widget leading;
  final Widget title;
  final ValueChanged<bool> onExpansionChanged;
  final List<Widget> children;
  final Color backgroundColor;
  final Widget trailing;
  final bool initiallyExpanded;
  final ControllableExpansionTileController controller;
  final bool first;
  final BorderRadiusGeometry radius;

  @override
  ControllableExpansionTileState createState() =>
      ControllableExpansionTileState();
}

class ControllableExpansionTileState extends State<ControllableExpansionTile>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  CurvedAnimation _easeOutAnimation;
  CurvedAnimation _easeInAnimation;
  ColorTween _borderColor;
  ColorTween _headerColor;
  ColorTween _iconColor;
  ColorTween _backgroundColor;
  Animation<double> _iconTurns;

  bool _isExpanded = false;

  ControllableExpansionTileController controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _easeOutAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _easeInAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _borderColor = ColorTween();
    _headerColor = ColorTween();
    _iconColor = ColorTween();
    _iconTurns = Tween<double>(begin: 0.0, end: 0.5).animate(_easeInAnimation);
    _backgroundColor = ColorTween();

    _isExpanded =
        PageStorage.of(context)?.readState(context) ?? widget.initiallyExpanded;
    if (_isExpanded) _controller.value = 1.0;

    controller = widget.controller ?? ControllableExpansionTileController();
    controller.stream.listen((event) {
      if (event)
        expand();
      else
        collapse();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    controller.dispose();
    super.dispose();
  }

  void expand() {
    _setExpanded(true);
  }

  void collapse() {
    _setExpanded(false);
  }

  void toggle() {
    _setExpanded(!_isExpanded);
  }

  void _setExpanded(bool isExpanded) async {
    if (_isExpanded != isExpanded) {
      setState(() {
        _isExpanded = isExpanded;
        if (_isExpanded)
          _controller.forward();
        else
          _controller.reverse().then<void>((value) {
            setState(() {
              // Rebuild without widget.children.
            });
          });
        PageStorage.of(context)?.writeState(context, _isExpanded);
      });
      if (widget.onExpansionChanged != null) {
        await Future.delayed(_kExpand);
        widget.onExpansionChanged(_isExpanded);
      }
    }
  }

  Widget _buildChildren(BuildContext context, Widget child) {
    final borderRadius = widget.radius ??
        BorderRadius.vertical(top: Radius.circular(widget.first ? 20 : 0));

    return Container(
      color: _backgroundColor.evaluate(_easeOutAnimation) ?? Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconTheme.merge(
            data: IconThemeData(color: _iconColor.evaluate(_easeInAnimation)),
            child: ClipRRect(
              borderRadius: borderRadius,
              child: ListTile(
                shape: RoundedRectangleBorder(borderRadius: borderRadius),
                tileColor: widget.backgroundColor,
                onTap: toggle,
                leading: widget.leading,
                title: widget.title,
                trailing: RotationTransition(
                  turns: _iconTurns,
                  child: widget.trailing ?? const Icon(Icons.expand_more),
                ),
              ),
            ),
          ),
          ClipRect(
            child: Align(
              heightFactor: _easeInAnimation.value,
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    _borderColor.end = theme.dividerColor;
    _headerColor
      ..begin = theme.textTheme.subtitle1.color
      ..end = theme.accentColor;
    _iconColor
      ..begin = theme.unselectedWidgetColor
      ..end = theme.unselectedWidgetColor;
    // ..end = theme.accentColor;
    // _backgroundColor.begin = widget.backgroundColor;
    // _backgroundColor.end = widget.backgroundColor;

    final bool closed = !_isExpanded && _controller.isDismissed;
    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: closed ? null : Column(children: widget.children),
    );
  }
}

class ControllableExpansionTileController {
  final _str = StreamController<bool>.broadcast();

  Stream get stream => _str.stream;

  close() => _str.add(false);
  open() => _str.add(true);

  void dispose() {
    _str.close();
  }
}
