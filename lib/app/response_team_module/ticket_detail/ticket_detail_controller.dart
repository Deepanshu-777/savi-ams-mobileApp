import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rail_weld/app/response_team_module/main_view/home/response_home_controller.dart';
import 'package:rail_weld/app/ssc_modules/main_view/home/home_controller.dart';
import 'package:rail_weld/model/scc_module_models/ticket_detail_model.dart';
import 'package:rail_weld/routes/urls.dart';
import 'package:rail_weld/storage/storage.dart';
import 'package:rail_weld/widgets/custom_toast.dart';
import '../../../service/network_requester.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_popup.dart';
import '../main_view/ticket_maintenance/ticket_maintenance_controller.dart';

class RTicketDetailController extends GetxController {
  bool isSsc = Get.arguments;
  late TextEditingController acknowledgeRemark;
  late TextEditingController resolvedRemark;
  late TextEditingController repairCostController;
  late TextEditingController verificationRemark;
  late TextEditingController cancelTicketRemark;
  TicketMaintenanceController detailController =
      Get.find<TicketMaintenanceController>();
  RxBool isAcknowledged = false.obs;

  Future<bool> changeAcknowledgeStatus() async {
    isAcknowledged.value = !(isAcknowledged.value);
    return false;
  }

  RxBool isRessolved = false.obs;

  Future<bool> changeRessolveStatus() async {
    isRessolved.value = !(isRessolved.value);
    return false;
  }

  RxString selectedDate = "".obs;
  Future selectDate() async {
    final ThemeData customTheme = ThemeData.light().copyWith(
      colorScheme: ColorScheme.light(
        primary: AppColors.navyBlue,
        onPrimary: AppColors.white,
        onSurface: AppColors.black,
      ), dialogTheme: DialogThemeData(backgroundColor: AppColors.lightNavyBlue),
    );
    final DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2124),
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

  Future<void> changeTicketStatus({
    required String status,
    required String ticketId,
    String date = "",
    String remark = "",
    String repair_cost = "",
  }) async {
    final response = await NetworkRequester().post(
      data: {
        "ticket_id": ticketId,
        "user_id": Storage.getUserId(),
        "status": status,
        "change_details": "",
        "estimated_date": date,
        "remarks": remark,
        "repair_cost": repair_cost,
      },
      api: () async => await changeTicketStatus(
        status: status,
        ticketId: ticketId,
      ),
      path: Urls.CHANGETICKETSTATUS,
    );
    if (response != null) {
      String res = jsonEncode(response);
      if (jsonDecode(res)["success"] == true) {
        TicketDetailModel ticketDetail =
            await detailController.getTicketDetails(
          ticketId: ticketId,
        );
        detailController.getTicketList();
        if (ticketDetail.data?.ticketetail?.status == "1") {
          customToast(msg: "Ticket Acknowledged!");
        } else if (ticketDetail.data?.ticketetail?.status == "2") {
          popUp(
            title: "Ticket Resolved!",
            isButton: false,
            onPressed: () => Get.back(),
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
          Get.find<TicketMaintenanceController>()
              .getTicketList(isLoader: false);
        }
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    acknowledgeRemark = TextEditingController();
    resolvedRemark = TextEditingController();
    repairCostController = TextEditingController();
    verificationRemark = TextEditingController();
    cancelTicketRemark = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    acknowledgeRemark.dispose();
    resolvedRemark.dispose();
    repairCostController.dispose();
    verificationRemark.dispose();
    cancelTicketRemark.dispose();
  }
}
