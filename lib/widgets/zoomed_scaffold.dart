import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class ZoomScaffold extends StatefulWidget {
  final Widget menuScreen;
  final Widget endMenuScreen;
  final Widget contentScreen;
  final MenuController controller;
  final bool returnWhenPressBack;

  ZoomScaffold({
    @required this.contentScreen,
    this.menuScreen,
    this.endMenuScreen,
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

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    provider = widget.controller
      ..stream?.listen((event) {
        setState(() {});
      });
  }

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

    final slideAmount = 275.0 * slidePercent;
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

  Widget _buildGestures(bool dragFromLeft) {
    return GestureDetector(
      onHorizontalDragStart: (detail) {},
      onHorizontalDragUpdate: (details) async {
        if (!provider.isOpen) {
          if (dragFromLeft) {
            var globalPosition = details.globalPosition.dx;
            globalPosition = globalPosition < 0 ? 0 : globalPosition;
            double position =
                globalPosition / MediaQuery.of(context).size.width;
            var realPosition = position;
            if (provider.isEndMenu) provider.currentMenu = CurrentMenu.start;
            provider.percentOpen = realPosition;
          } else {
            List<int> ints = [];
            for (var i = MediaQuery.of(context).size.width.round(); i > 1; i--)
              ints.add(i);
            var realPosition = ints[details.globalPosition.dx.toInt()] /
                MediaQuery.of(context).size.width;
            if (provider.isStartMenu) provider.currentMenu = CurrentMenu.end;
            provider.percentOpen = realPosition;
          }
        } else {
          if (dragFromLeft) {
            // Closing end
            print('end');
            // provider.closeEnd();
          } else {
            // closing right
            print('right');
            // provider.close();
          }
        }
      },
      onHorizontalDragEnd: (detail) {
        if (dragFromLeft && provider.isEndMenu && provider.isOpen)
          provider.closeEnd();
        if (!dragFromLeft && provider.isStartMenu && provider.isOpen)
          provider.close();

        if (dragFromLeft && provider.isStartMenu && !provider.isOpen)
          provider.open();
        if (!dragFromLeft && provider.isEndMenu && !provider.isOpen)
          provider.openEnd();

        print('ended');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double gestureWidth = MediaQuery.of(context).size.width / 4;
    double appBar = 56;
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            if (provider.isOpen) if (widget.returnWhenPressBack) {
              await provider.closeOpened();
              return false;
            }
            return true;
          },
          child: Stack(
            children: [
              Container(
                child: provider.isStartMenu
                    ? widget.menuScreen ?? Container()
                    : widget.endMenuScreen ?? Container(),
              ),
              animateContent(widget.contentScreen),
              provider.isOpen
                  ? Positioned(
                      top: 0,
                      left: provider.isEndMenu ? 0 : null,
                      right: provider.isStartMenu ? 0 : null,
                      child: SizedBox(
                        height:
                            MediaQuery.of(context).size.width / 6.4 + appBar,
                        // height: appBar + tabBar + tabPadding,
                        width: gestureWidth,
                        child: _buildGestures(!provider.isStartMenu),
                      ),
                    )
                  : Positioned(
                      top: 0,
                      child: SizedBox(
                        // need a sized box because it will overflow
                        // bacause its in a stack
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              height: appBar,
                              width: gestureWidth,
                              child: _buildGestures(true),
                            ),
                            Spacer(),
                            SizedBox(
                              height: appBar,
                              width: gestureWidth,
                              child: _buildGestures(false),
                            ),
                          ],
                        ),
                      ),
                    ),
              provider.isOpen
                  ? Positioned(
                      bottom: 0,
                      left: provider.isEndMenu ? 0 : null,
                      right: provider.isStartMenu ? 0 : null,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.width / 6.4,
                        width: gestureWidth,
                        child: _buildGestures(!provider.isStartMenu),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuController {
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
