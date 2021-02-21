import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../lang/lang.dart';

import '../../color_info/color_info.dart';
import '../../../utils.dart';
import '../../../widgets/chessboard.dart';

import '../image_color_picker.dart';

class LocalImageSelector extends StatefulWidget {
  LocalImageSelector({Key key}) : super(key: key);

  @override
  _LocalImageSelectorState createState() => _LocalImageSelectorState();
}

class _LocalImageSelectorState extends State<LocalImageSelector>
    with AutomaticKeepAliveClientMixin {
  Color color = Colors.black;

  final picker = ImagePicker();
  File _image;

  void getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) setState(() => _image = File(pickedFile.path));
  }

  final pickerKey = GlobalKey<ColorPickerWidgetState>();

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
              children: [
                RepaintBoundary(child: ChessBoard()),
                if (_image != null)
                  LayoutBuilder(builder: (context, c) {
                    return ConstrainedBox(
                      constraints: c,
                      child: ColorPickerWidget(
                        key: pickerKey,
                        onUpdate: (color) => setState(() => this.color = color),
                        image: Image.file(
                          _image,
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  })
              ],
            ),
          ),
        ),
        ColorInfo(
          shrinkable: false,
          color: color,
          onExpand: () {
            pickerKey.currentState?.loadSnapshotBytes();
            setState(() {});
          },
          leading: buildCompactIconButton(
            icon: FaIcon(FontAwesomeIcons.image),
            tooltip: lang.selectPhoto,
            onPressed: getImage,
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
