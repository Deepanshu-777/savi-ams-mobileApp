import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rail_weld/app/response_team_module/ticket_resolve_form/ticket_resolve_form_controller.dart';
import 'package:rail_weld/model/scc_module_models/staff_members_model.dart';
import 'package:rail_weld/theme/app_colors.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_sized_box.dart';
import '../../../widgets/decorated_box.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/surety_dialog.dart';

class TicketResolveFormView extends GetView<TicketResolveFormController> {
  const TicketResolveFormView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: EdgeInsets.symmetric(horizontal: width * 0.055),
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
                  title: "Ticket Resolve Form",
                  fontSize: 20,
                  fontColor: AppColors.black,
                ),
                customSizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customSizedBox(height: 16),

                        // ---------------- Remark ----------------
                        TextFormField(
                          controller: controller.remarkController,
                          maxLines: null,
                          minLines: 4,
                          decoration: InputDecoration(
                            labelText: "Remark *",
                            hintText: "Enter your remark",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                        customSizedBox(height: 16),

                        // ---------------- Repair Cost ----------------
                        TextFormField(
                          controller: controller.repairCost,
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          decoration: InputDecoration(
                            labelText: "Repair Cost (₹) *",
                            hintText: "Enter repair cost",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                        customSizedBox(height: 20),
                        // ---------------- Defect Section ----------------
                        defectSection(context, width),
                        customSizedBox(height: 20),
                        // ---------------- Manpower Section ----------------
                        manpowerSection(context, width),
                        customSizedBox(height: 20),

                        // ---------------- Material Section ----------------
                        materialsSection(context, width),

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

  // ---------------- Manpower Section Widget ----------------
  Widget manpowerSection(BuildContext context, double width) {
    return Obx(() {
      final rows = controller.manpowerRows;
      List<StaffMemberList>? staffList =
          controller.staff.value.data?.staffMemberList ?? [];

      return ExpansionTile(
        backgroundColor: Colors.white,
        collapsedBackgroundColor: Colors.white,
        iconColor: Colors.black,
        collapsedIconColor: Colors.black,
        title: mediumText(
          title: "Manpower Breakdown",
          fontWeight: FontWeight.w600,
          fontSize: 16,
          fontColor: AppColors.black,
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
                          // Line 1: Staff Dropdown
                          Obx(() {
                            return DropdownButtonFormField<String>(
                              value:
                                  row.tNo.value.isEmpty ? null : row.tNo.value,
                              decoration: InputDecoration(
                                labelText: "Staff *",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              items: staffList
                                  .map((e) => DropdownMenuItem<String>(
                                        value: e.empId ?? "",
                                        child: Text("${e.name} (${e.empId})"),
                                      ))
                                  .toList(),
                              onChanged: (val) {
                                row.tNo.value = val ?? "";
                                controller.updateBreakdowns();
                              },
                            );
                          }),
                          const SizedBox(height: 8),

                          // Line 2: Date + Hours
                          Row(
                            children: [
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
                            ],
                          ),
                          const SizedBox(height: 8),

                          // Line 3: Remarks
                          TextFormField(
                            controller: row.remarks,
                            decoration: InputDecoration(
                              labelText: "Remarks (optional)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            onChanged: (_) => controller.updateBreakdowns(),
                          ),
                          const SizedBox(height: 6),

                          // Delete row button
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
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
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),

                // Add Row Button
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
                  title:
                      "Tip: Select staff for the current row to add a new one.",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontColor: AppColors.black.withOpacity(0.6),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  // ---------------- Materials Section Widget ----------------
  Widget materialsSection(BuildContext context, double width) {
    return Obx(() {
      final rows = controller.materialRows;
      return ExpansionTile(
        backgroundColor: Colors.white,
        collapsedBackgroundColor: Colors.white,
        iconColor: Colors.black,
        collapsedIconColor: Colors.black,
        title: mediumText(
          title: "Material Breakdown",
          fontWeight: FontWeight.w600,
          fontSize: 16,
          fontColor: AppColors.black,
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
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8)),
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
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                  decoration: InputDecoration(
                                    labelText: "Qty",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8)),
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
                          TextFormField(
                            controller: row.poNumber,
                            decoration: InputDecoration(
                              labelText: "PO Number",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            onChanged: (_) => controller.updateBreakdowns(),
                          ),
                          const SizedBox(height: 10),
                          Obx(() {
                            return DropdownButtonFormField<String>(
                              value: row.source.value,
                              decoration: InputDecoration(
                                labelText: "Source",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8)),
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
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: row.cost,
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                  decoration: InputDecoration(
                                    labelText: "Cost (₹)",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8)),
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
                                        borderRadius: BorderRadius.circular(8)),
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
          ),
        ],
      );
    });
  }

  // ---------------- Defect Section Widget ----------------
  Widget defectSection(BuildContext context, double width) {
    return Obx(() {
      final rows = controller.defectRows;
      return ExpansionTile(
        backgroundColor: Colors.white,
        collapsedBackgroundColor: Colors.white,
        iconColor: Colors.black,
        collapsedIconColor: Colors.black,
        title: mediumText(
          title: "Defects",
          fontWeight: FontWeight.w600,
          fontSize: 16,
          fontColor: AppColors.black,
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
                              Expanded(
                                child: TextFormField(
                                  controller: row.nature,
                                  decoration: InputDecoration(
                                    labelText: "Nature of Defect *",
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
                                      controller.removeDefectRow(idx);
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
                            controller: row.work,
                            decoration: InputDecoration(
                              labelText: "Work Done (optional)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            onChanged: (_) => controller.updateBreakdowns(),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: controller.addDefectRow,
                    icon: Icon(Icons.add, color: AppColors.black),
                    label: Text(
                      "Add Defect",
                      style: TextStyle(color: AppColors.black),
                    ),
                  ),
                ),
                SizedBox(height: 6),
                smallText(
                  title:
                      "Tip: Fill Nature of Defect of the current row to add a new one.",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontColor: AppColors.black.withOpacity(0.6),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
