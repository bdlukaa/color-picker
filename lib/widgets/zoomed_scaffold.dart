import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class ZoomScaffold extends StatefulWidget {
  final Widget menuScreen;
  final Widget endMenuScreen;
  final Widget contentScreen;

  final Color endMenuColor;
  final Color menuColor;

  final MenuController controller;
  final bool returnWhenPressBack;

  ZoomScaffold({
    @required this.contentScreen,
    this.menuScreen,
    this.endMenuScreen,
    this.endMenuColor,
    this.menuColor,
    this.controller,
    this.returnWhenPressBack = true,
  });

  @override
  _ZoomScaffoldState createState() => _ZoomScaffoldState();
}

class _ZoomScaffoldState extends State<ZoomScaffold>
    with TickerProviderStateMixin {
  Curve scaleDownCurve = Interval(0.0, 0.3, curve: Curves.easeOut);
  Curve scaleUpCurve = Interval(0.0, 1.0, curve: Curves.easeOut);
  Curve slideOutCurve = Interval(0.0, 1.0, curve: Curves.easeOut);
  Curve slideInCurve = Interval(0.0, 1.0, curve: Curves.easeOut);

  MenuController provider;

  @override
  void initState() {
    super.initState();
    provider = widget.controller
      ..stream?.listen((event) {
        setState(() {});
      });
  }

  MediaQueryData get mq => MediaQuery.of(context);

  Widget animateContent(Widget content) {
    double slidePercent, scalePercent;
    switch (provider.menuState) {
      case MenuState.closed:
        slidePercent = 0.0;
        scalePercent = 0.0;
        break;
      case MenuState.open:
        slidePercent = 1.0;
        scalePercent = 1.0;
        break;
      case MenuState.opening:
        slidePercent = slideOutCurve.transform(provider.percentOpen);
        scalePercent = scaleDownCurve.transform(provider.percentOpen);
        break;
      case MenuState.closing:
        slidePercent = slideInCurve.transform(provider.percentOpen);
        scalePercent = scaleUpCurve.transform(provider.percentOpen);
        break;
    }

    Alignment alignment = Alignment.centerLeft;

    if (provider.isEndMenu) {
      slidePercent = -slidePercent;
      alignment = Alignment.centerRight;
    }

    final slideAmount = mq.size.width * 0.8 * slidePercent;
    final contentScale = 1.0 - (0.2 * scalePercent);
    final cornerRadius = 16.0 * provider.percentOpen;

    // print(slideAmount);

    // print(slideAmount);
    // print(slidePercent);

    return Transform(
      transform: Matrix4.identity()
        ..translate(slideAmount, 0.0)
        ..scale(contentScale),
      alignment: alignment,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: const Offset(0.0, 5.0),
              blurRadius: 15.0,
              spreadRadius: 10.0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(cornerRadius),
          child: content,
        ),
      ),
    );
  }

  double globalPosition = 0;

  Widget _buildGestures(bool dragFromLeft) {
    return GestureDetector(
      onHorizontalDragStart: (detail) {},
      onHorizontalDragUpdate: (details) async {
        globalPosition = details.globalPosition.dx;
        if (!provider.isOpen) {
          if (dragFromLeft) {
            var globalPosition = details.globalPosition.dx;
            globalPosition = globalPosition < 0 ? 0 : globalPosition;
            double position = globalPosition / mq.size.width;
            var realPosition = position;
            if (provider.isEndMenu) provider.currentMenu = CurrentMenu.start;
            provider.percentOpen = realPosition;
            print(realPosition);
          } else {
            List<int> ints = [];
            for (var i = mq.size.width.round(); i > 1; i--) ints.add(i);
            var realPosition =
                ints[details.globalPosition.dx.toInt()] / mq.size.width;
            if (provider.isStartMenu) provider.currentMenu = CurrentMenu.end;
            provider.percentOpen = realPosition;
          }
        } else {
          // TODO: ask for help on this on discord
          if (dragFromLeft) {
            // Closing right
            print('right');
            // provider.closeEnd();
          } else {
            // closing start
            print('start');
          }
        }
      },
      onHorizontalDragDown: (d) => print('down'),
      onHorizontalDragEnd: (detail) {
        // Is End menu AND is closing
        if (dragFromLeft && provider.isEndMenu && provider.isOpen) {
          if (globalPosition >= mq.size.width * 0.6)
            provider.closeEnd();
          else
            provider.openEnd();
        }

        // IS Start menu and is closing
        if (!dragFromLeft && provider.isStartMenu && provider.isOpen) {
          if (globalPosition <= 130)
            provider.close();
          else
            provider.open();
        }

        // Is start menu and is opening
        if (dragFromLeft && provider.isStartMenu && !provider.isOpen) {
          if (globalPosition <= 50)
            provider.close();
          else
            provider.open();
        }

        // Is end menu and is opening
        if (!dragFromLeft && provider.isEndMenu && !provider.isOpen) {
          if (globalPosition >= mq.size.width * 0.6)
            provider.closeEnd();
          else
            provider.openEnd();
        }
        // print(globalPosition);

        print('ended');
      },
    );
  }

  double contentPadding;

  Color get gestureColor => kDebugMode ? null : null;

  @override
  Widget build(BuildContext context) {
    double gestureWidth = mq.size.width * 0.15;
    double appBar = 56;

    final paddingFactor = mq.size.width * 0.25;
    EdgeInsets padding = EdgeInsets.only(right: paddingFactor);

    if (provider.isEndMenu) {
      padding = EdgeInsets.only(left: paddingFactor);
    }

    return WillPopScope(
      onWillPop: () async {
        if (provider.isOpen && widget.returnWhenPressBack) {
          await provider.closeOpened();
          return false;
        }
        return true;
      },
      child: LayoutBuilder(builder: (context, consts) {
        final width = consts.biggest.width;
        Widget Function(Color color, Widget screen, EdgeInsets p) buildMenu =
            (color, screen, p) {
          return Container(
            padding: (p ?? padding) + mq.viewPadding,
            color: color,
            child: Material(
              child: screen,
            ),
          );
        };
        Widget w;
        if (width >= 950) {
          provider.expanded = true;
          contentPadding = width / 3;
          w = Stack(
            children: [
              Container(
                padding: EdgeInsets.only(right: width / 2),
                child: buildMenu(
                  widget.menuColor,
                  widget.menuScreen,
                  EdgeInsets.only(right: width / 6),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: width / 2),
                child: buildMenu(
                  widget.endMenuColor,
                  widget.endMenuScreen,
                  EdgeInsets.only(left: width / 6),
                ),
              ),
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()..scale(0.9),
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: contentPadding),
                  // width: contentSize,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: const Offset(0.0, 5.0),
                          blurRadius: 15.0,
                          spreadRadius: 10.0,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: widget.contentScreen,
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          provider.expanded = false;
          w = Stack(
            children: [
              buildMenu(
                provider.isStartMenu ? widget.menuColor : widget.endMenuColor,
                provider.isStartMenu ? widget.menuScreen : widget.endMenuScreen,
                null,
              ),
              animateContent(widget.contentScreen),
              if (provider.isOpen)
                Positioned(
                  top: 0,
                  left: provider.isEndMenu ? 0 : null,
                  right: provider.isStartMenu ? 0 : null,
                  child: SafeArea(
                    child: Container(
                      color: gestureColor,
                      height: (mq.size.height * 0.1) + mq.viewPadding.top,
                      width: gestureWidth * 1.34,
                      child: _buildGestures(!provider.isStartMenu),
                    ),
                  ),
                )
              else
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    child: Row(
                      children: <Widget>[
                        Container(
                          color: gestureColor,
                          height: appBar,
                          width: gestureWidth,
                          child: _buildGestures(true),
                        ),
                        Spacer(),
                        Container(
                          color: gestureColor,
                          height: appBar,
                          width: gestureWidth,
                          child: _buildGestures(false),
                        ),
                      ],
                    ),
                  ),
                ),
              if (provider.isOpen)
                Positioned(
                  bottom: 0,
                  left: provider.isEndMenu ? 0 : null,
                  right: provider.isStartMenu ? 0 : null,
                  child: Container(
                    color: gestureColor,
                    height: mq.size.height * 0.1,
                    width: gestureWidth * 1.34,
                    child: _buildGestures(!provider.isStartMenu),
                  ),
                ),
            ],
          );
        }
        return w;
      }),
    );
  }
}

class MenuController {
  bool expanded = false;
  final TickerProvider vsync;
  final AnimationController _animationController;

  MenuState _state = MenuState.closed;
  CurrentMenu _currentMenu = CurrentMenu.start;

  // ignore: close_sinks
  final _stream = StreamController.broadcast();

  MenuController({@required this.vsync})
      : _animationController = AnimationController(vsync: vsync) {
    _animationController
      ..duration = const Duration(milliseconds: 250)
      ..addListener(() {
        _notifyListeners();
      })
      ..addStatusListener((AnimationStatus status) {
        switch (status) {
          case AnimationStatus.forward:
            _state = MenuState.opening;
            break;
          case AnimationStatus.reverse:
            _state = MenuState.closing;
            break;
          case AnimationStatus.completed:
            _state = MenuState.open;
            break;
          case AnimationStatus.dismissed:
            _state = MenuState.closed;
            break;
        }
        _notifyListeners();
      });
  }

  void _notifyListeners() => _stream.add(true);

  void dispose() {
    _animationController.dispose();
    _stream.close();
  }

  void showBottomSheet(Widget sheet) => _stream.add(sheet);

  Stream get stream => _stream.stream;

  bool get isStartMenu => currentMenu == CurrentMenu.start;
  bool get isEndMenu => currentMenu == CurrentMenu.end;

  bool get isOpen => menuState == MenuState.open;
  bool get isClosed => menuState == MenuState.closed;

  MenuState get menuState => _state;
  CurrentMenu get currentMenu => _currentMenu;
  set currentMenu(CurrentMenu menu) {
    _currentMenu = menu;
    _notifyListeners();
  }

  double get percentOpen => _animationController.value;
  set percentOpen(double percent) {
    _animationController.value = percent;
    _notifyListeners();
  }

  Future<void> open() async {
    _currentMenu = CurrentMenu.start;
    await _animationController.forward();
  }

  Future<void> close() async {
    await _animationController.reverse();
    _currentMenu = CurrentMenu.start;
  }

  Future<void> toggle() async => isOpen ? await close() : await open();

  Future<void> openEnd() async {
    _currentMenu = CurrentMenu.end;
    await _animationController.forward();
  }

  Future<void> closeEnd() async {
    await _animationController.reverse();
    _currentMenu = CurrentMenu.end;
  }

  Future<void> toggleEnd() async => isOpen ? await closeEnd() : await openEnd();

  Future<void> closeOpened() async {
    if (isOpen) if (isStartMenu)
      await close();
    else
      await closeEnd();
  }
}

enum MenuState {
  closed,
  opening,
  open,
  closing,
}

enum CurrentMenu { start, end }
