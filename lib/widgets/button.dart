import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  Button({
    Key key,
    this.text,
    this.subText,
    this.icon,
    this.tooltip,
    this.padding = EdgeInsets.zero,
    this.internalPadding = EdgeInsets.zero,
    @required this.onTap,
    @required this.color,
    this.splashColor,
    this.radius,
    this.width,
    this.height = 60,
    this.shadowEnabled = true,
  }) : super(key: key);

  final Widget text;
  final Widget subText;
  final Widget icon;
  final Function onTap;
  final Color color;
  final Color splashColor;
  final String tooltip;
  final EdgeInsets padding;
  final EdgeInsets internalPadding;
  final BorderRadius radius;
  final double width;
  final double height;
  final bool shadowEnabled;

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: widget.tooltip == null
          ? child
          : Tooltip(message: widget.tooltip, child: child),
    );
  }

  BorderRadius get radius => widget.radius ?? BorderRadius.circular(10);

  Widget get child {
    return InkWell(
      borderRadius: radius,
      onTap: widget.onTap,
      splashColor: widget.splashColor ?? Colors.black45,
      child: Ink(
        height: widget.height,
        width: widget.width,
        padding: widget.internalPadding ?? EdgeInsets.zero,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: radius,
          boxShadow: widget.shadowEnabled ?? true
              ? [
                  BoxShadow(
                    color: widget.color,
                    blurRadius: 2.0,
                    spreadRadius: 0.0,
                    offset: Offset(2.0, 2.0),
                  )
                ]
              : [],
        ),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          children: <Widget>[
            widget.icon != null
                ? IconTheme(
                    child: widget.icon,
                    data: IconThemeData(color: Colors.white),
                  )
                : Container(),
            SizedBox(
                width: widget.text == null && widget.subText == null ? 0 : 3),
            widget.subText != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      widget.text != null
                          ? Flexible(
                              child: _buildTitle,
                              fit: FlexFit.loose,
                            )
                          : Container(),
                      widget.subText != null
                          ? Flexible(
                              child: _buildSubtitle,
                              fit: FlexFit.loose,
                            )
                          : Container(),
                    ],
                  )
                : widget.text != null ? _buildTitle : Container(),
          ],
        ),
      ),
    );
  }

  Widget get _buildTitle => DefaultTextStyle(
        child: widget.text,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      );

  Widget get _buildSubtitle => DefaultTextStyle(
        child: widget.subText,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      );
}
