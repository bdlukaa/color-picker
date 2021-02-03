import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../lang/lang.dart';
import '../../../widgets/scroll_initial.dart';

import '../../color_info/color_info.dart';

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
    setState(() => _image = File(pickedFile.path));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final lang = Language.of(context);
    return ScrollInitial(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            child: FlatButton(
              child: Text(lang.selectPhoto),
              color: Colors.green,
              onPressed: getImage,
              textColor: Colors.white,
            ),
          ),
          Expanded(
            child: Container(
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
              child: _image != null
                  ? ColorPickerWidget(
                      onUpdate: (color) => setState(() => this.color = color),
                      image: FileImage(_image),
                    )
                  : Container(),
            ),
          ),
          ColorInfo(color: color),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
