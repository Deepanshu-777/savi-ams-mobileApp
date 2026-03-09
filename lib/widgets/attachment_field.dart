import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rail_weld/app/response_team_module/res_machine_details/res_machine_details_controller.dart';
import 'package:rail_weld/app/ssc_modules/add_machine/add_machine_controller.dart';
import 'package:rail_weld/app/ssc_modules/machine_details/machine_details_controller.dart';
import 'package:rail_weld/widgets/image_picker_bottomsheet.dart';
import '../storage/storage.dart';
import '../theme/app_colors.dart';
import 'custom_sized_box.dart';
import 'custom_text.dart';

Widget attachmentField({
  double width = 20,
  String title = "Attachment",
  required RxList<String> localImagePath,
  required RxList<String> base64Image,
  bool isSingleSelect = false,
  double fontSize = 14,
  bool isMachineDetail = false,
  Widget? widget,
}) {
  return GestureDetector(
    onTap: () => Get.bottomSheet(
      imagePickerBottomsheet(
        label: "Choose Photos",
        onCamera: () {
          if (isMachineDetail) {
            String? role = Storage.getRole();
            if (role == "3" || role == "1") {
              if (Get.isRegistered<MachineDetailsController>()) {
                MachineDetailsController machineDetailsController =
                    Get.find<MachineDetailsController>();
                machineDetailsController.takePhoto(
                  base64Image: base64Image,
                  localImagePath: localImagePath,
                );
              }
            } else {
              if (Get.isRegistered<ResMachineDetailsController>()) {
                ResMachineDetailsController machineDetailsController =
                    Get.find<ResMachineDetailsController>();
                machineDetailsController.takePhoto(
                  base64Image: base64Image,
                  localImagePath: localImagePath,
                );
              }
            }
          } else {
            AddMachineController controller = Get.find<AddMachineController>();
            isSingleSelect
                ? controller.singlePhotoSelect(ImageSource.camera)
                : controller.takePhoto(
                    base64Image: base64Image,
                    localImagePath: localImagePath,
                  );
          }
          Get.back();
        },
        onGallary: () {
          if (isMachineDetail) {
            String? role = Storage.getRole();
            if (role == "3" || role == "1") {
              if (Get.isRegistered<MachineDetailsController>()) {
                MachineDetailsController machineDetailsController =
                    Get.find<MachineDetailsController>();
                machineDetailsController.selectAttachment(
                  base64Image: base64Image,
                  localImagePath: localImagePath,
                );
              }
            } else {
              if (Get.isRegistered<ResMachineDetailsController>()) {
                ResMachineDetailsController machineDetailsController =
                    Get.find<ResMachineDetailsController>();
                machineDetailsController.selectAttachment(
                  base64Image: base64Image,
                  localImagePath: localImagePath,
                );
              }
            }
          } else {
            AddMachineController controller = Get.find<AddMachineController>();
            isSingleSelect
                ? controller.singlePhotoSelect(ImageSource.gallery)
                : controller.selectAttachment(
                    base64Image: base64Image,
                    localImagePath: localImagePath,
                  );
          }
          Get.back();
        },
      ),
    ),
    // onTap: () => controller.selectAttachment(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        mediumText(
          title: title,
          fontWeight: FontWeight.w600,
          fontColor: AppColors.black,
          fontSize: fontSize,
        ),
        customSizedBox(height: 10),
        Obx(() {
          RxList<String> selectedImage = localImagePath;
          return (localImagePath.length != 0 || isSingleSelect)
              ? Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  runSpacing: 15,
                  spacing: 10,
                  children: List<Widget>.generate(
                    isSingleSelect ? 1 : selectedImage.length,
                    (index) => Stack(
                      children: [
                        Container(
                          height: 100,
                          width: width * 0.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              width: 0.7,
                              color: AppColors.black,
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(
                                isSingleSelect
                                    ? File(
                                        Get.find<AddMachineController>()
                                            .machineLocalFiles
                                            .value,
                                      )
                                    : File(
                                        selectedImage[index],
                                      ),
                              ),
                            ),
                          ),
                          child: (selectedImage[index].contains("png") ||
                                  selectedImage[index].contains("jpg") ||
                                  selectedImage[index].contains("webp"))
                              ? const SizedBox()
                              : Icon(Icons.file_copy),
                        ),
                        widget ?? const SizedBox()
                      ],
                    ),
                    growable: true,
                  ),
                )
              : Container(
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
                      smallText(
                        title: "No File Selected",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontColor: AppColors.offWhite,
                      ),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xFFF0F0F0),
                        ),
                        child: smallText(
                          title: "Choose File",
                          fontColor: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                );
        }),
        customSizedBox(height: 10),
      ],
    ),
  );
}
