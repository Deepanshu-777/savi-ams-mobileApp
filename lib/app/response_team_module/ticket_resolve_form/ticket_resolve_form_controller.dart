import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rail_weld/app/response_team_module/main_view/home/response_home_controller.dart';
import 'package:rail_weld/app/response_team_module/main_view/ticket_maintenance/ticket_maintenance_controller.dart';
import 'package:rail_weld/app/ssc_modules/main_view/home/home_controller.dart';
import 'package:rail_weld/model/scc_module_models/machine_details.dart';
import 'package:rail_weld/model/scc_module_models/staff_members_model.dart';
import 'package:rail_weld/model/scc_module_models/ticket_detail_model.dart';
import 'package:rail_weld/storage/storage.dart';
import '../../../routes/urls.dart';
import '../../../service/network_requester.dart';
import '../../../widgets/custom_popup.dart';
import '../../../widgets/custom_toast.dart';

class ManpowerRow {
  final RxString tNo = ''.obs; // holds empCode or similar
  final TextEditingController date = TextEditingController();
  final TextEditingController hours = TextEditingController();
  final TextEditingController remarks = TextEditingController();
  final FocusNode tNoFocus = FocusNode();

  Map<String, String> toMap() => {
        "t_no": tNo.value,
        "date": date.text.trim(),
        "hours": hours.text.trim(),
        "remarks": remarks.text.trim(),
      };

  void dispose() {
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

class DefectRow {
  final TextEditingController nature = TextEditingController();
  final TextEditingController work = TextEditingController();
  final FocusNode natureFocus = FocusNode();

  Map<String, String> toMap() => {
        "nature": nature.text.trim(),
        "work": work.text.trim(),
      };

  void dispose() {
    nature.dispose();
    work.dispose();
    natureFocus.dispose();
  }
}

class TicketResolveFormController extends GetxController {
  // Controllers
  late TextEditingController repairCost;
  late TextEditingController remarkController;
  late TextEditingController manpowerController;
  late TextEditingController materialsController;

  // Breakdowns to be sent to API (kept as controllers so UI/debugging can inspect)
  final TextEditingController manpowerBreakdown = TextEditingController();
  final TextEditingController materialsBreakdown = TextEditingController();
  final TextEditingController defectsBreakdown = TextEditingController();

  // IDs & status
  num? machineId;
  num? ticketId;
  final RxString status = ''.obs;

  // Lists
  final RxList<ManpowerRow> manpowerRows = <ManpowerRow>[].obs;
  final RxList<MaterialRow> materialRows = <MaterialRow>[].obs;
  final RxList<DefectRow> defectRows = <DefectRow>[].obs;

  // Models
  Rx<MachineDetailsModel> machineDetail = MachineDetailsModel().obs;
  RxBool isMaintenanceScheduled = false.obs;

  // Staff list: named `staff` to match the view
  Rx<StaffMembersModel> staff = StaffMembersModel().obs;

  // -------------------- BREAKDOWN UPDATES --------------------
  void updateBreakdowns() {
    try {
      manpowerBreakdown.text =
          jsonEncode(manpowerRows.map((r) => r.toMap()).toList());
      materialsBreakdown.text =
          jsonEncode(materialRows.map((r) => r.toMap()).toList());
      defectsBreakdown.text =
          jsonEncode(defectRows.map((r) => r.toMap()).toList());
    } catch (e) {
      manpowerBreakdown.text = '[]';
      materialsBreakdown.text = '[]';
      defectsBreakdown.text = '[]';
    }
  }

  // -------------------- MANPOWER --------------------
  void addManpowerRow() {
    if (manpowerRows.isNotEmpty) {
      final last = manpowerRows.last;
      if (last.tNo.value.trim().isEmpty) {
        Future.delayed(const Duration(milliseconds: 120), () {
          last.tNoFocus.requestFocus();
        });
        customToast(msg: 'Please select T.No before adding a new manpower row');
        return;
      }
    }
    final row = ManpowerRow();
    row.date.addListener(updateBreakdowns);
    row.hours.addListener(updateBreakdowns);
    row.remarks.addListener(updateBreakdowns);
    row.tNo.listen((_) => updateBreakdowns());
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

  // -------------------- MATERIALS --------------------
  void addMaterialRow() {
    if (materialRows.isNotEmpty) {
      final last = materialRows.last;
      if (last.name.text.trim().isEmpty) {
        Future.delayed(const Duration(milliseconds: 120), () {
          last.nameFocus.requestFocus();
        });
        customToast(
            msg: 'Please enter Material Name before adding a new material row');
        return;
      }
    }

    final row = MaterialRow();
    row.name.addListener(updateBreakdowns);
    row.qty.addListener(updateBreakdowns);
    row.unit.addListener(updateBreakdowns);
    row.cost.addListener(updateBreakdowns);
    row.remarks.addListener(updateBreakdowns);
    row.source.listen((_) => updateBreakdowns());

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

  // -------------------- DEFECTS --------------------
  void addDefectRow() {
    if (defectRows.isNotEmpty) {
      final last = defectRows.last;
      if (last.nature.text.trim().isEmpty) {
        Future.delayed(const Duration(milliseconds: 120), () {
          last.natureFocus.requestFocus();
        });
        customToast(
            msg: 'Please enter Nature of Defect before adding a new row');
        return;
      }
    }

    final row = DefectRow();
    row.nature.addListener(updateBreakdowns);
    row.work.addListener(updateBreakdowns);

    defectRows.add(row);
    Future.delayed(const Duration(milliseconds: 120), () {
      row.natureFocus.requestFocus();
    });

    updateBreakdowns();
  }

  void removeDefectRow(int index) {
    if (index >= 0 && index < defectRows.length) {
      final r = defectRows.removeAt(index);
      r.dispose();
      updateBreakdowns();
    }
  }

  // -------------------- VALIDATIONS --------------------
  bool validateDynamicRowsBeforeSubmit() {
    for (int i = 0; i < manpowerRows.length; i++) {
      if (manpowerRows[i].tNo.value.trim().isEmpty) {
        Future.delayed(const Duration(milliseconds: 120), () {
          manpowerRows[i].tNoFocus.requestFocus();
        });
        Get.snackbar(
            'Validation', 'Please select T.No for manpower row ${i + 1}',
            snackPosition: SnackPosition.BOTTOM);
        return false;
      }
    }
    for (int i = 0; i < materialRows.length; i++) {
      if (materialRows[i].name.text.trim().isEmpty) {
        Future.delayed(const Duration(milliseconds: 120), () {
          materialRows[i].nameFocus.requestFocus();
        });
        Get.snackbar(
            'Validation', 'Please fill Material Name for material row ${i + 1}',
            snackPosition: SnackPosition.BOTTOM);
        return false;
      }
    }
    for (int i = 0; i < defectRows.length; i++) {
      if (defectRows[i].nature.text.trim().isEmpty) {
        Future.delayed(const Duration(milliseconds: 120), () {
          defectRows[i].natureFocus.requestFocus();
        });
        Get.snackbar(
            'Validation', 'Please fill Nature of Defect for row ${i + 1}',
            snackPosition: SnackPosition.BOTTOM);
        return false;
      }
    }
    return true;
  }

  // -------------------- API CALL --------------------
  Future<void> changeTicketStatus({
    required String status,
    required String ticketId,
    String remark = "",
    String repair_cost = "",
  }) async {
    final response = await NetworkRequester().post(
      data: {
        "ticket_id": ticketId,
        "user_id": Storage.getUserId(),
        "status": status,
        "remarks": remark,
        "repair_cost": repair_cost,
        "manpower": manpowerBreakdown.text,
        "materials": materialsBreakdown.text,
        "defects": defectsBreakdown.text,
      },
      api: () async => await changeTicketStatus(
        status: status,
        ticketId: ticketId,
      ),
      path: Urls.CHANGETICKETSTATUS,
    );

    // if (response != null &&
    //     jsonDecode(jsonEncode(response))["success"] == true) {
    //   TicketDetailModel ticketDetail =
    //       await getTicketDetails(ticketId: ticketId);

    //   if (ticketDetail.data?.ticketetail?.status == "1") {
    //     Get.back();
    //     customToast(msg: "Something Went Wrong!");
    //   } else if (ticketDetail.data?.ticketetail?.status == "2") {
    //     customToast(msg: "Ticket Resolved Successfully!");
    //     Get.offAllNamed(Routes.RESPONSEMAINVIEW);

    //     // ResponseHomeController
    //     final responseHomeController = Get.put(ResponseHomeController());
    //     responseHomeController.getHomeDetails();

    //     // TicketMaintenanceController
    //     final ticketController = Get.put(TicketMaintenanceController());
    //     ticketController.changeFilterIndex(2);

    //     // ResponseMainViewController
    //     final mainViewController = Get.put(ResponseMainViewController());
    //     mainViewController.selectedTabIndex.value = 3;
    //   }
    // }
    if (response != null &&
        jsonDecode(jsonEncode(response))["success"] == true) {
      TicketMaintenanceController detailController =
          Get.find<TicketMaintenanceController>();
      TicketDetailModel ticketDetail =
          await detailController.getTicketDetailsNew(ticketId: ticketId);

      detailController.getTicketList();

      if (ticketDetail.data?.ticketetail?.status == "1") {
        customToast(msg: "Ticket Acknowledged!");
      } else if (ticketDetail.data?.ticketetail?.status == "2") {
        popUp(
          title: "Ticket Resolved!",
          isButton: false,
          onPressed: () => Get.back(),
          //   onPressed: () {
          //   Get.offAllNamed(Routes.RESPONSEMAINVIEW);
          //   final responseHomeController = Get.put(ResponseHomeController());
          //   responseHomeController.getHomeDetails();

          //   final ticketController = Get.put(TicketMaintenanceController());
          //   ticketController.changeFilterIndex(2);

          //   // ResponseMainViewController
          //   final mainViewController = Get.put(ResponseMainViewController());
          //   mainViewController.selectedTabIndex.value = 3;
          // },
        );
      }

      if (Get.isRegistered<HomeController>()) {
        Get.find<HomeController>().getHomeDetails(isLoader: false);
      }
      if (Get.isRegistered<ResponseHomeController>()) {
        Get.find<ResponseHomeController>().getHomeDetails(isLoader: false);
      }
      if (Get.isRegistered<TicketMaintenanceController>()) {
        Get.find<TicketMaintenanceController>().resetPagination();
        Get.find<TicketMaintenanceController>().getTicketList(isLoader: false);
      }
    }
  }

  Rx<TicketDetailModel> ticketDetails = TicketDetailModel().obs;

  Future<TicketDetailModel> getTicketDetails({
    String? ticketId,
    bool isSsc = false,
  }) async {
    final response = await NetworkRequester().post(
      api: () async => await getTicketDetails(),
      path: Urls.TICKETDETAIL,
      data: {
        "user_id": Storage.getUserId(),
        "ticket_id": ticketId,
      },
    );
    if (response != null) {
      String res = jsonEncode(response);
      if (jsonDecode(res)["success"] == true) {
        ticketDetails.value = ticketDetailModelFromJson(
          jsonEncode(response),
        );
      }
    }
    return ticketDetails.value;
  }

  void onSubmit() {
    if (remarkController.text.trim().isEmpty) {
      customToast(msg: "Please Enter Remarks");
      return;
    }
    if (!validateDynamicRowsBeforeSubmit()) return;

    updateBreakdowns(); // sync all rows before submit
    changeTicketStatus(
      status: "2",
      ticketId: (ticketId ?? machineId ?? 0).toString(),
      remark: remarkController.text.trim(),
      repair_cost: repairCost.text.trim(),
    );
  }

  // -------------------- INIT & CLEANUP --------------------
  @override
  void onInit() {
    super.onInit();

    // Initialize text controllers
    repairCost = TextEditingController();
    remarkController = TextEditingController();
    manpowerController = TextEditingController();
    materialsController = TextEditingController();

    // Parse Get.arguments robustly (support both Map and single-value)
    if (Get.arguments != null) {
      final args = Get.arguments;
      if (args is Map) {
        // Map-based navigation
        if (args.containsKey('machineId')) {
          final mid = args['machineId'];
          machineId = mid is num ? mid : int.tryParse(mid.toString());
        }

        if (args.containsKey('ticketId')) {
          ticketId = int.tryParse(args['ticketId']?.toString() ?? '') ??
              (args['ticketId'] is num ? args['ticketId'] : null);
        }
        status.value = args['status']?.toString() ?? '';
      } else {
        // Single value navigation: treat as machineId
        machineId =
            int.tryParse(args.toString()) ?? (args is num ? args : null);
      }
    }

    // Optionally: if you want to auto-add one empty row to match blade behavior,
    // uncomment these lines:
    // if (manpowerRows.isEmpty) addManpowerRow();
    // if (materialRows.isEmpty) addMaterialRow();
    // if (defectRows.isEmpty) addDefectRow();

    getMachineDetail();
    getStaffMembers();
  }

  @override
  void onClose() {
    for (var r in manpowerRows) r.dispose();
    for (var r in materialRows) r.dispose();
    for (var r in defectRows) r.dispose();

    manpowerRows.clear();
    materialRows.clear();
    defectRows.clear();

    repairCost.dispose();
    remarkController.dispose();
    manpowerController.dispose();
    materialsController.dispose();
    manpowerBreakdown.dispose();
    materialsBreakdown.dispose();
    defectsBreakdown.dispose();

    super.onClose();
  }

  // -------------------- GET MACHINE DETAILS --------------------
  Future<void> getMachineDetail({
    dynamic arguments,
    bool isLoader = true,
    bool isResponseTeam = false,
  }) async {
    if (machineId == null) return;

    final response = await NetworkRequester().get(
      api: () async => await getMachineDetail(),
      path: "${Urls.MACHINEDETAIL}/$machineId",
      isLoader: isLoader,
    );

    if (response != null) {
      machineDetail.value = machineDetailsModelFromJson(jsonEncode(response));

      final maintenance = machineDetail.value.data?.machineDetails?.maintenance;
      isMaintenanceScheduled.value = !(maintenance == null ||
          maintenance.toString().trim().isEmpty ||
          maintenance.toString() == "0");
    }
  }

  Future<void> getStaffMembers({bool isLoader = true}) async {
    final response = await NetworkRequester().get(
      path: Urls.STAFFMEMBERSLIST,
      api: () async => await getStaffMembers(),
      isLoader: isLoader,
    );
    if (response != null) {
      staff.value = staffMembersModelFromJson(jsonEncode(response));
    }
  }
}
