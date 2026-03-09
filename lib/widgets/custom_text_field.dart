import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rail_weld/widgets/custom_text.dart';
import '../routes/img_routes.dart';
import '../theme/app_colors.dart';

Widget customTextField({
  required TextEditingController controller,
  required String hintText,
  bool isBorder = false,
  bool expands = false,
  int? maxLines = 1,
  double? height,
  TextInputType? keyboardType,
  InputBorder? enabledBorder,
  double verticalPadding = 19,
  bool isSuffix = false,
  String? Function(String?)? validator,
  bool isReadOnly = false,
  bool obscureText = false,
  Color errorTextColor = AppColors.white,
  Widget? suffix,
  List<TextInputFormatter>? inputFormatters,
  bool isSuffixText = false,
  String suffixText = "",
  ValueChanged<String>? onChanged,
}) {
  return SizedBox(
    height: height,
    child: TextFormField(
      onChanged: onChanged,
      obscureText: obscureText,
      readOnly: isReadOnly,
      validator: validator,
      textAlignVertical: TextAlignVertical.top,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      expands: expands,
      maxLines: maxLines,
      controller: controller
        ..selection = TextSelection.collapsed(
          offset: controller.text.length,
        ),
      cursorColor: AppColors.navyBlue,
      decoration: InputDecoration(
        suffixIcon: suffix,
        suffix: isSuffix
            ? SvgPicture.asset(
                ImgRoutes.EDIT,
                width: 20,
                height: 17,
              )
            : isSuffixText
                ? smallText(
                    title: suffixText,
                    fontColor: AppColors.black,
                  )
                : null,
        enabledBorder: enabledBorder,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: verticalPadding,
        ),
        fillColor: AppColors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamily: "Outfit",
          color: AppColors.offWhite,
        ),
        focusedErrorBorder: null,
        errorStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamily: "Outfit",
          color: errorTextColor,
        ),
      ),
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontFamily: "Outfit",
      ),
    ),
  );
}

Widget customTextFieldNoBorder({
  required TextEditingController controller,
  required String hintText,
  bool expands = false,
  int? maxLines = 1,
  TextInputType? keyboardType,
  InputBorder? enabledBorder,
  bool isReadOnly = false,
  bool obscureText = false,
  Color errorTextColor = AppColors.white,
  Widget? suffix,
  List<TextInputFormatter>? inputFormatters,
  bool removeBorder = true,
}) {
  return TextFormField(
    obscureText: obscureText,
    readOnly: isReadOnly,
    keyboardType: keyboardType,
    inputFormatters: inputFormatters,
    expands: expands,
    maxLines: maxLines,
    controller: controller
      ..selection = TextSelection.collapsed(offset: controller.text.length),
    cursorColor: AppColors.navyBlue,
    decoration: InputDecoration(
      enabledBorder: removeBorder ? InputBorder.none : enabledBorder,
      fillColor: AppColors.white,
      filled: true,
      border: InputBorder.none,
      hintText: hintText,
      hintStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontFamily: "Outfit",
        color: AppColors.offWhite,
      ),
      errorStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontFamily: "Outfit",
        color: errorTextColor,
      ),
    ),
    style: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontFamily: "Outfit",
    ),
  );
}
