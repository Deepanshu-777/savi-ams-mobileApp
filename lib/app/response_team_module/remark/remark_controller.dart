import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:rail_weld/app/response_team_module/main_view/maintenance/maintenance_controller.dart';
import 'package:rail_weld/model/response_team_models/miantenance_detail_model.dart';
import 'package:rail_weld/model/scc_module_models/pms_details_model.dart';
import 'package:rail_weld/theme/app_colors.dart';

import '../../../routes/urls.dart';
import '../../../service/network_requester.dart';
import '../../../widgets/custom_popup.dart';
import '../../../widgets/custom_toast.dart';

/// -------------------- DYNAMIC ROW MODELS --------------------

class ManpowerRow {
  final TextEditingController tNo = TextEditingController();
  final TextEditingController date = TextEditingController();
  final TextEditingController hours = TextEditingController();
  final TextEditingController remarks = TextEditingController();
  final FocusNode tNoFocus = FocusNode();

  Map<String, String> toMap() => {
        "t_no": tNo.text.trim(),
        "date": date.text.trim(),
        "hours": hours.text.trim(),
        "remarks": remarks.text.trim(),
      };

  void dispose() {
    tNo.dispose();
    date.dispose();
    hours.dispose();
    remarks.dispose();
    tNoFocus.dispose();
  }
}

class MaterialRow {
  final TextEditingController name = TextEditingController();
  final TextEditingController qty = TextEditingController();
  final TextEditingController unit = TextEditingController();
  final TextEditingController cost = TextEditingController();
  final TextEditingController poNumber = TextEditingController();
  final TextEditingController remarks = TextEditingController();
  final FocusNode nameFocus = FocusNode();

  final RxString source = "Stock".obs;

  Map<String, String> toMap() => {
        "name": name.text.trim(),
        "qty": qty.text.trim(),
        "unit": unit.text.trim(),
        "cost": cost.text.trim(),
        "po_number": poNumber.text.trim(),
        "source": source.value,
        "remarks": remarks.text.trim(),
      };

  void dispose() {
    name.dispose();
    qty.dispose();
    unit.dispose();
    cost.dispose();
    poNumber.dispose();
    remarks.dispose();
    nameFocus.dispose();
  }
}

/// -------------------- CONTROLLER --------------------

class RemarkController extends GetxController {
  /// Controllers & dependencies
  final MaintenanceController maintenanceController =
      Get.find<MaintenanceController>();

  /// BASIC TEXT CONTROLLERS
  late TextEditingController maintenanceCost;
  late TextEditingController costOfMaterialController;
  late TextEditingController referencePOController;
  late TextEditingController outsourcedLabourController;
  late TextEditingController outsourcedMaterialController;

  final TextEditingController manpowerBreakdown = TextEditingController();
  final TextEditingController materialsBreakdown = TextEditingController();

  RxString maintenanceDoneDate = "".obs;

  Rx<PmsDetailsModel> pmsDetails = PmsDetailsModel().obs;

  Rx<MachineData?> machineData = Rx<MachineData?>(null);
  RxList<PmsTask> pmsTasks = <PmsTask>[].obs;
  RxList<String> loadedTypes = <String>[].obs; 
  RxList<String> loadedTaskTypes = <String>[].obs;
  Rx<ScheduleDetails?> scheduleDetails = Rx<ScheduleDetails?>(null);

   final Map<int, RxInt> pmsTaskWorkDone = {}; 
  final Map<int, TextEditingController> pmsTaskRemarks =
      {}; // taskId -> remark controller

  /// Derived flags
  RxBool isCrane = false.obs;
  RxString scheduledMaintenanceDate =
      "".obs; // dd/MM/yyyy used in query ?date= param

  /// API response after saving
  final Rx<MaintenanceDetail> maintenanceDetail = MaintenanceDetail().obs;

  /// ATTACHMENTS (base64)
  RxList<String> POBase64 = <String>[].obs;
  RxList<String> POLocalFiles = <String>[].obs;

  final ImagePicker picker = ImagePicker();
  String imageBaseUrl = "data:image/png;base64,";

  /// Wizard / step if needed in UI
  RxInt step = 1.obs;

  /// Dynamic rows
  final RxList<ManpowerRow> manpowerRows = <ManpowerRow>[].obs;
  final RxList<MaterialRow> materialRows = <MaterialRow>[].obs;

  /// Outsourced toggle
  RxBool isOutSourcedCheck = false.obs;

  /// -------------------- DYNAMIC ROWS HELPERS --------------------

  void updateBreakdowns() {
    try {
      final mp = manpowerRows.map((r) => r.toMap()).toList();
      final mat = materialRows.map((r) => r.toMap()).toList();
      manpowerBreakdown.text = jsonEncode(mp);
      materialsBreakdown.text = jsonEncode(mat);
    } catch (e) {
      manpowerBreakdown.text = '[]';
      materialsBreakdown.text = '[]';
    }
  }

  void addManpowerRow() {
    if (manpowerRows.isNotEmpty) {
      final last = manpowerRows.last;
      if (last.tNo.text.trim().isEmpty) {
        Future.delayed(const Duration(milliseconds: 120), () {
          last.tNoFocus.requestFocus();
        });
        customToast(
          msg: 'Please enter T.No before adding a new manpower row',
        );
        return;
      }
    }

    final row = ManpowerRow();
    row.tNo.addListener(updateBreakdowns);
    row.date.addListener(updateBreakdowns);
    row.hours.addListener(updateBreakdowns);
    row.remarks.addListener(updateBreakdowns);

    manpowerRows.add(row);
    Future.delayed(const Duration(milliseconds: 120), () {
      row.tNoFocus.requestFocus();
    });

    updateBreakdowns();
  }

  void removeManpowerRow(int index) {
    if (index >= 0 && index < manpowerRows.length) {
      final r = manpowerRows.removeAt(index);
      r.dispose();
      updateBreakdowns();
    }
  }

  void addMaterialRow() {
    if (materialRows.isNotEmpty) {
      final last = materialRows.last;
      if (last.name.text.trim().isEmpty) {
        Future.delayed(const Duration(milliseconds: 120), () {
          last.nameFocus.requestFocus();
        });
        customToast(
          msg: 'Please enter Material Name before adding a new material row',
        );
        return;
      }
    }

    final row = MaterialRow();
    row.name.addListener(updateBreakdowns);
    row.qty.addListener(updateBreakdowns);
    row.unit.addListener(updateBreakdowns);
    row.cost.addListener(updateBreakdowns);
    row.remarks.addListener(updateBreakdowns);

    materialRows.add(row);
    Future.delayed(const Duration(milliseconds: 120), () {
      row.nameFocus.requestFocus();
    });

    updateBreakdowns();
  }

  void removeMaterialRow(int index) {
    if (index >= 0 && index < materialRows.length) {
      final r = materialRows.removeAt(index);
      r.dispose();
      updateBreakdowns();
    }
  }

  bool validateDynamicRowsBeforeSubmit() {
    for (int i = 0; i < manpowerRows.length; i++) {
      if (manpowerRows[i].tNo.text.trim().isEmpty) {
        Future.delayed(const Duration(milliseconds: 120), () {
          manpowerRows[i].tNoFocus.requestFocus();
        });
        Get.snackbar(
          'Validation',
          'Please fill T.No for manpower row ${i + 1}',
          snackPosition: SnackPosition.BOTTOM,
        );
        return false;
      }
    }
    for (int i = 0; i < materialRows.length; i++) {
      if (materialRows[i].name.text.trim().isEmpty) {
        Future.delayed(const Duration(milliseconds: 120), () {
          materialRows[i].nameFocus.requestFocus();
        });
        Get.snackbar(
          'Validation',
          'Please fill Material Name for material row ${i + 1}',
          snackPosition: SnackPosition.BOTTOM,
        );
        return false;
      }
    }
    return true;
  }

  RxInt getTaskWorkDone(int taskId) {
    return pmsTaskWorkDone.putIfAbsent(taskId, () => 0.obs);
  }


  TextEditingController getTaskRemarkController(int taskId) {
    return pmsTaskRemarks.putIfAbsent(taskId, () => TextEditingController());
  }

 bool validatePmsTasksBeforeSubmit() {
    for (final task in pmsTasks) {
      final id = task.id;
      if (id == null) continue;

      final workDone = pmsTaskWorkDone[id]?.value;

      if (workDone == null) {
        customToast(msg: "Please mark YES or NO for all tasks.");
        return false;
      }
    }

    return true;
  }


  Future<void> _fetchPmsFormData() async {
    if (machineId == null) {
      log("PMS Form: machineId is null, aborting.");
      return;
    }

    final dateParam = scheduledMaintenanceDate.value;
    final path = "${Urls.PMSFORMDATA}/$machineId?date=$dateParam";

    log("PMS Form API -> $path");

    final response = await NetworkRequester().get(
      api: () async => await _fetchPmsFormData(),
      path: path,
      isLoader: true,
    );

    if (response == null) return;

    // PARSE MODEL DIRECTLY
    final model = PmsDetailsModel.fromJson(response);

    if (model.success != true) {
      customToast(msg: model.message ?? "Failed to load maintenance form.");
      return;
    }

    if (model.data?.maintenanceFormData == null) {
      customToast(msg: "Maintenance form data not found.");
      return;
    }

    pmsDetails.value = model;

    final form = model.data!.maintenanceFormData!;

    /// ---- Assign Machine Data ----
    machineData.value = form.machineData;

    /// ---- PMS Tasks ----
    pmsTasks.assignAll(form.pmsTasks ?? []);

    /// ---- Loaded task types ----
    loadedTaskTypes.assignAll(form.loadedTaskTypes ?? []);
    loadedTypes .assignAll(form.loadedTypes  ?? []);
    

    /// ---- Schedule details ----
    scheduleDetails.value = form.scheduleDetails;

    /// ---- Crane flag (same as before) ----
    isCrane.value = (machineData.value?.location?.toString() == "22");

    /// ---- Init task checkboxes / remark controllers ----
    _initPmsTaskModelState();

    log("PMS Form loaded: tasks=${pmsTasks.length}, schedule_id=${scheduleDetails.value?.scheduleId}");
  }

  void _initPmsTaskModelState() {
    // clear old
    pmsTaskWorkDone.clear();
    pmsTaskRemarks.forEach((_, c) => c.dispose());
    pmsTaskRemarks.clear();

    for (final task in pmsTasks) {
      final int? id = task.id;
      if (id == null) continue;

      pmsTaskWorkDone[id] = 0.obs; // default NO
      pmsTaskRemarks[id] = TextEditingController();
    }
  }

  /// -------------------- API: POST STORE MAINTENANCE --------------------

  Future<void> storeMaintenanceData() async {
    if (machineId == null) {
      customToast(msg: "Machine ID missing.");
      return;
    }

    if (maintenanceDoneDate.value.isEmpty) {
      customToast(msg: "Please select Maintenance Date");
      return;
    }

    if (!validateDynamicRowsBeforeSubmit()) {
      return;
    }

    if (!validatePmsTasksBeforeSubmit()) {
      return;
    }

    updateBreakdowns();

    // Build PMS tasks payload (same structure as web)
    final List<Map<String, dynamic>> pmsPayload = [];

    for (final task in pmsTasks) {
      final int? id = task.id;
      if (id == null) continue;

      final workDone = pmsTaskWorkDone[id]?.value ?? 0;
      final remarkText = pmsTaskRemarks[id]?.text.trim() ?? "";

      pmsPayload.add({
        "id": id,
        "task_number": task.taskNumber ?? "",
        "task_type": task.taskType ?? "",
        "task_name": task.taskName ?? "",
        "work_to_be_done": task.workToBeDone ?? "",
        "work_done": workDone,
        "remarks":  remarkText ?? "",
      });
    }

    final int scheduleId = scheduleDetails.value?.scheduleId ?? 0;
    final String scheduleIdStr = scheduleId.toString();

    final Map<String, dynamic> payload = {
      "machine_id": machineId,
      "schedule_id": scheduleIdStr,
      "maintenence_done_date": maintenanceDoneDate.value,
      "maintenance_cost": maintenanceCost.text.trim().isEmpty
          ? "0"
          : maintenanceCost.text.trim(),
      "manpower_breakdown": manpowerBreakdown.text,
      "materials_breakdown": materialsBreakdown.text,
      "cost_of_material": costOfMaterialController.text.trim().isEmpty
          ? "0"
          : costOfMaterialController.text.trim(),
      "reference_po": referencePOController.text.trim(),
      "outsourced_labour_cost": outsourcedLabourController.text.trim().isEmpty
          ? "0"
          : outsourcedLabourController.text.trim(),
      "outsourced_material_cost":
          outsourcedMaterialController.text.trim().isEmpty
              ? "0"
              : outsourcedMaterialController.text.trim(),
      "is_outsourced": isOutSourcedCheck.value ? 1 : 0,
      "is_crane": isCrane.value ? 1 : 0,
      "pms_tasks": jsonEncode(pmsPayload),
      // Mobile: still sending base64 array, BE can decode similar to file upload case
      "maintenence_attachments": POBase64,
    };

    // For debugging or backend use
    payload["maintenance_payload"] = jsonEncode(payload);

    final response = await NetworkRequester().post(
      api: () async => await storeMaintenanceData(),
      path: Urls.STOREMAINTENANCEDATA,
      data: payload,
    );

    if (response != null) {
      final res = jsonEncode(response);
      final decoded = jsonDecode(res);

      if (decoded["success"] == true) {
        maintenanceDetail.value = maintenanceDetailFromJson(res);
        await maintenanceController.scheduledMaintenanceList();

        popUp(
          content:
              "Maintenance completed and data securely saved for future reference.",
          onPressed: () async {
            await maintenanceController.getMaintenanceReport(
              id: maintenanceDetail.value.data?.savedData?.id ?? 0,
            );
            Get.back();
            Get.back();
            Get.back();
            Get.back();
          },
        );
      } else {
        customToast(
          msg: decoded["message"] ?? "Maintenance save failed.",
        );
      }
    }
  }

  /// -------------------- ATTACHMENT HELPERS --------------------

  void removeItemFromPOBase64(int index) {
    if (index >= 0 && index < POBase64.length) {
      POBase64.removeAt(index);
    }
  }

  void removeItemFromLocalImagePath(String element) {
    if (POLocalFiles.contains(element)) {
      POLocalFiles.remove(element);
    }
  }

  void takePhoto({
    required RxList<String> base64Image,
    required RxList<String> localImagePath,
  }) async {
    final pickedImage = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 20,
    );
    if (pickedImage?.path != "" && pickedImage?.path != null) {
      localImagePath.add(pickedImage?.path ?? "");
      File file = File(pickedImage?.path ?? "");
      Uint8List bytes = file.readAsBytesSync();
      base64Image.add("$imageBaseUrl${base64Encode(bytes)}");
    }
  }

  void selectAttachment({
    required RxList<String> base64Image,
    required RxList<String> localImagePath,
  }) async {
    final List<XFile> pickedImage =
        await picker.pickMultiImage(imageQuality: 20);
    if (pickedImage.isNotEmpty) {
      for (int i = 0; i < pickedImage.length; i++) {
        localImagePath.add(pickedImage[i].path);
        File file = File(pickedImage[i].path);
        Uint8List bytes = file.readAsBytesSync();
        base64Image.add("$imageBaseUrl${base64Encode(bytes)}");
      }
    }
  }

  /// -------------------- PUBLIC SUBMIT ENTRYPOINT --------------------

  void onSubmit() {
    if (maintenanceDoneDate.value == "") {
      customToast(msg: "Please select Maintenance Date");
      return;
    }

    if (!validateDynamicRowsBeforeSubmit()) {
      return;
    }

    if (!validatePmsTasksBeforeSubmit()) {
      return;
    }

    updateBreakdowns();
    storeMaintenanceData();
  }

  /// -------------------- LIFECYCLE --------------------

  num? machineId;

  @override
  void onInit() {
    super.onInit();
    maintenanceCost = TextEditingController();
    costOfMaterialController = TextEditingController();
    referencePOController = TextEditingController();
    outsourcedLabourController = TextEditingController();
    outsourcedMaterialController = TextEditingController();
    final args = Get.arguments;

    if (args is! Map) {
      customToast(msg: "Invalid screen navigation");
      Get.back();
      return;
    }

    final rawId = args["machine_id"];
    final rawDate = args["maintenance_date"];

    if (rawId == null || rawDate == null) {
      customToast(msg: "Missing maintenance data");
      Get.back();
      return;
    }

    if (rawId is num) {
      machineId = rawId;
    } else if (rawId is String) {
      machineId = num.tryParse(rawId);
    }

    String formatted;
    if (rawDate is String && rawDate.isNotEmpty) {
      try {
        final dt = DateTime.parse(rawDate);
        formatted = DateFormat('dd/MM/yyyy').format(dt);
      } catch (_) {
        formatted = rawDate;
      }
    } else {
      formatted = DateFormat('dd/MM/yyyy').format(DateTime.now());
    }

    scheduledMaintenanceDate.value = formatted;

    _fetchPmsFormData();
  }

  @override
  void onClose() {
    for (var r in manpowerRows) {
      r.dispose();
    }
    for (var r in materialRows) {
      r.dispose();
    }
    manpowerRows.clear();
    materialRows.clear();

    // dispose PMS remark controllers
    pmsTaskRemarks.forEach((_, c) => c.dispose());
    pmsTaskRemarks.clear();
    pmsTaskWorkDone.clear();

    maintenanceCost.dispose();
    costOfMaterialController.dispose();
    referencePOController.dispose();
    outsourcedLabourController.dispose();
    outsourcedMaterialController.dispose();
    manpowerBreakdown.dispose();
    materialsBreakdown.dispose();

    super.onClose();
  }

  /// -------------------- DATE PICKER --------------------

  Future selectDate({
    required RxString selectedDate,
    bool isFuture = false,
  }) async {
    final ThemeData customTheme = ThemeData.light().copyWith(
      colorScheme: ColorScheme.light(
        primary: AppColors.navyBlue,
        onPrimary: AppColors.white,
        onSurface: AppColors.black,
      ),
      dialogTheme: DialogThemeData(backgroundColor: AppColors.lightNavyBlue),
    );
    final DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: isFuture ? DateTime.now() : DateTime(1900),
      lastDate: isFuture ? DateTime(2100) : DateTime.now(),
      builder: (context, child) => Theme(
        data: customTheme,
        child: child!,
      ),
    );
    if (pickedDate != null) {
      String date = DateFormat('yyyy-MM-dd').format(pickedDate);
      selectedDate.value = date;
    }
  }

  /// Toggle outsourced and clear related fields
  void toggleOutSourced() {
    isOutSourcedCheck.value = !isOutSourcedCheck.value;
    outsourcedLabourController.clear();
    outsourcedMaterialController.clear();
  }
}
