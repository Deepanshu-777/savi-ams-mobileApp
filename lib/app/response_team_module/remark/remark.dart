import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rail_weld/app/response_team_module/remark/remark_controller.dart';
import 'package:rail_weld/model/scc_module_models/pms_details_model.dart';
import 'package:rail_weld/widgets/custom_sized_box.dart';
import 'package:rail_weld/widgets/image_picker_bottomsheet.dart';
import 'package:rail_weld/widgets/title_text_field.dart';

import '../../../routes/img_routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/decorated_box.dart';
import '../../../widgets/surety_dialog.dart';
import 'widgets.dart';

class RemarkView extends GetView<RemarkController> {
  const RemarkView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: EdgeInsets.symmetric(
          horizontal: width * 0.055,
        ),
        width: double.infinity,
        child: customElevatedButton(
          bgColor: AppColors.navyBlue,
          padding: const EdgeInsets.symmetric(vertical: 17),
          onPressed: () {
            controller.updateBreakdowns();
            if (!controller.validateDynamicRowsBeforeSubmit()) return;
            controller.onSubmit();
          },
          title: "Submit",
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            customAppBar(
              onBackPressed: () {
                Get.back();
                Get.back();
              },
            ),
            decoratedBox(
              width: width,
              padding: EdgeInsets.only(
                top: 30,
                left: width * 0.055,
                right: width * 0.055,
                bottom: 80,
              ),
              children: [
                largeText(
                  title: "Maintenance Summary",
                  fontSize: 20,
                  fontColor: AppColors.black,
                ),
                customSizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        dateTextField(
                          title: "Maintenance Date",
                          selectedDate: controller.maintenanceDoneDate,
                        ),

                        customSizedBox(height: 16),
                        Obx(() {
                          final tasks = controller.pmsTasks;

                          if (tasks.isEmpty) {
                            return smallText(
                              title:
                                  "No PMS tasks available for this schedule.",
                              fontColor: AppColors.greyE,
                            );
                          }

                          // GROUPS
                          final checkedTasks = tasks
                              .where((t) => t.type == "to_be_checked")
                              .toList();

                          final replacedTasks = tasks
                              .where((t) => t.type == "to_be_replaced")
                              .toList();

                          final List<String> typesToShow =
                              controller.loadedTaskTypes.isNotEmpty
                                  ? controller.loadedTaskTypes.toList()
                                  : ["nonperiodic"];

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ============================
                              // ITEMS TO BE CHECKED
                              // ============================
                              if (checkedTasks.isNotEmpty) ...[
                                customSizedBox(height: 16),
                                smallText(
                                  title: "Items to be Checked",
                                  fontColor: AppColors.navyBlue,
                                  fontWeight: FontWeight.w700,
                                ),
                              ],

                              for (final type in typesToShow) ...[
                                customSizedBox(height: 10),
                                if (checkedTasks
                                    .any((t) => t.taskType == type)) ...[
                                  smallText(
                                    title: "${type.capitalizeFirst} Checks",
                                    fontColor: AppColors.navyBlue,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  customSizedBox(height: 6),

                                  // --- UI Numbering Logic ---
                                  ...(() {
                                    final filtered = checkedTasks
                                        .where((t) => t.taskType == type)
                                        .toList();

                                    return filtered
                                        .asMap()
                                        .entries
                                        .map((entry) {
                                      final index = entry.key + 1;
                                      final task = entry.value;

                                      return _buildPmsTaskCard(
                                        context,
                                        width,
                                        task,
                                        index, 
                                      );
                                    }).toList();
                                  })(),
                                ],
                              ],

                              // ============================
                              // ITEMS TO BE REPLACED
                              // ============================
                              if (replacedTasks.isNotEmpty) ...[
                                customSizedBox(height: 20),
                                smallText(
                                  title: "Items to be Replaced",
                                  fontColor: Colors.red,
                                  fontWeight: FontWeight.w700,
                                ),
                              ],

                              for (final type in typesToShow) ...[
                                customSizedBox(height: 10),
                                if (replacedTasks
                                    .any((t) => t.taskType == type)) ...[
                                  smallText(
                                    title:
                                        "${type.capitalizeFirst} Replacements",
                                    fontColor: Colors.red,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  customSizedBox(height: 6),

                                  // --- UI Numbering Logic ---
                                  ...(() {
                                    final filtered = replacedTasks
                                        .where((t) => t.taskType == type)
                                        .toList();

                                    return filtered
                                        .asMap()
                                        .entries
                                        .map((entry) {
                                      final index = entry.key + 1;
                                      final task = entry.value;

                                      return _buildPmsTaskCard(
                                        context,
                                        width,
                                        task,
                                        index, 
                                      );
                                    }).toList();
                                  })(),
                                ],
                              ],
                            ],
                          );
                        },),

                        customSizedBox(height: 20),
                        attachmentField(
                          width: width,
                          title: "Maintenance Attachment",
                          localImagePath: controller.POLocalFiles,
                          base64Image: controller.POBase64,
                        ),
                        customSizedBox(height: 30),
                        titleTextField(
                          controller: controller.maintenanceCost,
                          hintText: "Enter Maintenance cost",
                          title: "Maintenance Cost (₹)",
                          titleFontSize: 12,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          validator: (val) {
                            if (val?.trim().isEmpty ?? true) {
                              return "Maintenance cost is required";
                            }
                            final cost = double.tryParse(val!);
                            if (cost == null || cost < 0) {
                              return "Enter a valid amount";
                            }
                            return null;
                          },
                        ),

                        customSizedBox(height: 10),

                        /// Is Outsourced toggle
                        Obx(
                          () {
                            bool isOutSourcedCheck =
                                controller.isOutSourcedCheck.value;
                            return InkWell(
                              onTap: () {
                                controller.toggleOutSourced();
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        isOutSourcedCheck
                                            ? ImgRoutes.TICKCHECKBOX
                                            : ImgRoutes.UNTICKCHECKBOX,
                                        height: 20,
                                        width: 20,
                                      ),
                                      customSizedBox(width: 7),
                                      smallText(
                                        title: "Is this work outsourced?",
                                        fontColor: AppColors.navyBlue,
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

                        /// Manpower Section (dynamic)
                        manpowerSection(context, width),

                        customSizedBox(height: 20),

                        /// Materials Section (dynamic)
                        materialsSection(context, width),

                        customSizedBox(height: 20),

                        /// Cost of Material
                        titleTextField(
                          controller: controller.costOfMaterialController,
                          hintText: "Enter cost of material",
                          title: "Cost of Material (₹)",
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                        ),

                        /// Reference PO
                        titleTextField(
                          controller: controller.referencePOController,
                          hintText: "Enter reference PO",
                          title: "Reference PO",
                        ),

                        /// Outsourced cost fields (conditional)
                        Obx(
                          () {
                            if (controller.isOutSourcedCheck.value) {
                              return Column(
                                children: [
                                  titleTextField(
                                    controller:
                                        controller.outsourcedLabourController,
                                    hintText: "Enter outsourced labour cost",
                                    title: "Outsourced Labour Cost (₹)",
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                  ),
                                  customSizedBox(height: 20),
                                  titleTextField(
                                    controller:
                                        controller.outsourcedMaterialController,
                                    hintText: "Enter outsourced material cost",
                                    title: "Outsourced Material Cost (₹)",
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                  ),
                                ],
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),

                        customSizedBox(height: 30),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// -------------------- PMS TASK CARD WIDGET --------------------
  Widget _buildPmsTaskCard(
    BuildContext context,
    double width,
    PmsTask task,
    int uiNumber,
  ) {
    final int? id = task.id;
    if (id == null) {
      return const SizedBox.shrink();
    }

    final RxInt workDone = controller.getTaskWorkDone(id);

    final TextEditingController remarkController =
        controller.getTaskRemarkController(id);

    return Obx(
      () => Card(
        margin: const EdgeInsets.symmetric(vertical: 6),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  smallText(
                    title: "Task ${uiNumber ?? ''}",
                    fontColor: AppColors.navyBlue,
                    fontWeight: FontWeight.w700,
                  ),
                  if (task.taskType != null && task.taskType!.isNotEmpty)
                    smallText(
                      title: task.taskType!.toUpperCase(),
                      fontColor: AppColors.greyE,
                      fontWeight: FontWeight.w600,
                    ),
                ],
              ),

              customSizedBox(height: 6),

              /// Task name
              smallText(
                title: task.taskName ?? "",
                fontColor: AppColors.black,
                fontWeight: FontWeight.w600,
              ),

              customSizedBox(height: 4),

              smallText(
                title: "Work To Be Done:",
                fontColor: Colors.black87,
                fontWeight: FontWeight.w600,
              ),

              customSizedBox(height: 2),

              smallText(
                title: task.workToBeDone ?? "",
                fontColor: AppColors.greyE,
                maxLines: 5,
              ),

              customSizedBox(height: 10),

              Row(
                children: [
                  Checkbox(
                    value: workDone.value == 1,
                    onChanged: (v) {
                      if (v == true) {
                        workDone.value = 1;
                      }
                    },
                    activeColor: AppColors.navyBlue,
                  ),
                  smallText(
                    title: "Yes",
                    fontColor: AppColors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(width: 20),
                  Checkbox(
                    value: workDone.value == 0,
                    onChanged: (v) {
                      if (v == true) {
                        workDone.value = 0;
                      }
                    },
                    activeColor: AppColors.navyBlue,
                  ),
                  smallText(
                    title: "No",
                    fontColor: AppColors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),

              customSizedBox(height: 8),

              titleTextField(
                controller: remarkController,
                hintText: "Enter remarks (optional)",
                title: "Remarks",
                titleFontSize: 11,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- Manpower Section Widget ----------------
  Widget manpowerSection(BuildContext context, double width) {
    return Obx(() {
      final rows = controller.manpowerRows;
      return ExpansionTile(
        backgroundColor: Colors.white,
        collapsedBackgroundColor: Colors.white,
        iconColor: Colors.black,
        collapsedIconColor: Colors.black,
        title: Row(
          children: [
            mediumText(
              title: "Manpower Breakdown",
              fontWeight: FontWeight.w600,
              fontSize: 16,
              fontColor: AppColors.black,
            ),
          ],
        ),
        initiallyExpanded: rows.isNotEmpty,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6),
            child: Column(
              children: [
                ...rows.asMap().entries.map((entry) {
                  final idx = entry.key;
                  final row = entry.value;
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 6),
                    color: Colors.white,
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Flexible(
                                flex: 3,
                                child: TextFormField(
                                  controller: row.tNo,
                                  focusNode: row.tNoFocus,
                                  decoration: InputDecoration(
                                    labelText: "T.No *",
                                    hintText: "EMP123",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  textInputAction: TextInputAction.next,
                                  onChanged: (_) =>
                                      controller.updateBreakdowns(),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Flexible(
                                flex: 3,
                                child: GestureDetector(
                                  onTap: () async {
                                    final picked = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2100),
                                    );
                                    if (picked != null) {
                                      row.date.text =
                                          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                                      controller.updateBreakdowns();
                                    }
                                  },
                                  child: AbsorbPointer(
                                    child: TextFormField(
                                      controller: row.date,
                                      decoration: InputDecoration(
                                        labelText: "Date",
                                        hintText: "Select",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Flexible(
                                flex: 2,
                                child: TextFormField(
                                  controller: row.hours,
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                  decoration: InputDecoration(
                                    labelText: "Hours",
                                    hintText: "e.g. 5",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                  onChanged: (_) =>
                                      controller.updateBreakdowns(),
                                ),
                              ),
                              const SizedBox(width: 6),
                              IconButton(
                                onPressed: () {
                                  suretyDialog(
                                    onNoPressed: () => Get.back(),
                                    onYesPressed: () {
                                      controller.removeManpowerRow(idx);
                                      Get.back();
                                    },
                                    title:
                                        "Are you sure you want to remove this row?",
                                  );
                                },
                                icon: Icon(Icons.delete, color: Colors.red),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: row.remarks,
                            decoration: InputDecoration(
                              labelText: "Remarks (optional)",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onChanged: (_) => controller.updateBreakdowns(),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),

                // add button
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: controller.addManpowerRow,
                    icon: Icon(Icons.add, color: AppColors.black),
                    label: Text("Add Manpower",
                        style: TextStyle(color: AppColors.black)),
                  ),
                ),
                SizedBox(height: 6),
                smallText(
                  title: "Tip: Fill T.No of the current row to add a new one.",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontColor: AppColors.black.withOpacity(0.6),
                ),
              ],
            ),
          )
        ],
      );
    });
  }

  // ---------------- Materials Section Widget ----------------
  Widget materialsSection(BuildContext context, double width) {
    return Obx(
      () {
        final rows = controller.materialRows;
        return ExpansionTile(
          backgroundColor: Colors.white,
          collapsedBackgroundColor: Colors.white,
          iconColor: Colors.black,
          collapsedIconColor: Colors.black,
          title: Row(
            children: [
              mediumText(
                title: "Material Breakdown",
                fontWeight: FontWeight.w600,
                fontSize: 16,
                fontColor: AppColors.black,
              ),
            ],
          ),
          initiallyExpanded: rows.isNotEmpty,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6),
              child: Column(
                children: [
                  ...rows.asMap().entries.map((entry) {
                    final idx = entry.key;
                    final row = entry.value;
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 6),
                      color: Colors.white,
                      elevation: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  flex: 4,
                                  child: TextFormField(
                                    controller: row.name,
                                    focusNode: row.nameFocus,
                                    decoration: InputDecoration(
                                      labelText: "Material Name *",
                                      hintText: "e.g. Bearing",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    onChanged: (_) =>
                                        controller.updateBreakdowns(),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Flexible(
                                  flex: 2,
                                  child: TextFormField(
                                    controller: row.qty,
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            decimal: true),
                                    decoration: InputDecoration(
                                      labelText: "Qty",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    onChanged: (_) =>
                                        controller.updateBreakdowns(),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Flexible(
                                  flex: 2,
                                  child: TextFormField(
                                    controller: row.unit,
                                    decoration: InputDecoration(
                                      labelText: "Unit",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    onChanged: (_) =>
                                        controller.updateBreakdowns(),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                IconButton(
                                  onPressed: () {
                                    suretyDialog(
                                      onNoPressed: () => Get.back(),
                                      onYesPressed: () {
                                        controller.removeMaterialRow(idx);
                                        Get.back();
                                      },
                                      title:
                                          "Are you sure you want to remove this row?",
                                    );
                                  },
                                  icon: Icon(Icons.delete, color: Colors.red),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: row.poNumber,
                                    decoration: InputDecoration(
                                      labelText: "PO Number",
                                      hintText: "e.g. PO-2025-01",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    onChanged: (_) =>
                                        controller.updateBreakdowns(),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: Obx(() {
                                    return DropdownButtonFormField<String>(
                                      value: row.source.value,
                                      decoration: InputDecoration(
                                        labelText: "Source",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      items: [
                                        "Stock",
                                        "Non-Stock",
                                        "Imprest",
                                        "Shop Manufactured"
                                      ]
                                          .map((e) => DropdownMenuItem<String>(
                                                value: e,
                                                child: Text(e),
                                              ))
                                          .toList(),
                                      onChanged: (val) {
                                        if (val != null) {
                                          row.source.value = val;
                                          controller.updateBreakdowns();
                                        }
                                      },
                                    );
                                  }),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: row.cost,
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            decimal: true),
                                    decoration: InputDecoration(
                                      labelText: "Cost (₹)",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    onChanged: (_) =>
                                        controller.updateBreakdowns(),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: TextFormField(
                                    controller: row.remarks,
                                    decoration: InputDecoration(
                                      labelText: "Remarks (optional)",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    onChanged: (_) =>
                                        controller.updateBreakdowns(),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),

                  // 🔹 Add Button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      onPressed: controller.addMaterialRow,
                      icon: Icon(Icons.add, color: AppColors.black),
                      label: Text(
                        "Add Material",
                        style: TextStyle(color: AppColors.black),
                      ),
                    ),
                  ),
                  SizedBox(height: 6),
                  smallText(
                    title:
                        "Tip: Fill Material Name of the current row to add a new one.",
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontColor: AppColors.black.withOpacity(0.6),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}

Widget dateTextField({
  String title = "",
  required RxString selectedDate,
  bool isFuture = false,
}) {
  RemarkController controller = Get.find<RemarkController>();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      mediumText(
        title: title,
        fontWeight: FontWeight.w500,
        fontColor: AppColors.black,
        fontSize: 16,
      ),
      customSizedBox(height: 10),
      GestureDetector(
        onTap: () => controller.selectDate(
          selectedDate: selectedDate,
          isFuture: isFuture,
        ),
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
                  String date = selectedDate.value == ""
                      ? "Select Date"
                      : selectedDate.value;
                  return smallText(
                    title: date,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: date == "Select Date"
                        ? AppColors.black
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
      customSizedBox(height: 25),
    ],
  );
}

Widget attachmentField({
  double width = 20,
  String title = "Attachment",
  required RxList<String> localImagePath,
  required RxList<String> base64Image,
  double fontSize = 16,
  Widget? widget,
}) {
  return GestureDetector(
    onTap: () {},
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        mediumText(
          title: title,
          fontWeight: FontWeight.w500,
          fontColor: AppColors.black,
          fontSize: fontSize,
        ),
        customSizedBox(height: 10),
        SizedBox(
          height: 10,
        ),
        Obx(() {
          RxList<String> selectedImage = localImagePath;
          return (localImagePath.length != 0)
              ? Wrap(
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  runSpacing: 15,
                  spacing: 10,
                  children: List<Widget>.generate(
                    selectedImage.length + 1,
                    (index) {
                      if (index == selectedImage.length) {
                        return GestureDetector(
                          onTap: () => Get.bottomSheet(
                            imagePickerBottomsheet(
                              label: "Choose Photos",
                              onCamera: () {
                                RemarkController controller =
                                    Get.find<RemarkController>();
                                controller.takePhoto(
                                  base64Image: base64Image,
                                  localImagePath: localImagePath,
                                );
                                Get.back();
                              },
                              onGallary: () {
                                RemarkController controller =
                                    Get.find<RemarkController>();
                                controller.selectAttachment(
                                  base64Image: base64Image,
                                  localImagePath: localImagePath,
                                );
                                Get.back();
                              },
                            ),
                          ),
                          child: Container(
                            height: 90,
                            width: width * 0.235,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppColors.offWhite,
                                width: 1,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: AppColors.navyBlue,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: AppColors.white,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                smallText(
                                  title: "Add",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontColor: AppColors.black,
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                suretyDialog(
                                  onNoPressed: () => Get.back(),
                                  onYesPressed: () {
                                    RemarkController controller =
                                        Get.find<RemarkController>();
                                    controller.removeItemFromLocalImagePath(
                                        selectedImage[index]);
                                    Get.back();
                                  },
                                );
                              },
                              child: Container(
                                height: 90,
                                width: width * 0.235,
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
                                child: (selectedImage[index].contains("png") ||
                                        selectedImage[index].contains("jpg") ||
                                        selectedImage[index].contains("webp"))
                                    ? const SizedBox()
                                    : Icon(Icons.file_copy),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  suretyDialog(
                                    onNoPressed: () => Get.back(),
                                    onYesPressed: () {
                                      RemarkController controller =
                                          Get.find<RemarkController>();
                                      controller.removeItemFromLocalImagePath(
                                          selectedImage[index]);
                                      Get.back();
                                    },
                                  );
                                },
                                child: SvgPicture.asset(
                                  ImgRoutes.DELETE,
                                ),
                              ),
                            ),
                            widget ?? const SizedBox(),
                          ],
                        );
                      }
                    },
                  ),
                )
              : GestureDetector(
                  onTap: () => Get.bottomSheet(
                    imagePickerBottomsheet(
                      label: "Choose Photos",
                      onCamera: () {
                        RemarkController controller =
                            Get.find<RemarkController>();
                        controller.takePhoto(
                          base64Image: base64Image,
                          localImagePath: localImagePath,
                        );
                        Get.back();
                      },
                      onGallary: () {
                        RemarkController controller =
                            Get.find<RemarkController>();
                        controller.selectAttachment(
                          base64Image: base64Image,
                          localImagePath: localImagePath,
                        );
                        Get.back();
                      },
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 26, vertical: 11),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.offWhite,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: AppColors.navyBlue,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            color: AppColors.white,
                            size: 20,
                          ),
                        ),
                        const SizedBox(height: 8),
                        smallText(
                          title: "Add",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontColor: AppColors.black,
                        ),
                      ],
                    ),
                  ),
                );
        }),
        customSizedBox(height: 10),
      ],
    ),
  );
}
