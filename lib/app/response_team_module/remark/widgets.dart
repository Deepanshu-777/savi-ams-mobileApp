import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rail_weld/widgets/title_text_field.dart';
import '../../../model/scc_module_models/issue_code_model.dart';
import '../../../routes/img_routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_sized_box.dart';
import '../../../widgets/custom_text.dart';

Widget tickUntick({
  IssueCodeList? issue,
  double height = 20,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      smallText(
        title: "${issue?.issueCode} ( ${issue?.partName} )",
        fontColor: AppColors.black,
      ),
      customSizedBox(height: 8),
      smallText(
        title: issue?.description ?? "",
        fontWeight: FontWeight.w300,
        fontColor: const Color(
          0xFF848484,
        ),
      ),
      customSizedBox(height: 20),
      Obx(
        () => Row(
          children: [
            GestureDetector(
              onTap: () {
                issue?.isSelected?.value = 1;
              },
              child: SvgPicture.asset(
                (issue?.isSelected?.value == 1)
                    ? ImgRoutes.TICK
                    : ImgRoutes.UNTICK,
              ),
            ),
            customSizedBox(width: 12),
            GestureDetector(
              onTap: () {
                issue?.isSelected?.value = 0;
              },
              child: SvgPicture.asset(
                (issue?.isSelected?.value == 0)
                    ? ImgRoutes.REDCROSS
                    : ImgRoutes.GREYCROSS,
              ),
            ),
            customSizedBox(width: 12),
          ],
        ),
      ),
      customSizedBox(height: 30),
      Obx(
        () {
          return issue?.isSelected?.value == 0
              ? titleTextField(
                  controller: issue?.controller ?? TextEditingController(),
                  hintText: "Describe the issue",
                  title: "Remark",
                  expands: true,
                  height: height * 0.15,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                )
              : const SizedBox();
        },
      )
    ],
  );
}
