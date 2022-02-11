// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors

import 'package:cart/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CartTextBox extends StatelessWidget {
  final bool withAsterisk;
  final String? labelText;
  final String? hintText;
  final String? initialValue;
  final FocusNode? currentFocusNode;
  final Function? onSaved;
  final Function? onError;
  final Function? onChanged;
  final Function? onFieldSubmitted;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final VoidCallback? suffixIconEvent;
  final IconData? suffixIcon;
  final bool readOnly;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatter;
  final TextEditingController? fieldController;
  final int? maxLength;
  final double? fontSize;

  const CartTextBox({
    Key? key,
    this.withAsterisk = false,
    this.labelText,
    this.hintText,
    this.initialValue,
    this.currentFocusNode,
    this.onSaved,
    this.onError,
    this.onChanged,
    this.onFieldSubmitted,
    this.textInputAction,
    this.textInputType,
    this.suffixIconEvent,
    this.suffixIcon,
    this.readOnly = false,
    this.obscureText = false,
    this.inputFormatter,
    this.fieldController,
    this.fontSize,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var inputDecoration = InputDecoration(
      border: const UnderlineInputBorder(
        borderSide: BorderSide(
          width: 8,
          style: BorderStyle.none,
        ),
      ),
      fillColor: transparentColor,
      filled: true,
      enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
        width: 0.3,
        color: minMaxTextColor,
      )),
      focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: minMaxTextColor)),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.red.shade300),
      ),
      focusColor: primaryColor,
      hoverColor: transparentColor,
      contentPadding: EdgeInsetsGeometry.lerp(
        EdgeInsets.zero,
        EdgeInsets.only(left: 0, top: 8),
        2.0,
      ),
      hintText: hintText,
      errorStyle: TextStyle(
        fontSize: fontSize12,
        color: Colors.red.shade300,
      ),
      suffixIcon: suffixIcon != null
          ? IconButton(
              icon: Icon(suffixIcon, color: minMaxTextColor),
              onPressed: suffixIconEvent,
            )
          : SizedBox.shrink(),
      hintStyle: TextStyle(
        fontSize: fontSize12,
        color: readOnly ? weightTextColor : placeHolderTextColor,
      ),
    );

    return Stack(
      children: [
        CartLabelText(
          text: labelText == null ? "" : labelText!,
          withAsterisk: withAsterisk,
          fontSize: fontSize,
        ),
        Container(
          margin: EdgeInsets.only(top: 12),
          height: 75,
          child: TextFormField(
            maxLength: maxLength,
            controller: fieldController ?? null,
            inputFormatters: inputFormatter,
            obscureText: obscureText,
            initialValue: initialValue ?? null,
            cursorColor: minMaxTextColor,
            cursorRadius: const Radius.circular(10),
            decoration: inputDecoration,
            textInputAction: textInputAction,
            keyboardType: textInputType,
            focusNode: currentFocusNode,
            readOnly: readOnly ? true : false,
            onFieldSubmitted: (value) {
              if (onFieldSubmitted != null) onFieldSubmitted!(value);
            },
            onChanged: (value) {
              if (onChanged != null) onChanged!(value);
            },
            onSaved: (value) {
              if (onSaved != null) onSaved!(value);
            },
            validator: (value) {
              if (onError != null) return onError!(value);
              return null;
            },
          ),
        ),
      ],
    );
  }
}

class CartLabelText extends StatelessWidget {
  CartLabelText({this.withAsterisk = false, required this.text, this.fontSize});

  bool withAsterisk = false;
  String text;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: text,
                style: TextStyle(
                    fontSize: fontSize ?? fontSize14, color: weightTextColor),
              ),
              TextSpan(
                  text: withAsterisk ? ' * ' : ' ',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: fontSize12,
                      backgroundColor: transparentColor,
                      color: Colors.red)),
            ],
          ),
        ),
      ],
    );
  }
}
