import 'package:color_picker/lang/lang.dart';
import 'package:color_picker/screens/color_info/color_info.dart';
import 'package:flutter/material.dart';

import '../image_color_picker.dart';

class NetworkImageSelector extends StatefulWidget {
  NetworkImageSelector({Key key}) : super(key: key);

  @override
  _NetworkImageSelectorState createState() => _NetworkImageSelectorState();
}

class _NetworkImageSelectorState extends State<NetworkImageSelector>
    with AutomaticKeepAliveClientMixin {
  final _focus = FocusNode();
  final _key = GlobalKey<FormState>();
  final _controller = TextEditingController();

  Color color = Colors.black;
  String url;

  void submit() {
    if (_key.currentState.validate() && url != _controller.text)
      setState(() => url = _controller.text);
  }

  double initialHeight;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _focus.addListener(() => setState(() {}));
    Language lang = Language.of(context);
    var border =
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue));
    return LayoutBuilder(
      builder: (context, con) {
        if (initialHeight == null) initialHeight = con.biggest.height;
        return SingleChildScrollView(
          child: Container(
            height: initialHeight,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Form(
                        key: _key,
                        child: TextFormField(
                          focusNode: _focus,
                          controller: _controller,
                          onFieldSubmitted: (text) => submit(),
                          decoration: InputDecoration(
                            labelText: lang.url,
                            labelStyle: TextStyle(color: Colors.blue),
                            enabledBorder: border,
                            disabledBorder: border,
                            focusedBorder: border,
                          ),
                          validator: (text) {
                            if (text.isEmpty) return lang.urlMustNotBeEmpty;
                            return null;
                          },
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.search),
                      tooltip: 'Search',
                      onPressed: () => submit(),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    height: (con.biggest.height - 70).isNegative
                        ? con.biggest.height
                        : (con.biggest.height - 70),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: Image.asset(
                          'assets/checkerboard.png',
                          fit: BoxFit.fill,
                        ).image,
                        fit: BoxFit.fill,
                      ),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 8),
                    // color: Colors.black,
                    child: url != null
                        ? ColorPickerWidget(
                            onUpdate: (color) => setState(() => this.color = color),
                            image: NetworkImage(url),
                          )
                        : Container(),
                  ),
                ),
                ColorInfo(color: color),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
