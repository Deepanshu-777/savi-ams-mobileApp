import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

Widget decoratedBox({
  List<Widget> children = const <Widget>[],
  EdgeInsetsGeometry? padding,
  double width = 20,
}) {
  return Expanded(
    child: Container(
      width: width,
      padding: padding ??
          EdgeInsets.only(
            top: 5,
            left: width * 0.055,
            right: width * 0.055,
          ),
      decoration: const BoxDecoration(
        color: AppColors.whiteBg,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    ),
  );
}
