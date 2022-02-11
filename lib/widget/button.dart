// ignore_for_file: prefer_const_constructors

import 'package:cart/common/constants.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String? title;

  final VoidCallback? onTap;

  const Button({
    Key? key,
    this.title,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          const BoxConstraints(maxWidth: 300, minWidth: 120, minHeight: 50),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: TextButton(
          style: ButtonStyle(
            overlayColor:
                MaterialStateColor.resolveWith((states) => secondaryColor),
            backgroundColor: MaterialStateProperty.all(secondaryTextColor),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                side: BorderSide(color: secondaryTextColor, width: 2),
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
          onPressed: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              title!,
              style: TextStyle(
                color: secondaryColor,
                fontSize: 14,
                fontWeight: fontWeight600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
