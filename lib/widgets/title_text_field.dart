import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import 'custom_sized_box.dart';
import 'custom_text.dart';
import 'custom_text_field.dart';

Widget titleTextField({
  required TextEditingController controller,
  required String title,
  required String hintText,
  bool expands = false,
  bool isBorder = true,
  int? maxLines = 1,
  double? height,
  TextInputType? keyboardType,
  bool isSuffix = false,
  bool isReadOnly = false,
  String? Function(String?)? validator,
  Color errorTextColor = AppColors.red,
  double titleFontSize = 14,
  List<TextInputFormatter>? inputFormatters,
  bool isSuffixText = false,
  String suffixText = "",
  ValueChanged<String>? onChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      mediumText(
        title: title,
        fontWeight: FontWeight.w600,
        fontColor: AppColors.black,
        fontSize: titleFontSize,
      ),
      customSizedBox(height: 12),
      customTextField(
        onChanged: onChanged,
        validator: validator,
        controller: controller,
        isReadOnly: isReadOnly,
        hintText: hintText,
        isSuffix: isSuffix,
        isBorder: isBorder,
        expands: expands,
        height: height,
        errorTextColor: errorTextColor,
        maxLines: maxLines,
        keyboardType: keyboardType,
        isSuffixText: isSuffixText,
        suffixText: suffixText,
        inputFormatters: inputFormatters,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.offWhite,
            width: 1.5,
          ),
        ),
      ),
      customSizedBox(height: 25),
    ],
  );
}
