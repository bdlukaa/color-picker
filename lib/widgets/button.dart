import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button({
    Key key,
    this.text,
    this.subText,
    this.icon,
    this.tooltip,
    this.padding = EdgeInsets.zero,
    this.internalPadding = EdgeInsets.zero,
    @required this.onTap,
    @required this.color,
    this.splashColor,
    this.radius,
    this.width,
    this.height = 60,
    this.shadowEnabled = true,
  }) : super(key: key);

  final Widget text;
  final Widget subText;
  final Widget icon;
  final Function onTap;
  final Color color;
  final Color splashColor;
  final String tooltip;
  final EdgeInsets padding;
  final EdgeInsets internalPadding;
  final BorderRadius radius;
  final double width;
  final double height;
  final bool shadowEnabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: tooltip == null ? child : Tooltip(message: tooltip, child: child),
    );
  }

  BorderRadius get bRadius => radius ?? BorderRadius.circular(10);

  Widget get child {
    return InkWell(
      borderRadius: bRadius,
      onTap: onTap,
      splashColor: splashColor ?? Colors.black45,
      child: Ink(
        height: height,
        width: width,
        padding: internalPadding ?? EdgeInsets.zero,
        decoration: BoxDecoration(
          color: color,
          borderRadius: bRadius,
          boxShadow: shadowEnabled ?? true
              ? [
                  BoxShadow(
                    color: color,
                    blurRadius: 2.0,
                    spreadRadius: 0.0,
                    offset: Offset(2.0, 2.0),
                  )
                ]
              : [],
        ),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          children: <Widget>[
            icon != null
                ? IconTheme(
                    child: icon,
                    data: IconThemeData(color: Colors.white),
                  )
                : Container(),
            SizedBox(width: text == null && subText == null ? 0 : 3),
            subText != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      text != null
                          ? Flexible(
                              child: _buildTitle,
                              fit: FlexFit.loose,
                            )
                          : Container(),
                      subText != null
                          ? Flexible(
                              child: _buildSubtitle,
                              fit: FlexFit.loose,
                            )
                          : Container(),
                    ],
                  )
                : text != null
                    ? _buildTitle
                    : Container(),
          ],
        ),
      ),
    );
  }

  Widget get _buildTitle => DefaultTextStyle(
        child: text,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      );

  Widget get _buildSubtitle => DefaultTextStyle(
        child: subText,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      );
}
