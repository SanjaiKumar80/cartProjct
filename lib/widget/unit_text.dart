import 'package:cart/common/constants.dart';

import 'package:flutter/material.dart';

class LabelWithUnitWrapper extends StatelessWidget {
  final String? label;
  final String? unit;
  final Color? labelColor;
  final Color? unitColor;

  const LabelWithUnitWrapper({
    Key? key,
    this.label,
    this.unit,
    this.labelColor,
    this.unitColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: RichText(
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            children: [
              if (unit != null)
                TextSpan(
                  text: ' $unit',
                  style: TextStyle(
                    color: unitColor ?? secondaryTextColor,
                    fontSize: fontSize13,
                  ),
                ),
              TextSpan(
                text: label.toString(),
                style: TextStyle(
                    color: labelColor ?? minMaxTextColor,
                    fontSize: fontSize14,
                    fontWeight: fontWeight600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
