import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rail_weld/app/ssc_modules/add_machine/add_machine_controller.dart';
import 'package:rail_weld/data/strings.dart';
import 'package:rail_weld/model/scc_module_models/get_category_list.dart';
import 'package:rail_weld/model/scc_module_models/get_fac_list.dart';
import 'package:rail_weld/model/scc_module_models/get_make_list.dart';
import 'package:rail_weld/model/scc_module_models/get_plant_code_list.dart';
import 'package:rail_weld/routes/img_routes.dart';
import 'package:rail_weld/theme/app_colors.dart';
import 'package:rail_weld/widgets/custom_text.dart';
import 'package:rail_weld/widgets/image_picker_bottomsheet.dart';
import '../../../model/scc_module_models/get_vendor_list.dart';
import '../../../model/scc_module_models/shop_list_model.dart';
import '../../../widgets/custom_sized_box.dart';
import '../../../widgets/dropdown_dialog.dart';
import '../main_view/total_machines/filter_screen.dart';

Widget formStatus({
  String title = "NECESSARY\nDETAILS",
  String img = ImgRoutes.ENABLEDDONE,
  Color fontColor = AppColors.black,
}) {
  return Container(
    color: Colors.transparent,
    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
    child: Row(
      children: [
        SvgPicture.asset(img),
        customSizedBox(width: 4),
        mediumText(
          title: title,
          fontSize: 10,
          fontWeight: FontWeight.w500,
          fontColor: fontColor,
          height: 1.2,
        ),
      ],
    ),
  );
}

Widget dateTextField({
  String title = "",
  bool iconAgainstTitle = false,
  bool updateNoOfYears = false,
  Widget? widget,
  required RxString selectedDate,
  DateTime? lastDate,
  Color unselectedColor = AppColors.red,
}) {
  AddMachineController controller = Get.find<AddMachineController>();
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            mediumText(
              title: title,
              fontWeight: FontWeight.w600,
              fontColor: AppColors.black,
              fontSize: 14,
            ),
            SizedBox(
              width: 5,
            ),
            if (widget != null)
              GestureDetector(
                child: widget,
              )
          ],
        ),
        customSizedBox(height: 12),
        GestureDetector(
          onTap: () async {
            await controller.selectDate(
              selectedDate: selectedDate,
              lastDate: lastDate,
            );

            if (updateNoOfYears) {
              controller.calculateNoOfYearsMachineInUse(selectedDate.value);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 21,
              vertical: 18,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.offWhite,
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                Obx(() {
                  String date = selectedDate.value == ""
                      ? "Select Date"
                      : selectedDate.value;
                  return smallText(
                    title: date,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: date == "Select Date"
                        ? unselectedColor
                        : AppColors.black,
                  );
                }),
                const Spacer(),
                SvgPicture.asset(ImgRoutes.CALENDER)
              ],
            ),
          ),
        ),
        customSizedBox(height: 25),
      ],
    ),
  );
}

Widget categoryListing({
  double height = 20,
  double width = 20,
}) {
  AddMachineController controller = Get.find<AddMachineController>();
  return Obx(
    () {
      List<CategoryList>? categoryList =
          controller.categoryList.value.data?.categoryList;
      return Obx(() {
        String? machineType = controller.machineType.value;
        return dialogList(
          bgColor: AppColors.white,
          dialogLabel: "Select Category/Type",
          titleFontSize: 14,
          fontWeight: FontWeight.w600,
          height: height,
          width: width,
          title: "Category/Type of ${machineType}",
          hintText: "Select",
          length: categoryList?.length ?? 0,
          textFieldTitle: Obx(
            () => smallText(
              title: controller.categoryName.value,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontColor:
                  categoryList?.length == 0 ? AppColors.red : AppColors.black,
            ),
          ),
          list: (context, index) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(
                  () => shopCard(
                    title: "${categoryList?[index].name}",
                    onTap: () {
                      controller.categoryId.value =
                          categoryList?[index].id ?? 0;
                      controller.categoryName.value =
                          categoryList?[index].name ?? "";
                      if (controller.categoryName.value.toLowerCase() ==
                          "other") {
                        controller.isOtherCategorySelected.value = true;
                      } else {
                        controller.isOtherCategorySelected.value = false;
                        controller.other_category_name.clear();
                      }
                      Get.back();
                    },
                    isSelected:
                        controller.categoryId.value == categoryList?[index].id,
                  ),
                ),
              ],
            );
          },
        );
      });
    },
  );
}

Widget facListing({
  double height = 20,
  double width = 20,
}) {
  AddMachineController controller = Get.find<AddMachineController>();
  return Obx(
    () {
      List<FacList>? facList = controller.facList.value.data?.facList;
      return dialogList(
        bgColor: AppColors.white,
        dialogLabel: "Fund Allocation Code",
        titleFontSize: 14,
        fontWeight: FontWeight.w600,
        height: height,
        width: width,
        title: "Fund Allocation Code",
        hintText: "Select",
        length: facList?.length ?? 0,
        textFieldTitle: Obx(
          () => smallText(
            title: controller.facName.value,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontColor: facList?.length == 0 ? AppColors.red : AppColors.black,
          ),
        ),
        list: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => shopCard(
                  title: "${facList?[index].name}",
                  onTap: () {
                    controller.facId.value = facList?[index].id ?? 0;
                    controller.facName.value = facList?[index].name ?? "";
                    if (controller.facName.value.toLowerCase() == "other") {
                      controller.isOtherFacSelected.value = true;
                    } else {
                      controller.isOtherFacSelected.value = false;
                      controller.other_fac_name.clear();
                    }
                    Get.back();
                  },
                  isSelected: controller.facId.value == facList?[index].id,
                ),
              ),
            ],
          );
        },
      );
    },
  );
}

Widget makeListing({
  double height = 20,
  double width = 20,
}) {
  AddMachineController controller = Get.find<AddMachineController>();
  return Obx(
    () {
      List<MakeList>? makeList = controller.makeList.value.data?.makeList;
      return dialogList(
        bgColor: AppColors.white,
        dialogLabel: "Select Make",
        titleFontSize: 14,
        fontWeight: FontWeight.w600,
        height: height,
        width: width,
        title: "Make",
        hintText: "Select",
        length: makeList?.length ?? 0,
        textFieldTitle: Obx(
          () => smallText(
            title: controller.makeName.value,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontColor: makeList?.length == 0 ? AppColors.red : AppColors.black,
          ),
        ),
        list: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => shopCard(
                  title: "${makeList?[index].name}",
                  onTap: () {
                    controller.makeId.value = makeList?[index].id ?? 0;
                    controller.makeName.value = makeList?[index].name ?? "";
                    if (controller.makeName.value.toLowerCase() == "other") {
                      controller.isOtherMakeSelected.value = true;
                    } else {
                      controller.isOtherMakeSelected.value = false;
                      controller.other_make_name.clear();
                    }
                    Get.back();
                  },
                  isSelected: controller.makeId.value == makeList?[index].id,
                ),
              ),
            ],
          );
        },
      );
    },
  );
}

Widget plantCodeListing() {
  AddMachineController controller = Get.find<AddMachineController>();
  return Obx(
    () {
      List<PlantsCodeList>? plantCodeList =
          controller.plantCodeList.value.data?.plantsCodeList;
      return dialogList(
        padding: EdgeInsets.zero,
        hasborder: false,
        dialogLabel: "Select Plant Code",
        titleFontSize: 14,
        fontWeight: FontWeight.w600,
        title: "Plant Code",
        hintText: "Select",
        hasTitle: false,
        length: plantCodeList?.length ?? 0,
        textFieldTitle: Obx(
          () => smallText(
            title: controller.plantCodeName.value,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontColor: controller.selectedPlantCode.value == ""
                ? AppColors.offWhite
                : AppColors.black,
          ),
        ),
        list: (context, index) {
          return Obx(
            () => shopCard(
              title: "${plantCodeList?[index].code}",
              onTap: () {
                controller.selectedPlantCode.value =
                    plantCodeList?[index].code ?? "";
                controller.plantCodeName.value =
                    plantCodeList?[index].code ?? "";
                Get.back();
              },
              isSelected: controller.selectedPlantCode.value ==
                  plantCodeList?[index].code,
            ),
          );
        },
      );
    },
  );
}

Widget underAMCDialog({
  double height = 20,
  double width = 20,
}) {
  AddMachineController controller = Get.find<AddMachineController>();
  return dialogList(
    bgColor: AppColors.white,
    dialogLabel: Strings.AMCWARRANTY,
    titleFontSize: 14,
    fontWeight: FontWeight.w600,
    height: height,
    width: width,
    title: Strings.AMCWARRANTY,
    hintText: "Select",
    length: 3,
    textFieldTitle: Obx(
      () => smallText(
        title: controller.amcWarrantyName.value,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontColor: controller.amcWarrantyName.value == "Select"
            ? AppColors.red
            : AppColors.black,
      ),
    ),
    list: (context, index) {
      List<String> val = [
        Strings.UNDERAMC,
        Strings.UNDERWARRANTY,
        Strings.UNDERMW,
      ];
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(
            () => shopCard(
              title: "${val[index]}",
              onTap: () {
                controller.changeAMCStatus(val[index]);
                controller.amcWarrantyName.value = val[index];
                Get.back();
              },
              isSelected: controller.amcWarrantyName.value == val[index],
            ),
          ),
        ],
      );
    },
  );
}

Widget underAMC({
  double height = 20,
  double width = 20,
}) {
  AddMachineController controller = Get.find<AddMachineController>();
  return GestureDetector(
    onTap: () => showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            largeText(
              title: "Under AMC",
              fontSize: 22,
              fontColor: AppColors.black,
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.only(
                  left: 18.0,
                  top: 18,
                  bottom: 18,
                  right: 7,
                ),
                child: SvgPicture.asset(ImgRoutes.CROSS),
              ),
            ),
          ],
        ),
        contentPadding: EdgeInsets.only(
          left: 24,
          right: 24,
          bottom: 30,
          top: 15,
        ),
        scrollable: false,
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        content: SizedBox(
          width: width * 0.7,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => shopCard(
                  title: Strings.UNDERAMC,
                  onTap: () {
                    controller.changeAMCStatus("AMC");
                  },
                  isSelected: controller.isUnderAMC.value == "AMC",
                ),
              ),
              Obx(
                () => shopCard(
                  title: Strings.UNDERWARRANTY,
                  onTap: () {
                    controller.changeAMCStatus("Warranty");
                  },
                  isSelected: controller.isUnderAMC.value == "Warranty",
                ),
              ),
              Obx(
                () => shopCard(
                  title: Strings.UNDERMW,
                  onTap: () {
                    controller.changeAMCStatus("MW maintenance");
                  },
                  isSelected: controller.isUnderAMC.value == "MW maintenance",
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        mediumText(
          title: "Under AMC",
          fontWeight: FontWeight.w500,
          fontColor: AppColors.black,
        ),
        customSizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 21,
            vertical: 18,
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
                () => smallText(
                  title: controller.isUnderAMC.value,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontColor: AppColors.black,
                ),
              ),
              const Spacer(),
              SvgPicture.asset(ImgRoutes.ARROWDOWN),
            ],
          ),
        ),
        customSizedBox(height: 10),
      ],
    ),
  );
}

Widget vendorListing({
  double height = 20,
  double width = 20,
}) {
  AddMachineController controller = Get.find<AddMachineController>();

  return Obx(
    () {
      List<VendorList>? vendorList =
          controller.vendorList.value.data?.vendorList;

      return dialogList(
        bgColor: AppColors.white,
        dialogLabel: "Select Vendor",
        height: height,
        titleFontSize: 14,
        fontWeight: FontWeight.w600,
        width: width,
        title: "Vendor Name",
        hintText: "Select",
        length: vendorList?.length ?? 0,
        isExpanded: true,
        textFieldTitle: Obx(
          () => smallText(
            title: controller.vendorSelectFieldName.value,
            fontSize: 14,
            maxLines: 1,
            fontWeight: FontWeight.w400,
            fontColor:
                (vendorList?.isEmpty ?? true) ? AppColors.red : AppColors.black,
          ),
        ),
        list: (context, index) {
          final selectedVendor = vendorList?[index];

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => shopCard(
                  title: selectedVendor?.vendorName ?? "",
                  onTap: () {
                    final vendorName =
                        selectedVendor?.vendorName?.toLowerCase() ?? '';
                    final isOther = vendorName == 'other';

                    controller.isVendorFieldReadOnly.value = !isOther;
                    controller.vendorId.value =
                        (selectedVendor?.id ?? "").toString();
                    controller.vendorSelectFieldName.value =
                        selectedVendor?.vendorName ?? "";

                    if (isOther) {
                      controller.vendorPhoneNumber.clear();
                      controller.vendorEmail.clear();
                      controller.vendorLocation.clear();
                    } else {
                      controller.vendorPhoneNumber.text =
                          selectedVendor?.phoneNumber ?? "";
                      controller.vendorEmail.text = selectedVendor?.email ?? "";
                      controller.vendorLocation.text =
                          selectedVendor?.location ?? "";
                    }

                    Get.back();
                  },
                  isSelected: controller.vendorId.value ==
                      selectedVendor?.id.toString(),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}

Widget singleAttachmentField({
  double width = 20,
  String title = "Attachment",
  double fontSize = 14,
}) {
  AddMachineController controller = Get.find<AddMachineController>();
  return GestureDetector(
    onTap: () => Get.bottomSheet(
      imagePickerBottomsheet(
        label: "Choose Photos",
        onCamera: () {
          controller.singlePhotoSelect(ImageSource.camera);
          Get.back();
        },
        onGallary: () {
          controller.singlePhotoSelect(ImageSource.gallery);
          Get.back();
        },
      ),
    ),
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
          String selectedImage = controller.machineBase64.value;
          return (selectedImage != "")
              ? Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  runSpacing: 15,
                  spacing: 10,
                  children: List<Widget>.generate(
                    1,
                    (index) => Obx(
                      () => Container(
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
                            image: (controller.details != null &&
                                    controller.isMachineImageSelected.value ==
                                        false)
                                ? NetworkImage(selectedImage) as ImageProvider
                                : FileImage(
                                    File(
                                      controller.machineLocalFiles.value,
                                    ),
                                  ),
                          ),
                        ),
                      ),
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

Widget singleAttachmentFieldForTestCertificate({
  double width = 20,
  String title = "Attachment",
  double fontSize = 14,
}) {
  AddMachineController controller = Get.find<AddMachineController>();
  return GestureDetector(
    onTap: () => Get.bottomSheet(
      imagePickerBottomsheet(
        label: "Choose Photos",
        onCamera: () {
          controller.singlePhotoSelectTC(ImageSource.camera);
          Get.back();
        },
        onGallary: () {
          controller.singlePhotoSelectTC(ImageSource.gallery);
          Get.back();
        },
      ),
    ),
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
          String selectedImage = controller.testCertificateBase64.value;
          return (selectedImage != "")
              ? Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  runSpacing: 15,
                  spacing: 10,
                  children: List<Widget>.generate(
                    1,
                    (index) => Obx(
                      () => Container(
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
                            image: (controller.details != null &&
                                    controller.isTestCertificateImageSelected
                                            .value ==
                                        false)
                                ? NetworkImage(selectedImage) as ImageProvider
                                : FileImage(
                                    File(
                                      controller
                                          .testCertificateLocalFiles.value,
                                    ),
                                  ),
                          ),
                        ),
                      ),
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

Widget shopListing({
  double height = 20,
  double width = 20,
}) {
  AddMachineController controller = Get.find<AddMachineController>();
  return Obx(
    () {
      List<ShopList>? shopList = controller.shopList.value.data?.shopList;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // customSizedBox(height: 15),
          dialogList(
            bgColor: AppColors.white,
            dialogLabel: "Select Location",
            height: height,
            titleFontSize: 14,
            fontWeight: FontWeight.w600,
            width: width,
            title: "Location",
            hintText: "Select",
            length: shopList?.length ?? 0,
            textFieldTitle: smallText(
              title: controller.shopId == 0
                  ? "Select Location"
                  : "${controller.shopTitle}",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontColor:
                  shopList?.length == 0 ? AppColors.red : AppColors.black,
            ),
            list: (context, index) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(
                    () => shopCard(
                      title: "${shopList?[index].name}",
                      count: shopList?[index].machineCount ?? 0,
                      onTap: () {
                        controller.changeShopIds(shopList?[index].id ?? -1);
                        controller.changeShopTitle(shopList?[index].name ?? "");
                        if (controller.shopTitle.value.toLowerCase() ==
                            "other") {
                          controller.isOtherShopSelected.value = true;
                        } else {
                          controller.isOtherShopSelected.value = false;
                          controller.other_shop_name.clear();
                        }
                        Get.back();
                      },
                      isSelected: controller.shopId == shopList?[index].id
                          ? true
                          : false,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      );
    },
  );
}
