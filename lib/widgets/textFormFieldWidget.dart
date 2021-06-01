import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatefulWidget {
  final String labelText;
  final String hintText;
  final String helperText;
  final int helperMaxLines;
  final int maxLines;
  final int minLines;
  final Icon prefixIcon;
  final Widget suffixIcon;
  final bool readOnly;
  final double fontSizeStyle;
  final double fontSizeLabel;
  final double fontSizeHint;
  final bool obscureText;
  final AutovalidateMode autoValidateMode;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final Function validator;
  final Function onChanged;
  final Function onSaved;
  final String initialValue;
  final int maxLength;
  final FocusNode focusNode;
  final TextEditingController controller;

  const TextFormFieldWidget(
      {Key key,
      this.labelText,
      @required this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      this.readOnly,
      this.obscureText,
      @required this.textInputType,
      this.textInputAction,
      this.textCapitalization,
      this.fontSizeStyle,
      this.maxLength,
      this.focusNode,
      this.fontSizeLabel,
      this.fontSizeHint,
      this.validator,
      this.initialValue,
      this.autoValidateMode,
      this.onChanged,
      this.onSaved,
      this.helperText,
      this.helperMaxLines,
      this.controller,
      this.maxLines,
      this.minLines})
      : super(key: key);

  @override
  _TextFormFieldWidgetState createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;

    /**
     *
     */
    return TextFormField(
      focusNode: widget.focusNode,
      controller: widget.controller,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines ?? 1,
      keyboardType: widget.textInputType,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
      cursorColor: Theme.of(context).primaryColor,
      obscureText: widget.obscureText ?? false,
      readOnly: widget.readOnly ?? false,
      validator: widget.validator,
      autovalidateMode: widget.autoValidateMode,
      initialValue: widget.initialValue,
      onChanged: widget.onChanged,
      onSaved: widget.onSaved,
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: widget.fontSizeStyle ?? _screenWidth / 25,
      ),
      decoration: InputDecoration(
        helperText: widget.helperText,
        helperMaxLines: widget.helperMaxLines,
        helperStyle: TextStyle(
          fontSize: _screenWidth / 30,
          color: Theme.of(context).primaryColor,
        ),
        labelText: widget.labelText,
        labelStyle: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: widget.fontSizeLabel ?? _screenWidth / 25,
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: widget.fontSizeHint ?? _screenWidth / 25,
        ),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red[600], width: 2.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red[600], width: 2.0),
        ),
      ),
    );
  }
}
