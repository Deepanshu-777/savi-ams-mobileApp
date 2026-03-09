import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rail_weld/app/response_team_module/res_machine_details/res_machine_details_controller.dart';
import 'package:rail_weld/app/ssc_modules/main_view/total_machines/filter_screen.dart';
import 'package:rail_weld/app/ssc_modules/raise_ticket/raise_ticket_controller.dart';
import 'package:rail_weld/data/strings.dart';
import 'package:rail_weld/model/scc_module_models/check_active_ticket_model.dart';
import 'package:rail_weld/model/scc_module_models/designation_model.dart';
import 'package:rail_weld/model/scc_module_models/machine_details.dart';
import 'package:rail_weld/widgets/custom_elevated_button.dart';
import 'package:rail_weld/widgets/custom_toast.dart';
import '../../../model/scc_module_models/issue_code_model.dart';
import '../../../routes/img_routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_sized_box.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/decorated_box.dart';
import '../../../widgets/dropdown_dialog.dart';
import '../../../widgets/image_picker_bottomsheet.dart';
import '../../../widgets/title_text_field.dart';
import '../machine_details/machine_details_controller.dart';
import '../../../../model/scc_module_models/ticket_request_model.dart';

Widget body({
  double height = 20,
  double width = 20,
}) {
  RaiseTicketController controller = Get.find<RaiseTicketController>();

  return Obx(() {
    dynamic machineDetails;
    log("controller.isFromRequest.value${controller.isFromRequest.value}");
    if (controller.isFromRequest.value) {
      machineDetails = Get.arguments as Machine?;
    } else {
      try {
        MachineDetailsController machineDetailsController =
            Get.find<MachineDetailsController>();
        machineDetails =
            machineDetailsController.machineDetail.value.data?.machineDetails;
      } catch (e) {
        try {
          ResMachineDetailsController resMachineDetailsController =
              Get.find<ResMachineDetailsController>();
          machineDetails = resMachineDetailsController
              .machineDetail.value.data?.machineDetails;
        } catch (e) {
          Get.back();
          customToast(
            msg: "Something went wrong while raising the ticket",
          );
        }
      }
    }

    return decoratedBox(
      width: width,
      padding: EdgeInsets.only(
        top: 5,
        left: width * 0.055,
        right: width * 0.055,
        bottom: 80,
      ),
      children: [
        customSizedBox(height: 30),
        largeText(
          title: "Raise Ticket Form",
          fontSize: 20,
          fontColor: AppColors.black,
        ),
        customSizedBox(height: 40),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                titleTextField(
                  controller: TextEditingController(
                    text: machineDetails?.name ?? "",
                  ),
                  hintText: "Enter Machine Name",
                  title: "Machine Name",
                  isReadOnly: true,
                ),
                titleTextField(
                  controller: TextEditingController(
                    text: machineDetails?.itemCode ?? "",
                  ),
                  hintText: Strings.ENTERPLANTNO,
                  title: Strings.PLANTNO,
                  isReadOnly: true,
                ),
                Form(
                  key: controller.raiseTicketFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // machineDetails?.status == "Condemned"
                      //     ? const SizedBox()
                      //     : selectStatus(
                      //         dialogLabel: "Select Machine Status",
                      //         height: height,
                      //         width: width,
                      //         title: "Machine Status",
                      //         hintText: "Select machine status",
                      //       ),
                      // machineDetails?.status == "Condemned"
                      //     ? const SizedBox()
                      //     : customSizedBox(height: 18),
                      titleTextField(
                        controller: controller.empName,
                        hintText: "Enter Your Name",
                        title: "Your Name",
                        isReadOnly: true,
                      ),
                      titleTextField(
                        controller: controller.phone,
                        hintText: "Enter Your Phone",
                        title: "Your Phone",
                        isReadOnly: true,
                      ),
                      // titleTextField(
                      //   controller: controller.batch_no,
                      //   hintText: "Enter T. No.",
                      //   title: "T. No.",
                      // ),
                      // designationList(
                      //   height: height,
                      //   width: width,
                      // ),
                      // customSizedBox(height: 18),
                      issueCodes(
                        height: height,
                        width: width,
                      ),
                      customSizedBox(height: 18),
                      locationDialog(
                        height: height,
                        width: width,
                      ),
                      customSizedBox(height: 18),
                      responseTeamType(
                        height: height,
                        width: width,
                      ),
                      customSizedBox(height: 18),
                      titleTextField(
                        controller: TextEditingController(
                          text: machineDetails?.vendorName ?? "",
                        ),
                        hintText: "Enter Vendors name",
                        title: "Vendor’s Name",
                        isReadOnly: true,
                      ),
                      titleTextField(
                        controller: TextEditingController(
                          text: machineDetails?.vendorPhoneNumber ?? "",
                        ),
                        hintText: "Enter Vendors number",
                        title: "Vendor’s Number",
                        isReadOnly: true,
                      ),
                      attachmentField(width: width),
                      customSizedBox(height: 18),
                      titleTextField(
                        controller: controller.issueDescription,
                        hintText: "Describe the Issue",
                        title: "Issue Description",
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
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  });
}

Widget issueCodes({
  double height = 20,
  double width = 20,
}) {
  RaiseTicketController controller = Get.find<RaiseTicketController>();
  return Obx(
    () {
      return dialogList(
        dialogLabel: "Select Issue Code",
        height: height,
        width: width,
        title: "Issue Code",
        fontWeight: FontWeight.w600,
        titleFontSize: 14,
        hintText: "Select Issue code",
        length: controller.issueCodeList.length,
        textFieldTitle: Expanded(
          child: smallText(
            title: controller.issueCodeId.length == 0
                ? "Select Issue Code"
                : controller.issueCodeId.length > 1
                    ? "${controller.issueCodeTitle[0]} + ${(controller.issueCodeId.length - 1)}"
                    : controller.issueCodeTitle[0],
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontColor: controller.issueCodeId.length == 0
                ? AppColors.red
                : AppColors.black,
          ),
        ),
        list: (context, index) {
          return Obx(
            () {
              IssueCodeList issueCode = controller.issueCodeList[index];
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  shopCard(
                    title: "${issueCode.issueCode} ( ${issueCode.partName} )",
                    onTap: () {
                      controller.changeIssueCodeId(issueCode.id ?? -1);
                      controller.changeIssueCodeTitle(
                          "${issueCode.issueCode} ( ${issueCode.partName} )");
                    },
                    isSelected: controller.issueCodeId.contains(issueCode.id)
                        ? true
                        : false,
                  ),
                ],
              );
            },
          );
        },
      );
    },
  );
}

Widget designationList({
  double height = 20,
  double width = 20,
}) {
  RaiseTicketController controller = Get.find<RaiseTicketController>();
  return Obx(
    () {
      return dialogList(
        dialogLabel: "Select Designation",
        height: height,
        width: width,
        title: "Designation",
        fontWeight: FontWeight.w600,
        titleFontSize: 14,
        hintText: "Select Designation",
        length: controller.designationList.length,
        textFieldTitle: smallText(
          title: controller.selectedDesignationTitle == ""
              ? "Select Designation"
              : controller.selectedDesignationTitle.value,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontColor: controller.selectedDesignationTitle == ""
              ? AppColors.red
              : AppColors.black,
        ),
        list: (context, index) {
          return Obx(
            () {
              DesignationList designation = controller.designationList[index];
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  shopCard(
                    title: "${designation.name}",
                    onTap: () {
                      controller.selectedDesignationId.value = designation.id;
                      controller.selectedDesignationTitle.value =
                          designation.name;
                      Get.back();
                    },
                    isSelected:
                        controller.selectedDesignationId == designation.id
                            ? true
                            : false,
                  ),
                ],
              );
            },
          );
        },
      );
    },
  );
}

Widget responseTeamType({
  double height = 20,
  double width = 20,
}) {
  RaiseTicketController controller = Get.find<RaiseTicketController>();
  return GestureDetector(
    onTap: () => showDialog(
      context: Get.context!,
      builder: (context) => Padding(
        padding: EdgeInsets.symmetric(vertical: height * 0.1),
        child: AlertDialog(
          title: Row(
            children: [
              largeText(
                title: "Select Assignee",
                fontSize: 22,
                fontColor: AppColors.black,
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.all(18.0),
                  child: SvgPicture.asset(ImgRoutes.CROSS),
                ),
              ),
            ],
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 10,
          ),
          scrollable: true,
          backgroundColor: AppColors.white,
          surfaceTintColor: AppColors.white,
          content: SizedBox(
            width: width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => shopCard(
                    title: "Power",
                    onTap: () => controller.changeAssigneeType("Power"),
                    isSelected:
                        controller.assigneeType.value == "Power" ? true : false,
                  ),
                ),
                Obx(
                  () => shopCard(
                    isSelected: controller.assigneeType.value == "Millwright"
                        ? true
                        : false,
                    title: "Millwright",
                    onTap: () => controller.changeAssigneeType("Millwright"),
                  ),
                ),
                Obx(
                  () => shopCard(
                    isSelected: controller.assigneeType.value == "M&P Cell"
                        ? true
                        : false,
                    title: "M&P Cell",
                    onTap: () => controller.changeAssigneeType("M&P Cell"),
                  ),
                ),
                Obx(
                  () => shopCard(
                    isSelected: controller.assigneeType.value == "Transport"
                        ? true
                        : false,
                    title: "Transport",
                    onTap: () => controller.changeAssigneeType("Transport"),
                  ),
                ),
                Obx(
                  () => shopCard(
                    isSelected:
                        controller.assigneeType.value == "both" ? true : false,
                    title: "Both(Power & Millwright)",
                    onTap: () => controller.changeAssigneeType("both"),
                  ),
                ),
                customSizedBox(height: 15)
              ],
            ),
          ),
        ),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        mediumText(
          title: "Assignee Type",
          fontWeight: FontWeight.w600,
          fontSize: 14,
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
          child: Row(children: [
            Obx(
              () => smallText(
                title: controller.capitalizeFirstLetter(
                  controller.assigneeType.value.isNotEmpty
                      ? controller.assigneeType.value
                      : "Select Assignee Type",
                ),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontColor: AppColors.black,
              ),
            ),
            const Spacer(),
            SvgPicture.asset(ImgRoutes.ARROWDOWN),
          ]),
        ),
        customSizedBox(height: 10),
      ],
    ),
  );
}

Widget locationDialog({
  double height = 20,
  double width = 20,
}) {
  RaiseTicketController controller = Get.find<RaiseTicketController>();
  return GestureDetector(
    onTap: () => showDialog(
      context: Get.context!,
      builder: (context) => Padding(
        padding: EdgeInsets.symmetric(vertical: height * 0.1),
        child: AlertDialog(
          title: Row(
            children: [
              largeText(
                title: "Select Priority",
                fontSize: 22,
                fontColor: AppColors.black,
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.all(18.0),
                  child: SvgPicture.asset(ImgRoutes.CROSS),
                ),
              ),
            ],
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 10,
          ),
          scrollable: true,
          backgroundColor: AppColors.white,
          surfaceTintColor: AppColors.white,
          content: SizedBox(
            width: width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => shopCard(
                    title: "High",
                    onTap: () => controller.changePriorityIndex(0),
                    isSelected: controller.priorityIndex == 0 ? true : false,
                  ),
                ),
                Obx(
                  () => shopCard(
                    isSelected: controller.priorityIndex == 1 ? true : false,
                    title: "Medium",
                    onTap: () => controller.changePriorityIndex(1),
                  ),
                ),
                Obx(
                  () => shopCard(
                    isSelected: controller.priorityIndex == 2 ? true : false,
                    title: "Low",
                    onTap: () => controller.changePriorityIndex(2),
                  ),
                ),
                customSizedBox(height: 15)
              ],
            ),
          ),
        ),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        mediumText(
          title: "Priority",
          fontWeight: FontWeight.w600,
          fontSize: 14,
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
          child: Row(children: [
            Obx(
              () => smallText(
                title: controller.priorityIndex == 0
                    ? "High"
                    : controller.priorityIndex == 1
                        ? "Medium"
                        : "Low",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontColor: controller.priorityIndex == 0
                    ? AppColors.red
                    : controller.priorityIndex == 1
                        ? AppColors.yellow
                        : AppColors.green,
              ),
            ),
            const Spacer(),
            SvgPicture.asset(ImgRoutes.ARROWDOWN),
          ]),
        ),
        customSizedBox(height: 10),
      ],
    ),
  );
}

Widget attachmentField({
  double width = 20,
}) {
  RaiseTicketController controller = Get.find<RaiseTicketController>();
  return GestureDetector(
    onTap: () => Get.bottomSheet(
      imagePickerBottomsheet(
        label: "Choose Photos",
        onCamera: () {
          controller.takePhoto();
          Get.back();
        },
        onGallary: () {
          controller.selectAttachment();
          Get.back();
        },
      ),
    ),
    // onTap: () => controller.selectAttachment(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        mediumText(
          title: "Attachment",
          fontSize: 14,
          fontWeight: FontWeight.w600,
          fontColor: AppColors.black,
        ),
        customSizedBox(height: 10),
        Obx(() {
          RxList<String> selectedImage = controller.localImagePath;
          return controller.localImagePath.length != 0
              ? Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  runSpacing: 15,
                  spacing: 10,
                  children: List<Widget>.generate(
                    selectedImage.length,
                    (index) => Container(
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
                            File(
                              selectedImage[index],
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

Future<void> showActiveTicketFoundDiolog({
  required BuildContext context,
  required CheckActiveTicketModel res,
  required String machineName,
}) {
  RaiseTicketController controller = Get.find<RaiseTicketController>();

  Map<String, String> statuses = {
    '0': 'Raised',
    '1': 'Acknowledged',
    '2': 'Resolved',
    '3': 'Approved',
    '4': 'Unverified',
    '5': 'Reopened',
    '6': 'Cancelled',
  };
  String statusLabel =
      statuses[res.data.ticketDetails?.status.toString()] ?? 'Unknown';
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              ImgRoutes.TICKETPENDING,
            ),
            SizedBox(height: 8),
            largeText(
              title: "Active Ticket Found",
              textAlign: TextAlign.center,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              fontColor: AppColors.black,
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Table(
                border: TableBorder.all(color: Colors.grey, width: 0.5),
                columnWidths: {
                  0: FlexColumnWidth(1.5),
                  1: FlexColumnWidth(2.5),
                },
                children: [
                  buildTableRow(
                      "Ticket Number:", res.data.ticketNumber ?? ""),
                  buildTableRow("Status:", statusLabel),
                  buildTableRow("Machine:", machineName ?? 'N/A'),
                  buildTableRow("Raised By:",
                      res.data.ticketDetails?.raisedBy ?? 'Unknown'),
                ],
              ),
            ),
            SizedBox(height: 16),
            // mediumText(
            //   title:
            //       "A ticket is already raised for this machine.\nDo you still want to proceed?",
            //   textAlign: TextAlign.center,
            //   fontSize: 14,
            //   fontColor: Colors.black,
            // ),
            customSizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                customElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  fontSize: 14,
                  title: "Cancel ",
                  fontColor: AppColors.black,
                  padding: EdgeInsets.symmetric(
                    vertical: 7,
                    horizontal: 33,
                  ),
                  bgColor: AppColors.lightNavyBlue,
                ),
                customElevatedButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    await controller.raiseTicket();
                  },
                  fontSize: 14,
                  title: "Raise New",
                  padding: EdgeInsets.symmetric(
                    vertical: 7,
                    horizontal: 33,
                  ),
                  bgColor: AppColors.navyBlue,
                )
              ],
            ),
          ],
        ),
      );
    },
  );
}

TableRow buildTableRow(String label, String value) {
  return TableRow(
    decoration: BoxDecoration(color: Colors.white),
    children: [
      Padding(
        padding: EdgeInsets.all(8),
        child: mediumText(
            title: label,
            fontWeight: FontWeight.bold,
            fontColor: AppColors.black),
      ),
      Padding(
        padding: EdgeInsets.all(8),
        child: mediumText(
          title: value,
          fontColor: AppColors.black,
        ),
      ),
    ],
  );
}
