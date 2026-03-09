import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rail_weld/widgets/attachment_field.dart';
import 'package:rail_weld/widgets/title_text_field.dart';
import '../routes/img_routes.dart';
import '../theme/app_colors.dart';
import 'custom_elevated_button.dart';
import 'custom_sized_box.dart';
import 'custom_text.dart';

Future<void> popUp({
  Widget? widget,
  bool isRemark = false,
  bool isAttachment = false,
  bool isMultiButton = false,
  double height = 20,
  TextEditingController? remarkController,
  String title = "Maintenance Done!",
  bool isButton = true,
  required void Function() onPressed,
  void Function()? onTicketReject,
  String imageRoute = ImgRoutes.DONEICON,
  bool isDatePicker = false,
  void Function()? onDatePicker,
  RxString? selectedDate,
  double width = 20,
  String content =
      "Ticket has been Successfully resolved. It has been sent for approval.",
  String buttonTitle = "Download Report",
  bool isEditMaintenance = false,
  bool isMachineDetail = false,
  bool barrierDismissible = true,
  RxList<String>? base64Image,
  RxList<String>? localImagePath,
}) async {
  return showDialog(
    barrierDismissible: barrierDismissible,
    context: Get.context!,
    builder: (context) => AlertDialog(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 33,
        vertical: 31,
      ),
      surfaceTintColor: AppColors.white,
      backgroundColor: AppColors.white,
      scrollable: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(imageRoute),
          customSizedBox(height: 11),
          largeText(
            title: title,
            fontWeight: FontWeight.w600,
            fontColor: AppColors.navyBlue,
            fontSize: 20,
            textAlign: TextAlign.center,
          ),
          customSizedBox(height: 17),
          smallText(
            title: content,
            fontSize: 14,
            fontColor: AppColors.black,
            textAlign: TextAlign.center,
          ),
          customSizedBox(height: 10),
          (isDatePicker && !isRemark)
              ? Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        mediumText(
                          title: "Select Date",
                          fontWeight: FontWeight.w400,
                          fontColor: AppColors.black,
                          fontSize: 12,
                        ),
                        customSizedBox(height: 10),
                        GestureDetector(
                          onTap: onDatePicker,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 21,
                              vertical: 15,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppColors.offWhite,
                                width: 1.5,
                              ),
                            ),
                            child: Row(
                              children: [
                                Obx(
                                  () {
                                    String date = selectedDate?.value == ""
                                        ? "Select Date"
                                        : selectedDate?.value ?? "";
                                    return smallText(
                                      title: date,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      fontColor: date == "Select Date"
                                          ? AppColors.offWhite
                                          : AppColors.black,
                                    );
                                  },
                                ),
                                const Spacer(),
                                SvgPicture.asset(ImgRoutes.CALENDER)
                              ],
                            ),
                          ),
                        ),
                        customSizedBox(height: 10),
                      ],
                    ),
                    customSizedBox(height: 20),
                    titleTextField(
                      controller: remarkController ?? TextEditingController(),
                      hintText: "Enter Your Opinion",
                      title: "Remark",
                      titleFontSize: 12,
                      expands: true,
                      height: height * 0.15,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      validator: (val) {
                        if (val?.isEmpty ?? true) {
                          return "Description is required";
                        }
                        return null;
                      },
                    ),
                  ],
                )
              : isRemark
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        isAttachment
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customSizedBox(height: 20),
                                  attachmentField(
                                    base64Image: base64Image ?? <String>[].obs,
                                    localImagePath:
                                        localImagePath ?? <String>[].obs,
                                    width: width,
                                    fontSize: 12,
                                    isMachineDetail: isMachineDetail,
                                    widget: widget,
                                  ),
                                ],
                              )
                            : const SizedBox(),
                        customSizedBox(height: 20),
                        titleTextField(
                          controller:
                              remarkController ?? TextEditingController(),
                          hintText: "Enter Your Opinion",
                          title: "Remark",
                          titleFontSize: 12,
                          expands: true,
                          height: height * 0.15,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          validator: (val) {
                            if (val?.isEmpty ?? true) {
                              return "Description is required";
                            }
                            return null;
                          },
                        ),
                      ],
                    )
                  : isEditMaintenance
                      ? Column(
                          children: [
                            customSizedBox(height: 20),
                            titleTextField(
                              controller:
                                  remarkController ?? TextEditingController(),
                              hintText: "Enter ",
                              title: "Enter Number Of Month",
                              titleFontSize: 12,
                              maxLines: 1,
                              keyboardType: TextInputType.number,
                              validator: (val) {
                                if (val?.isEmpty ?? true) {
                                  return "Month count is required";
                                }
                                return null;
                              },
                            ),
                          ],
                        )
                      : const SizedBox(),
          isButton
              ? customElevatedButton(
                  onPressed: onPressed,
                  fontSize: 14,
                  title: buttonTitle,
                  padding: EdgeInsets.symmetric(
                    vertical: 13,
                    horizontal: 28,
                  ),
                  bgColor: AppColors.navyBlue,
                )
              : isMultiButton
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: width * 0.27,
                            child: customElevatedButton(
                              bgColor: AppColors.lightRed,
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              onPressed: onTicketReject ?? () {},
                              title: "Reject",
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontColor: AppColors.red,
                            ),
                          ),
                          SizedBox(
                            width: width * 0.27,
                            child: customElevatedButton(
                              bgColor: AppColors.navyBlue,
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              onPressed: onPressed,
                              title: buttonTitle,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        Get.back();
                        Get.back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Back to Tickets",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.navyBlue,
                            fontFamily: "Outfit",
                          ),
                        ),
                      ),
                    ),
        ],
      ),
    ),
  );
}

Future<void> ticketResolveCostPopup({
  required String title,
  required String content,
  required void Function() onPressed,
  required TextEditingController remarkController,
  required TextEditingController repairCostController,
  double height = 20,
  String buttonTitle = "Submit",
  String imageRoute = ImgRoutes.ACKNOWLEDGED,
}) async {
  return showDialog(
    context: Get.context!,
    builder: (context) => AlertDialog(
      contentPadding: const EdgeInsets.symmetric(horizontal: 33, vertical: 31),
      surfaceTintColor: AppColors.white,
      backgroundColor: AppColors.white,
      scrollable: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(imageRoute),
          customSizedBox(height: 11),
          largeText(
            title: title,
            fontWeight: FontWeight.w600,
            fontColor: AppColors.navyBlue,
            fontSize: 20,
            textAlign: TextAlign.center,
          ),
          customSizedBox(height: 17),
          smallText(
            title: content,
            fontSize: 14,
            fontColor: AppColors.black,
            textAlign: TextAlign.center,
          ),
          customSizedBox(height: 20),
          titleTextField(
            controller: remarkController,
            hintText: "Enter your remark",
            title: "Remark",
            titleFontSize: 12,
            expands: true,
            height: height * 0.15,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            validator: (val) {
              if (val?.trim().isEmpty ?? true) {
                return "Remark is required";
              }
              return null;
            },
          ),
          customSizedBox(height: 20),
          titleTextField(
            controller: repairCostController,
            hintText: "Enter repair cost",
            title: "Repair Cost (₹)",
            titleFontSize: 12,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            validator: (val) {
              if (val?.trim().isEmpty ?? true) {
                return "Repair cost is required";
              }
              final cost = double.tryParse(val!);
              if (cost == null || cost < 0) {
                return "Enter a valid amount";
              }
              return null;
            },
          ),
          customSizedBox(height: 30),
          customElevatedButton(
            onPressed: onPressed,
            fontSize: 14,
            title: buttonTitle,
            padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 28),
            bgColor: AppColors.navyBlue,
          ),
        ],
      ),
    ),
  );
}
