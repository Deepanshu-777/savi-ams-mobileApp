import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

Widget customBackButton({
  Color? color,
  EdgeInsetsGeometry? padding = const EdgeInsets.only(
    left: 25,
    right: 25,
    top: 10,
    bottom: 10,
  ),
  void Function()? onTap,
}) {
  return GestureDetector(
    onTap: onTap ?? () => Get.back(),
    child: Container(
      color: Colors.transparent,
      padding: padding,
      child: SvgPicture.asset(
        "assets/images/svg_img/arrow_left.svg",
        color: color,
      ),
    ),
  );
}
