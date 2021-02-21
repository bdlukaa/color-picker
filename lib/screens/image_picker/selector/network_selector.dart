import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

  Color color = Colors.black;
  String url;

  @override
  void initState() {
    super.initState();
    _focus.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final lang = Language.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                RepaintBoundary(child: ChessBoard()),
                if (url != null && url.isNotEmpty)
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
          shrinkable: false,
          leading: buildCompactIconButton(
            icon: FaIcon(FontAwesomeIcons.link),
            tooltip: lang.url,
            onPressed: () => UrlPicker(
              onPick: (text) {
                setState(() => url = text);
                Navigator.pop(context);
              },
            ).show(context),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class UrlPicker extends StatelessWidget {
  UrlPicker({Key key, @required this.onPick}) : super(key: key);

  final ValueChanged<String> onPick;

  void show(BuildContext context) => showDialog(
        context: context,
        child: this,
      );

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final lang = Language.of(context);
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      content: TextFormField(
        controller: _controller,
        keyboardType: TextInputType.url,
        onFieldSubmitted: (text) => onPick?.call(text),
        decoration: InputDecoration(
          hintText: lang.url,
          focusColor: Colors.white,
        ),
      ),
      actions: [
        TextButton(
          child: Text(lang.close),
          onPressed: () => Navigator.pop(context),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.redAccent),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            overlayColor: MaterialStateProperty.all(Colors.red),
          ),
        ),
        TextButton(
          child: Text(lang.search),
          onPressed: () => onPick?.call(_controller.text),
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.teal),
            overlayColor: MaterialStateProperty.all(Colors.tealAccent),
          ),
        ),
      ],
    );
  }
}
