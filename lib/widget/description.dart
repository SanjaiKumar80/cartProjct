import 'package:cart/common/constants.dart';
import 'package:cart/widget/unit_text.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TitleAndDescription extends StatelessWidget {
  final String? title;
  final String? desc;
  final String? unit;
  final Color? descColor;
  final double? containerWidth;

  const TitleAndDescription({
    Key? key,
    this.title,
    this.desc,
    this.unit,
    this.descColor,
    this.containerWidth,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 8, top: 8),
              child: Text(
                title.toString(),
                style: const TextStyle(
                  color: cardTitleColor,
                  fontSize: fontSize12,
                  fontWeight: fontWeight300,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            desc != null
                ? LabelWithUnitWrapper(
                    label: desc,
                    unit: unit,
                    labelColor: (descColor ?? cardDescColor),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
