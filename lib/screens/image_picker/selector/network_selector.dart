import 'package:flutter/material.dart';

import '../../color_info/color_info.dart';

import '../../../lang/lang.dart';
import '../../../utils.dart';
import '../../../widgets/chessboard.dart';
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

  @override
  void initState() {
    super.initState();
    _focus.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final lang = Language.of(context);
    var border = UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.blue),
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // Row(
        //   children: <Widget>[
        //     Expanded(
        //       child: Form(
        //         key: _key,
        //         child: TextFormField(
        //           focusNode: _focus,
        //           controller: _controller,
        //           onFieldSubmitted: (text) => submit(),
        //           decoration: InputDecoration(
        //             labelText: lang.url,
        //             labelStyle: TextStyle(color: Colors.blue),
        //             enabledBorder: border,
        //             disabledBorder: border,
        //             focusedBorder: border,
        //           ),
        //           cursorColor: Colors.black,
        //           style: TextStyle(color: Colors.black),
        //           validator: (text) {
        //             if (text.isEmpty) return lang.urlMustNotBeEmpty;
        //             return null;
        //           },
        //         ),
        //       ),
        //     ),
        //     IconButton(
        //       icon: Icon(Icons.search, color: Colors.black),
        //       tooltip: lang.search,
        //       onPressed: () => submit(),
        //     ),
        //   ],
        // ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                RepaintBoundary(child: ChessBoard()),
                if (url != null)
                  ColorPickerWidget(
                    onUpdate: (color) => setState(() => this.color = color),
                    image: Image.network(
                      url,
                      fit: BoxFit.contain,
                      alignment: Alignment.center,
                    ),
                  )
              ],
            ),
          ),
        ),
        ColorInfo(
          color: color,
          leading: buildCompactIconButton(
            icon: Icon(Icons.link),
            tooltip: lang.url,
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
