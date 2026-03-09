import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rail_weld/routes/img_routes.dart';
import 'package:rail_weld/theme/app_colors.dart';
import 'package:rail_weld/widgets/custom_sized_box.dart';

Widget customElevatedButton({
  BorderSide? border = BorderSide.none,
  required VoidCallback onPressed,
  required String title,
  Color fontColor = AppColors.white,
  Color bgColor = AppColors.lightBlue,
  EdgeInsetsGeometry? padding = const EdgeInsets.symmetric(
    horizontal: 55,
    vertical: 12,
  ),
  double? fontSize = 16,
  FontWeight? fontWeight = FontWeight.w500,
  bool isWidget = false,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      elevation: 0,
      padding: padding,
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: border ?? BorderSide.none,
      ),
    ),
    child: isWidget
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(ImgRoutes.REOPEN),
              customSizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  color: fontColor,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  fontFamily: "Outfit",
                ),
              ),
            ],
          )
        : Text(
            title,
            style: TextStyle(
              color: fontColor,
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontFamily: "Outfit",
            ),
          ),
  );
}

Widget customElevatedButtonIcon({
  BorderSide? border = BorderSide.none,
  required VoidCallback onPressed,
  required String title,
  Color fontColor = AppColors.white,
  Color bgColor = AppColors.lightBlue,
  EdgeInsetsGeometry? padding =
      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
  double? fontSize = 16,
  FontWeight? fontWeight = FontWeight.w500,
  bool isWidget = false,
  Widget? icon,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      elevation: 0,
      padding: padding,
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: border ?? BorderSide.none,
      ),
    ),
    child: isWidget && icon != null
        ? FittedBox(
            // Prevent overflow by fitting the content
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                icon,
                SizedBox(width: 6),
                Text(
                  title,
                  style: TextStyle(
                    color: fontColor,
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    fontFamily: "Outfit",
                  ),
                ),
              ],
            ),
          )
        : Text(
            title,
            style: TextStyle(
              color: fontColor,
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontFamily: "Outfit",
            ),
          ),
  );
}
