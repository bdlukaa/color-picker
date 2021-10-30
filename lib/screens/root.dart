import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../lang/lang.dart';
import '../widgets/zoomed_scaffold.dart';
import '../theme_manager.dart';

import 'palette_picker/palette_picker_home.dart';
import 'wheel_picker/color_picker_wheel_home.dart';
import 'value_picker/value_home.dart';
import 'named_picker/named_picker_home.dart';
import 'image_picker/image_picker_home.dart';
import 'favorite/favorites_list.dart';
import 'settings/settings_home.dart';

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> with TickerProviderStateMixin {
  late MenuController menuController;

  // Use this key to keep the state of the tabs and scrolling
  final scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    menuController = MenuController(
      vsync: this,
    )..stream.listen((value) => setState(() {}));
  }

  @override
  void dispose() {
    menuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = Language.of(context);
    const radius = BorderRadius.vertical(top: Radius.circular(25));
    return ZoomScaffold(
      controller: menuController,
      menuScreen: const SettingsHome(),
      menuColor:
          ThemeManager.isBright(context) ? Colors.white : Colors.grey[850]!,
      endMenuScreen: const FavoritesList(),
      endMenuColor: Colors.blueGrey,
      contentScreen: DefaultTabController(
        key: scaffoldKey,
        length: 5,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: () {
              if (!menuController.expanded) {
                return IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () => menuController.toggle(),
                  tooltip: lang.settings,
                  splashRadius: 24,
                );
              }
              return null;
            }(),
            title: _buildTabBar(lang),
            actions: <Widget>[
              if (!menuController.expanded)
                IconButton(
                  icon: const Icon(Icons.favorite),
                  onPressed: () => menuController.toggleEnd(),
                  tooltip: lang.favoriteColorsTitle,
                  splashRadius: 24,
                ),
            ],
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),
          body: Container(
            margin: const EdgeInsets.only(top: 7),
            decoration: BoxDecoration(
              color: ThemeManager.isBright(context)
                  ? Colors.white
                  : Colors.grey[850],
              borderRadius: radius,
            ),
            child: const Material(
              type: MaterialType.transparency,
              elevation: 8,
              borderRadius: radius,
              // color: Colors.transparent,
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  PalettePickerHome(),
                  WheelPickerHome(),
                  ValueHome(),
                  NamedPickerHome(),
                  ImagePickerHome(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar(Language lang) {
    return TabBar(
      isScrollable: true,
      tabs: <Widget>[
        Tab(text: lang.palettePicker),
        Tab(text: lang.wheelPicker),
        Tab(text: lang.valuePicker),
        Tab(text: lang.namedPicker),
        Tab(text: lang.imagePicker),
      ],
    );
  }
}

bool get isDesktop {
  if (kIsWeb) return false;
  return Platform.isWindows || Platform.isLinux || Platform.isMacOS;
}

class WindowButtons extends StatefulWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  _WindowButtonsState createState() => _WindowButtonsState();
}

class _WindowButtonsState extends State<WindowButtons> {
  void maximizeOrRestore() {
    setState(() {
      appWindow.maximizeOrRestore();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isLight = Theme.of(context).brightness == Brightness.light;
    final buttonColors = WindowButtonColors(
      mouseOver: isLight ? Colors.orangeAccent : Colors.grey.shade800,
      mouseDown: isLight ? Colors.orangeAccent.shade400 : Colors.grey.shade800,
      iconNormal: Colors.white,
    );

    final closeButtonColors = WindowButtonColors(
      mouseOver: const Color(0xFFD32F2F),
      mouseDown: const Color(0xFFB71C1C),
      iconNormal: isLight ? Colors.white : Colors.grey,
      iconMouseOver: Colors.white,
    );

    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        appWindow.isMaximized
            ? RestoreWindowButton(
                colors: buttonColors,
                onPressed: maximizeOrRestore,
              )
            : MaximizeWindowButton(
                colors: buttonColors,
                onPressed: maximizeOrRestore,
              ),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}

class RestoreWindowButton extends WindowButton {
  RestoreWindowButton({
    Key? key,
    WindowButtonColors? colors,
    VoidCallback? onPressed,
    bool? animate,
  }) : super(
          key: key,
          colors: colors,
          animate: animate ?? false,
          iconBuilder: (buttonContext) =>
              RestoreIcon(color: buttonContext.iconColor),
          onPressed: onPressed ?? () => appWindow.maximizeOrRestore(),
        );
}
