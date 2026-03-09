import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rail_weld/widgets/custom_sized_box.dart';
import '../../../../data/strings.dart';
import '../../../../routes/img_routes.dart';
import '../../../../theme/app_colors.dart';
import '../../../../widgets/custom_text.dart';

class SortBottomSheet extends StatelessWidget {
  void Function()? onAsc;
  void Function()? onDesc;
  bool sortByTitle;
  SortBottomSheet({
    super.key,
    this.sortByTitle = false,
    required this.onAsc,
    required this.onDesc,
  });

  @override
  Widget build(BuildContext context) {
    // TotalMachinesController controller = Get.find<TotalMachinesController>();
    return Container(
      padding: const EdgeInsets.only(
        top: 20,
        left: 24,
        bottom: 39,
        right: 24,
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              largeText(
                title: "Sort By",
                fontSize: 22,
                fontWeight: FontWeight.w600,
                fontColor: AppColors.black,
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.all(20),
                  child: SvgPicture.asset(ImgRoutes.CROSS),
                ),
              ),
            ],
          ),
          customSizedBox(height: 20),
          GestureDetector(
            onTap: onDesc,
            child: Row(
              children: [
                smallText(
                  title: "New To Old",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontColor: AppColors.black,
                ),
                customSizedBox(width: 21),
                smallText(
                  title: Strings.DOC,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  fontColor: AppColors.grey,
                ),
              ],
            ),
          ),
          customSizedBox(height: 27),
          GestureDetector(
            onTap: onAsc,
            child: Row(
              children: [
                smallText(
                  title: "Old To New",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontColor: AppColors.black,
                ),
                customSizedBox(width: 21),
                smallText(
                  title: Strings.DOC,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  fontColor: AppColors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
