import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        alignment: Alignment.topCenter,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Icon(Icons.palette, color: Colors.white, size: 148),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: 36),
              child: LoadingBouncingGrid.square(
                backgroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
