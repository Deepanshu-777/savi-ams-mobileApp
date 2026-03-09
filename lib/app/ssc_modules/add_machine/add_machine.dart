import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rail_weld/app/ssc_modules/add_machine/add_machine_controller.dart';
import 'package:rail_weld/app/ssc_modules/add_machine/widgets.dart';
import 'package:rail_weld/data/strings.dart';
import 'package:rail_weld/routes/img_routes.dart';
import 'package:rail_weld/theme/app_colors.dart';
import 'package:rail_weld/widgets/custom_app_bar.dart';
import 'package:rail_weld/widgets/custom_sized_box.dart';
import 'package:rail_weld/widgets/custom_text.dart';
import '../../../storage/storage.dart';
import '../../../widgets/attachment_field.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/decorated_box.dart';
import '../../../widgets/title_text_field.dart';

class AddMachineView extends GetView<AddMachineController> {
  const AddMachineView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        color: AppColors.white,
        margin: EdgeInsets.only(
          left: width * 0.055,
          right: width * 0.055,
        ),
        width: double.infinity,
        child: Obx(
          () => customElevatedButton(
            bgColor: AppColors.navyBlue,
            padding: const EdgeInsets.symmetric(vertical: 17),
            onPressed: () async {
              if (controller.step.value == 1) {
                if (controller.addMachineForm1.currentState!.validate() &&
                    controller.dateOfCommissioning.value != "" &&
                    controller.poDate.value != "") {
                  controller.step.value++;
                }
              } else if (controller.step.value == 2) {
                if (controller.addMachineForm2.currentState!.validate()) {
                  controller.step.value++;
                }
              } else if (controller.step.value == 3) {
                if (controller.addMachineForm3.currentState!.validate()) {
                  controller.addMachine();
                }
              }
            },
            title: (controller.step.value == 3 && controller.details == null)
                ? "Add Machine"
                : (controller.step.value == 3 && controller.details != null)
                    ? "Edit Machine"
                    : "Next",
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customAppBar(isBackButton: false),
            decoratedBox(
              width: width,
              padding: EdgeInsets.all(0),
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 5,
                    left: width * 0.055,
                    right: width * 0.055,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customSizedBox(height: 30),
                      largeText(
                        title: controller.details == null
                            ? "Add ${controller.machineType}"
                            : "Edit ${controller.machineType}",
                        fontSize: 20,
                        fontColor: AppColors.black,
                      ),
                      customSizedBox(height: 19),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(
                            () => GestureDetector(
                              onTap: () => controller.step.value = 1,
                              child: formStatus(
                                  title: "NECESSARY\nDETAILS",
                                  img: controller.step.value > 1
                                      ? ImgRoutes.DONE
                                      : ImgRoutes.ENABLEDDONE,
                                  fontColor: AppColors.black),
                            ),
                          ),
                          Obx(
                            () => GestureDetector(
                              onTap: () => controller.step.value = 2,
                              child: formStatus(
                                title: "AMC/\nWARRANTY DETAILS",
                                img: controller.step.value > 2
                                    ? ImgRoutes.DONE
                                    : controller.step.value < 2
                                        ? ImgRoutes.DISABLEDTWO
                                        : ImgRoutes.ENABLEDTWO,
                                fontColor: controller.step.value < 2
                                    ? AppColors.greyD
                                    : AppColors.black,
                              ),
                            ),
                          ),
                          Obx(
                            () => GestureDetector(
                              onTap: () => controller.step.value = 3,
                              child: formStatus(
                                title: "VENDOR\nDETAILS",
                                img: controller.step.value > 3
                                    ? ImgRoutes.DONE
                                    : controller.step.value < 3
                                        ? ImgRoutes.DISABLEDTHREE
                                        : ImgRoutes.ENABLEDTHREE,
                                fontColor: controller.step.value < 3
                                    ? AppColors.greyD
                                    : AppColors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      customSizedBox(height: 21),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.055,
                        vertical: height * 0.03,
                      ),
                      color: AppColors.whiteBg,
                      child: Obx(
                        () => controller.step.value == 1
                            ? Form(
                                key: controller.addMachineForm1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Obx(
                                      () {
                                        bool isCompressorCheck =
                                            controller.isCompressorCheck.value;
                                        return InkWell(
                                          onTap: () {
                                            controller.toggleCompressor();
                                          },
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    isCompressorCheck
                                                        ? ImgRoutes.TICKCHECKBOX
                                                        : ImgRoutes
                                                            .UNTICKCHECKBOX,
                                                    height: 20,
                                                    width: 20,
                                                  ),
                                                  customSizedBox(width: 7),
                                                  smallText(
                                                    title:
                                                        "This is a Compressor type Machine",
                                                    fontColor:
                                                        AppColors.navyBlue,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ],
                                              ),
                                              customSizedBox(height: 20),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    titleTextField(
                                      controller: controller.machineName,
                                      hintText:
                                          "Enter ${controller.machineType.value} Name",
                                      title:
                                          "${controller.machineType.value} Name",
                                      validator: (value) =>
                                          controller.textValidation(
                                        val: value,
                                        textFieldName: "Machine Name",
                                      ),
                                    ),
                                    titleTextField(
                                      controller: controller.itemCode,
                                      hintText: Strings.ENTERPLANTNO,
                                      title:
                                          "${controller.machineType} ${Strings.PLANTNO}",
                                      validator: (value) =>
                                          controller.textValidation(
                                        val: value,
                                        textFieldName: Strings.PLANTNO,
                                      ),
                                    ),
                                    Obx(
                                      () {
                                        if (controller.machineType.value
                                                .toLowerCase() ==
                                            "compressor") {
                                          return Column(
                                            children: [
                                              titleTextField(
                                                controller:
                                                    controller.pressureVesselNo,
                                                hintText:
                                                    "Enter Pressure Vessel No",
                                                title: "Pressure Vessel No",
                                              ),
                                              titleTextField(
                                                controller:
                                                    controller.hoursPerDay,
                                                hintText: "Enter Hours per Day",
                                                title: "Hours/Day",
                                                keyboardType:
                                                    TextInputType.number,
                                              ),
                                            ],
                                          );
                                        } else {
                                          return const SizedBox.shrink();
                                        }
                                      },
                                    ),
                                    titleTextField(
                                      controller: controller.make,
                                      hintText: "Enter Make",
                                      title: "Make",
                                    ),
                                    Obx(
                                      () => controller.isOtherMakeSelected.value
                                          ? Column(
                                              children: [
                                                SizedBox(height: 15),
                                                titleTextField(
                                                  controller: controller
                                                      .other_make_name,
                                                  hintText:
                                                      "Enter New Make Name",
                                                  title: "Make Name",
                                                  validator: (value) {
                                                    if (controller
                                                            .isOtherMakeSelected
                                                            .value &&
                                                        value!.trim().isEmpty) {
                                                      return "Make Name is required";
                                                    }
                                                    return null;
                                                  },
                                                )
                                              ],
                                            )
                                          : SizedBox(height: 15),
                                    ),
                                    titleTextField(
                                      controller: controller.model,
                                      hintText: "Enter Model",
                                      title: "Model",
                                    ),
                                    shopListing(
                                      height: height,
                                      width: width,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    (Storage.getRole() == "4")
                                        ? Obx(
                                            () => controller
                                                    .isOtherShopSelected.value
                                                ? titleTextField(
                                                    controller: controller
                                                        .other_shop_name,
                                                    hintText:
                                                        "Enter New Location",
                                                    title: "New Location",
                                                    validator: (value) {
                                                      if (controller
                                                              .isOtherShopSelected
                                                              .value &&
                                                          value!
                                                              .trim()
                                                              .isEmpty) {
                                                        return "Location is required";
                                                      }
                                                      return null;
                                                    },
                                                  )
                                                : SizedBox.shrink(),
                                          )
                                        : const SizedBox(),
                                    Obx(
                                      () {
                                        return titleTextField(
                                          controller: controller
                                              .machinePhysicalLocation,
                                          hintText:
                                              "Enter ${controller.machineType} Location in shop",
                                          title:
                                              "${controller.machineType}  Location in shop",
                                        );
                                      },
                                    ),
                                    dateTextField(
                                      title:
                                          "Date of Commencement of Operation",
                                      selectedDate:
                                          controller.dateOfCommissioning,
                                    ),
                                    titleTextField(
                                      controller: controller.capacity,
                                      hintText: "Enter Capacity",
                                      title: "Capacity",
                                    ),
                                    singleAttachmentField(
                                      title: "Machine Image",
                                      width: width,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    titleTextField(
                                      controller: controller.warranty,
                                      hintText: "Enter Warranty",
                                      title: "Warranty",
                                      keyboardType: TextInputType.number,
                                      isSuffixText: true,
                                      suffixText: "Years",
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      // validator: (value) =>
                                      //     controller.textValidation(
                                      //   val: value,
                                      //   isNum: true,
                                      //   textFieldName: "Warranty",
                                      // ),
                                    ),
                                    dateTextField(
                                      title: "Last Maintenance Scheduled Date",
                                      selectedDate: controller
                                          .lastMaintenanceScheduledDate,
                                    ),
                                    Obx(
                                      () {
                                        bool isFirstMainCheck =
                                            controller.isFirstMainCheck.value;
                                        return InkWell(
                                          onTap: () {
                                            controller
                                                .toggleFirstMaintenanceCheck();
                                          },
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    isFirstMainCheck
                                                        ? ImgRoutes.TICKCHECKBOX
                                                        : ImgRoutes
                                                            .UNTICKCHECKBOX,
                                                    height: 20,
                                                    width: 20,
                                                  ),
                                                  customSizedBox(width: 7),
                                                  smallText(
                                                    title:
                                                        "This is the first maintenance",
                                                    fontColor:
                                                        AppColors.navyBlue,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ],
                                              ),
                                              customSizedBox(height: 20),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    dateTextField(
                                      title: "Last Maintenance Done Date",
                                      selectedDate:
                                          controller.lastMaintenanceDate,
                                    ),
                                    titleTextField(
                                      controller: controller.maintenance,
                                      hintText:
                                          "Enter Preventive Maintenance Interval (Months)",
                                      title:
                                          "Preventive Maintenance Interval (Months)",
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      isSuffixText: true,
                                      suffixText: "Months",
                                      validator: (value) =>
                                          controller.textValidation(
                                        val: value,
                                        isNum: true,
                                        textFieldName: "Maintenance",
                                      ),
                                    ),
                                    titleTextField(
                                      controller: controller.poNumber,
                                      hintText: "Enter COFMOW / PO No.",
                                      title: "COFMOW / PO No.",
                                    ),
                                    titleTextField(
                                      controller: controller.irepsPoNumber,
                                      hintText: "IREPS / PO No.",
                                      title: "IREPS / PO No.",
                                    ),
                                    dateTextField(
                                      title: "PO Date",
                                      selectedDate: controller.poDate,
                                    ),
                                    Obx(
                                      () {
                                        bool isGem = controller.isGem.value;
                                        return Column(
                                          children: [
                                            InkWell(
                                              onTap: () =>
                                                  controller.toggleGem(),
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    isGem
                                                        ? ImgRoutes.TICKCHECKBOX
                                                        : ImgRoutes
                                                            .UNTICKCHECKBOX,
                                                    height: 20,
                                                    width: 20,
                                                  ),
                                                  customSizedBox(width: 7),
                                                  smallText(
                                                    title: "Gem",
                                                    fontColor:
                                                        AppColors.navyBlue,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            customSizedBox(height: 20),
                                            isGem
                                                ? Column(
                                                    children: [
                                                      titleTextField(
                                                        controller: controller
                                                            .gemPoNumber,
                                                        hintText: Strings
                                                            .ENTERGEMPONUM,
                                                        title: Strings.GEMPONUM,
                                                      ),
                                                      dateTextField(
                                                        title:
                                                            Strings.GEMPODATE,
                                                        selectedDate: controller
                                                            .gemPoDate,
                                                      ),
                                                    ],
                                                  )
                                                : const SizedBox(),
                                          ],
                                        );
                                      },
                                    ),
                                    titleTextField(
                                      controller: controller.stockHolderCode,
                                      hintText: Strings.ENTERSHC,
                                      title: Strings.SHC,
                                      // validator: (value) =>
                                      //     controller.textValidation(
                                      //   val: value,
                                      //   textFieldName: Strings.SHC,
                                      // ),
                                    ),
                                    titleTextField(
                                      controller: controller.station,
                                      hintText: Strings.ENTERSTATION,
                                      title: Strings.STATION,
                                      // validator: (value) =>
                                      //     controller.textValidation(
                                      //   val: value,
                                      //   textFieldName: Strings.STATION,
                                      // ),
                                    ),
                                    categoryListing(
                                      height: height,
                                      width: width,
                                    ),
                                    Obx(
                                      () => controller
                                              .isOtherCategorySelected.value
                                          ? Column(
                                              children: [
                                                SizedBox(height: 15),
                                                titleTextField(
                                                  controller: controller
                                                      .other_category_name,
                                                  hintText:
                                                      "Enter New Category Name",
                                                  title: "Category",
                                                  validator: (value) {
                                                    if (controller
                                                            .isOtherCategorySelected
                                                            .value &&
                                                        value!.trim().isEmpty) {
                                                      return "Category Name is required";
                                                    }
                                                    return null;
                                                  },
                                                )
                                              ],
                                            )
                                          : SizedBox(
                                              height: 15,
                                            ),
                                    ),
                                    titleTextField(
                                      controller: controller.noOfShiftsUse,
                                      hintText: "Enter No. of Shifts In Use",
                                      title: "No. of Shifts In Use",
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                    ),
                                    dateTextField(
                                      title: "Details of Improvements Date",
                                      selectedDate:
                                          controller.detailsOfImprovementsDate,
                                    ),
                                    titleTextField(
                                      controller:
                                          controller.detailsOfImprovementsCost,
                                      hintText: "Enter Improvement Cost",
                                      title: "Details of Improvements Cost",
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                    ),
                                    facListing(
                                      height: height,
                                      width: width,
                                    ),
                                    Obx(
                                      () => controller.isOtherFacSelected.value
                                          ? Column(
                                              children: [
                                                SizedBox(height: 15),
                                                titleTextField(
                                                  controller:
                                                      controller.other_fac_name,
                                                  hintText:
                                                      "Enter New Fund allocation code",
                                                  title:
                                                      "New Fund Allocation Code",
                                                  validator: (value) {
                                                    if (controller
                                                            .isOtherMakeSelected
                                                            .value &&
                                                        value!.trim().isEmpty) {
                                                      return "Fac Name is required";
                                                    }
                                                    return null;
                                                  },
                                                )
                                              ],
                                            )
                                          : SizedBox(height: 15),
                                    ),
                                    titleTextField(
                                      controller: controller.whetherSurplus,
                                      hintText: "Enter Whether Surplus",
                                      title: "Whether Surplus",
                                    ),
                                    titleTextField(
                                      controller: controller.headQuartersUcNo,
                                      hintText: "Enter Head Quarters UC NO",
                                      title: "Head Quarters UC NO",
                                    ),
                                    dateTextField(
                                      updateNoOfYears: true,
                                      title:
                                          "Date of Acquisition / Installation (${controller.noOfyearsMachineryInUse})",
                                      selectedDate: controller
                                          .dateOfAcquisitionInstallation,
                                      widget: Container(
                                        color: AppColors.transparent,
                                        padding: const EdgeInsets.only(
                                            right: 2, bottom: 2, top: 2),
                                        child: GestureDetector(
                                          key: controller.tooltipKey,
                                          onTap: () => controller.showTooltip(
                                            context,
                                            controller.tooltipKey,
                                            "No. of years this machine is in use: ${controller.noOfyearsMachineryInUse.value}",
                                          ),
                                          onDoubleTap: () =>
                                              controller.showTooltip(
                                            context,
                                            controller.tooltipKey,
                                            "No. of years this machine is in use: ${controller.noOfyearsMachineryInUse.value}",
                                          ),
                                          onLongPress: () =>
                                              controller.showTooltip(
                                            context,
                                            controller.tooltipKey,
                                            "No. of years this machine is in use: ${controller.noOfyearsMachineryInUse.value}",
                                          ),
                                          child: Icon(
                                            Icons.info_outline,
                                            size: height * 0.02,
                                          ),
                                        ),
                                      ),
                                    ),
                                    titleTextField(
                                      controller: controller
                                          .costOfAcquisitionInstallation,
                                      hintText:
                                          "Enter Cost of Acquisition / Installation",
                                      title:
                                          "Cost of Acquisition / Installation",
                                      // validator: (value) =>
                                      //     controller.textValidation(
                                      //   val: value,
                                      //   textFieldName:
                                      //       "Cost of Acquisition / Installation",
                                      // ),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                    ),
                                    titleTextField(
                                      controller: controller.machineCost,
                                      hintText: Strings.ENTERMACHINECOST,
                                      title: "Total ${Strings.MACHINECOST}",
                                      keyboardType: TextInputType.number,
                                    ),
                                    titleTextField(
                                      controller: controller.codelLife,
                                      hintText: "Enter Codal/ Expiry Life",
                                      title: "Codal/ Expiry Life",
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      isSuffixText: true,
                                      suffixText: "Years",
                                      onChanged: (_) => controller
                                          .calculateDepreciationValues(),
                                    ),
                                    Obx(
                                      () {
                                        if (controller.rateOfDepreciation.value
                                                .isNotEmpty &&
                                            controller.accumulatedDepreciation
                                                .value.isNotEmpty &&
                                            controller.netBookValue.value
                                                .isNotEmpty) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              /// Rate of Depreciation
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          const TextSpan(
                                                            text:
                                                                "Rate of Depreciation: ",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 14,
                                                              color: AppColors
                                                                  .black,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                "${controller.rateOfDepreciation.value} %",
                                                            style:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    key: controller
                                                        .rateTooltipKey,
                                                    onTap: () =>
                                                        controller.showTooltip(
                                                      context,
                                                      controller.rateTooltipKey,
                                                      "Rate of Depreciation is calculated annually.\nFormula: 100 ÷ Codal Life (years)",
                                                    ),
                                                    child: const Icon(
                                                      Icons.info_outline,
                                                      size: 18,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 8),

                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                "Accumulated Depreciation (in Rs.) till ${DateFormat('dd/MM/yyyy').format(DateTime.now())}: ",
                                                            style:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 14,
                                                              color: AppColors
                                                                  .black,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                "₹ ${controller.accumulatedDepreciation.value}",
                                                            style:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    key: controller
                                                        .accumulatedTooltipKey,
                                                    onTap: () =>
                                                        controller.showTooltip(
                                                      context,
                                                      controller
                                                          .accumulatedTooltipKey,
                                                      "Accumulated Depreciation is total depreciation till date.\n\nIf Years in Use ≥ Codal Life:\n   95% × Cost\nElse:\n   (95% × Cost) × (Years in Use ÷ Codal Life)",
                                                    ),
                                                    child: const Icon(
                                                        Icons.info_outline,
                                                        size: 18),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                "Net Book Value (in Rs.) as on ${DateFormat('dd/MM/yyyy').format(DateTime.now())}: ",
                                                            style:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 14,
                                                              color: AppColors
                                                                  .black,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                "₹ ${controller.netBookValue.value}",
                                                            style:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    key: controller
                                                        .netBookTooltipKey,
                                                    onTap: () =>
                                                        controller.showTooltip(
                                                      context,
                                                      controller
                                                          .netBookTooltipKey,
                                                      "Net Book Value = Cost of Acquisition – Accumulated Depreciation",
                                                    ),
                                                    child: const Icon(
                                                        Icons.info_outline,
                                                        size: 18),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                            ],
                                          );
                                        }
                                        return const SizedBox.shrink();
                                      },
                                    ),
                                    titleTextField(
                                      controller: controller.currentMarketValue,
                                      hintText:
                                          "Enter Current Market Value (INR)",
                                      title: "Current Market Value (INR)",
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                    ),
                                    titleTextField(
                                      controller: controller.mc_specility,
                                      hintText: "Enter Mc Specility",
                                      title: "Mc Specility",
                                    ),
                                    titleTextField(
                                      controller: controller.remarks,
                                      hintText: "Enter Remarks",
                                      title: "Remarks",
                                      expands: true,
                                      height: height * 0.15,
                                      maxLines: null,
                                      keyboardType: TextInputType.multiline,
                                    ),
                                    dateTextField(
                                      title: "Details of Improvements Date",
                                      selectedDate:
                                          controller.detailsOfImprovementsDate,
                                    ),
                                    titleTextField(
                                      controller:
                                          controller.detailsOfImprovementsCost,
                                      hintText: "Enter Improvement Cost",
                                      title: "Details of Improvements Cost",
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                    ),
                                    dateTextField(
                                      title: "Last Tested On",
                                      selectedDate: controller.lastTestedOn,
                                      unselectedColor: AppColors.black,
                                    ),
                                    dateTextField(
                                      title: "Next Test Due Date",
                                      selectedDate: controller.nextTestDueDate,
                                      unselectedColor: AppColors.black,
                                      lastDate: DateTime(3000),
                                    ),
                                    dateTextField(
                                      title: "Last Calibrated On",
                                      selectedDate: controller.lastCalibratedOn,
                                      unselectedColor: AppColors.black,
                                    ),
                                    dateTextField(
                                      title: "Next Calibration Due On",
                                      selectedDate:
                                          controller.nextCalibrationOn,
                                      unselectedColor: AppColors.black,
                                      lastDate: DateTime(3000),
                                    ),
                                    singleAttachmentFieldForTestCertificate(
                                      title: "Test Certificate",
                                      width: width,
                                    ),
                                    customSizedBox(height: 70),
                                  ],
                                ),
                              )
                            : controller.step.value == 2
                                ? Form(
                                    key: controller.addMachineForm2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        underAMCDialog(
                                          height: height,
                                          width: width,
                                        ),
                                        customSizedBox(height: 15),
                                        dateTextField(
                                          title: Strings.FROM,
                                          selectedDate: controller.amcFrom,
                                        ),
                                        dateTextField(
                                          title: Strings.TO,
                                          lastDate: DateTime(3000),
                                          selectedDate: controller.amcTo,
                                        ),
                                        Obx(
                                          () {
                                            return controller.amcWarrantyName
                                                        .value ==
                                                    Strings.UNDERWARRANTY
                                                ? const SizedBox()
                                                : Obx(
                                                    () {
                                                      bool isWarrantyDetails =
                                                          controller
                                                              .isWarrantyDetails
                                                              .value;
                                                      return Column(
                                                        children: [
                                                          InkWell(
                                                            onTap: () => controller
                                                                .toggleWarrantyDetails(),
                                                            child: Row(
                                                              children: [
                                                                SvgPicture
                                                                    .asset(
                                                                  isWarrantyDetails
                                                                      ? ImgRoutes
                                                                          .TICKCHECKBOX
                                                                      : ImgRoutes
                                                                          .UNTICKCHECKBOX,
                                                                  height: 20,
                                                                  width: 20,
                                                                ),
                                                                customSizedBox(
                                                                    width: 7),
                                                                smallText(
                                                                    title: Strings
                                                                        .WARRANTYDETAILS,
                                                                    fontColor:
                                                                        AppColors
                                                                            .navyBlue,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ],
                                                            ),
                                                          ),
                                                          customSizedBox(
                                                              height: 20),
                                                          controller
                                                                  .isWarrantyDetails
                                                                  .value
                                                              ? Column(
                                                                  children: [
                                                                    dateTextField(
                                                                        title: Strings
                                                                            .WARRANTYFROM,
                                                                        selectedDate:
                                                                            controller.warrantyFrom),
                                                                    dateTextField(
                                                                      title: Strings
                                                                          .WARRANTYTO,
                                                                      lastDate:
                                                                          DateTime(
                                                                              3000),
                                                                      selectedDate:
                                                                          controller
                                                                              .warrantyTo,
                                                                    ),
                                                                  ],
                                                                )
                                                              : const SizedBox(),
                                                        ],
                                                      );
                                                    },
                                                  );
                                          },
                                        ),
                                        // titleTextField(
                                        //   controller: controller.maintenance,
                                        //   hintText: "Enter Maintenance",
                                        //   title: "Maintenance",
                                        //   isSuffixText: true,
                                        //   suffixText: "Month",
                                        //   keyboardType: TextInputType.number,
                                        //   inputFormatters: [
                                        //     FilteringTextInputFormatter
                                        //         .digitsOnly,
                                        //   ],
                                        //   validator: (value) =>
                                        //       controller.textValidation(
                                        //     val: value,
                                        //     isNum: true,
                                        //     textFieldName: "Maintenance",
                                        //   ),
                                        // ),
                                        // dateTextField(
                                        //   title: "Next Maintenance Date",
                                        //   selectedDate:
                                        //       controller.nextMaintenanceDate,
                                        //   lastDate: DateTime.now().add(
                                        //       const Duration(days: 365 * 5)),
                                        // ),
                                        titleTextField(
                                          controller: controller.amc_firm,
                                          hintText: "Enter Amc Firm",
                                          title: "Amc Firm",
                                        ),
                                        titleTextField(
                                          controller: controller
                                              .amc_firm_contact_email_id,
                                          hintText:
                                              "Enter AMC Firm Contact Email",
                                          title: "AMC Firm Contact Email",
                                        ),
                                        titleTextField(
                                          controller: controller.loa_details,
                                          hintText: "Enter LOA details",
                                          title: "LOA Details",
                                        ),
                                        titleTextField(
                                          controller: controller.total_amc_cost,
                                          hintText: "Enter Total Amc Cost",
                                          title: "Total Amc Cost",
                                          // validator: (value) =>
                                          //     controller.textValidation(
                                          //   val: value,
                                          //   textFieldName: "Total Amc Cost",
                                          // ),
                                        ),
                                        attachmentField(
                                          width: width,
                                          title: "PO Attachment",
                                          localImagePath:
                                              controller.POLocalFiles,
                                          base64Image: controller.POBase64,
                                        ),
                                        customSizedBox(height: 15),
                                        attachmentField(
                                          width: width,
                                          title: "General Attachment",
                                          localImagePath:
                                              controller.generalLocalFiles,
                                          base64Image: controller.generalBase64,
                                        ),
                                        customSizedBox(height: 15),
                                        titleTextField(
                                          controller: controller.description,
                                          hintText: Strings.ENTERDESC,
                                          title: Strings.DESC,
                                          expands: true,
                                          height: height * 0.15,
                                          maxLines: null,
                                          keyboardType: TextInputType.multiline,
                                          // validator: (val) {
                                          //   if (val?.isEmpty ?? true) {
                                          //     return "Description is required";
                                          //   }
                                          // },
                                        ),
                                        customSizedBox(height: 80),
                                      ],
                                    ),
                                  )
                                : controller.step.value == 3
                                    ? Form(
                                        key: controller.addMachineForm3,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            vendorListing(
                                              height: height,
                                              width: width,
                                            ),
                                            customSizedBox(height: 15),
                                            Obx(
                                              () => controller
                                                          .vendorSelectFieldName
                                                          .value
                                                          .toLowerCase() ==
                                                      "other"
                                                  ? titleTextField(
                                                      controller: controller
                                                          .other_vendor_name,
                                                      hintText:
                                                          "Enter New Vendor Name",
                                                      title: "Vendor Name",
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value
                                                                .trim()
                                                                .isEmpty) {
                                                          return "Vendor Name is required";
                                                        }
                                                        return null;
                                                      },
                                                    )
                                                  : SizedBox.shrink(),
                                            ),
                                            customSizedBox(height: 15),
                                            Obx(
                                              () => titleTextField(
                                                controller: controller
                                                    .vendorPhoneNumber,
                                                hintText: "Enter Phone Number",
                                                title: "Vendor Phone Number",
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                  controller.vendorSelectFieldName
                                                              .value
                                                              .toLowerCase() ==
                                                          "other"
                                                      ? LengthLimitingTextInputFormatter(
                                                          10)
                                                      : LengthLimitingTextInputFormatter(
                                                          22),
                                                ],
                                                isReadOnly: controller
                                                    .isVendorFieldReadOnly
                                                    .value,
                                                validator: (value) {
                                                  if (controller
                                                          .vendorSelectFieldName
                                                          .value
                                                          .toLowerCase() ==
                                                      "other") {
                                                    if (value == null ||
                                                        value.trim().isEmpty) {
                                                      return "Vendor Phone Number is required";
                                                    }
                                                    if (value.trim().length !=
                                                        10) {
                                                      return "Must be exactly 10 digits";
                                                    }
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            customSizedBox(height: 15),
                                            Obx(
                                              () => titleTextField(
                                                controller:
                                                    controller.vendorEmail,
                                                hintText: "Enter Email Address",
                                                title: "Vendor Email Address",
                                                isReadOnly: controller
                                                    .isVendorFieldReadOnly
                                                    .value,
                                                validator: (value) {
                                                  if (controller
                                                          .vendorSelectFieldName
                                                          .value
                                                          .toLowerCase() ==
                                                      "other") {
                                                    if (value == null ||
                                                        value.trim().isEmpty) {
                                                      return "Vendor Email is required";
                                                    }
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            customSizedBox(height: 15),
                                            Obx(
                                              () => titleTextField(
                                                controller:
                                                    controller.vendorLocation,
                                                hintText:
                                                    Strings.ENTERVENDORLOC,
                                                title: Strings.VENDORLOCATION,
                                                isReadOnly: controller
                                                    .isVendorFieldReadOnly
                                                    .value,
                                                validator: (value) {
                                                  if (controller
                                                          .vendorSelectFieldName
                                                          .value
                                                          .toLowerCase() ==
                                                      "other") {
                                                    if (value == null ||
                                                        value.trim().isEmpty) {
                                                      return "Vendor Location is required";
                                                    }
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            customSizedBox(height: 50),
                                          ],
                                        ),
                                      )
                                    : const SizedBox(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
