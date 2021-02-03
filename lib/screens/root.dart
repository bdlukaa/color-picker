import 'package:flutter/material.dart';

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
  Root({Key key}) : super(key: key);

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> with TickerProviderStateMixin {
  MenuController menuController;

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
    return ZoomScaffold(
      controller: menuController,
      menuScreen: SettingsHome(),
      menuColor: ThemeManager.isBright(context)
          ? Colors.white
          : Theme.of(context).scaffoldBackgroundColor,
      endMenuScreen: FavoritesList(),
      endMenuColor: Colors.blueGrey,
      contentScreen: DefaultTabController(
        key: scaffoldKey,
        length: 5,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: menuController.expanded
                ? null
                : IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () => menuController.toggle(),
                  ),
            // title: height >= 500
            title: false
                // ignore: dead_code
                ? Text(lang.title, style: TextStyle(color: Colors.white))
                : _buildTabBar(lang),
            actions: <Widget>[
              if (!menuController.expanded)
                IconButton(
                  icon: Icon(Icons.favorite),
                  onPressed: () => menuController.toggleEnd(),
                ),
            ],
            brightness: Brightness.dark, // light icons
            // bottom: height >= 500 ? _buildTabBar(lang) : null,
          ),
          // backgroundColor: Colors.orange,
          body: Padding(
            padding: EdgeInsets.only(top: 7),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              child: Container(
                color: ThemeManager.isBright(context) ? Colors.white : null,
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    WheelPickerHome(),
                    PalettePickerHome(),
                    ValueHome(),
                    NamedPickerHome(),
                    ImagePickerHome(),
                  ],
                ),
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
        Tab(text: lang.wheelPicker),
        Tab(text: lang.palettePicker),
        Tab(text: lang.valuePicker),
        Tab(text: lang.namedPicker),
        Tab(text: lang.imagePicker),
      ],
      // indicatorColor: Colors.blue[800],
      // indicatorSize: TabBarIndicatorSize.label,
      // labelColor: Colors.white,
    );
  }
}
