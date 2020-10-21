import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  final double height;
  final double width;
  final String buttonText;
  final double fontSize;
  final double elevation;
  final Function onPressed;

  const ButtonWidget(
      {Key key,
      this.height,
      this.width,
      @required this.buttonText,
      this.fontSize,
      @required this.elevation,
      @required this.onPressed})
      : super(key: key);

  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    final _screenSizeWidth = MediaQuery.of(context).size.width;
    final _fontScaling = MediaQuery.of(context).textScaleFactor;

    /**
     * 
     */
    return Container(
      height: widget.height ?? _screenSizeWidth / 9,
      width: widget.width ?? _screenSizeWidth / 1.6,
      child: RaisedButton(
          elevation: widget.elevation,
          onPressed: widget.onPressed,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(_screenSizeWidth / 8),
                  bottomLeft: Radius.circular(_screenSizeWidth / 8))),
          padding: EdgeInsets.all(0.0),
          child: Ink(
            decoration: BoxDecoration(
                color: Theme.of(context).secondaryHeaderColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(_screenSizeWidth / 8),
                    bottomLeft: Radius.circular(_screenSizeWidth / 8)),
                border: Border.all(
                    color: Theme.of(context).secondaryHeaderColor, width: 1)),
            child: Container(
                constraints: BoxConstraints(
                    minWidth: _screenSizeWidth - 88.0, minHeight: 36.0),
                alignment: Alignment.center,
                child: Text(
                  widget.buttonText,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: widget.fontSize ?? _fontScaling / 0.07),
                  textAlign: TextAlign.center,
                )),
          )),
    );
  }
}
