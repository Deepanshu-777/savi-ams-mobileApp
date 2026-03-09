import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rail_weld/app/response_team_module/main_view/home/response_home_controller.dart';
import 'package:rail_weld/app/response_team_module/main_view/res_machine_list/res_machine_list_controller.dart';
import 'package:rail_weld/app/response_team_module/main_view/response_main_view_controller.dart';
import 'package:rail_weld/app/response_team_module/main_view/ticket_maintenance/ticket_maintenance_controller.dart';
import 'package:rail_weld/app/ssc_modules/main_view/home/home_controller.dart';
import 'package:rail_weld/app/ssc_modules/main_view/ticket_request/ticket_request_controller.dart';
import 'package:rail_weld/app/ssc_modules/raise_ticket/widget.dart';
import 'package:rail_weld/app/ssc_modules/ticket_raised/ticket_raised_controller.dart';
import 'package:rail_weld/model/scc_module_models/check_active_ticket_model.dart';
import 'package:rail_weld/model/scc_module_models/designation_model.dart';
import 'package:rail_weld/model/scc_module_models/raise_ticket_model.dart';
import 'package:rail_weld/storage/storage.dart';
import 'package:rail_weld/widgets/custom_toast.dart';
import '../../../model/scc_module_models/issue_code_model.dart';
import '../../../model/scc_module_models/machine_details.dart';
import '../../../routes/urls.dart';
import '../../../service/network_requester.dart';
import '../main_view/total_machines/total_machines_controller.dart';
import '../../../../model/scc_module_models/ticket_request_model.dart';

class RaiseTicketController extends GetxController {
  GlobalKey<FormState> raiseTicketFormKey = GlobalKey<FormState>();
  late TextEditingController issueCode;
  late TextEditingController issueDescription;
  late TextEditingController empName;
  late TextEditingController designation;
  late TextEditingController phone;
  late TextEditingController batch_no;
  final ImagePicker picker = ImagePicker();
  RxBool isFromRequest = false.obs;
  @override
  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;

    log('onInit: Received arguments => $args');

    if (args != null) {
      if (args is Machine) {
        if (args.ticketRequestId != null) {
          isFromRequest.value = true;
          log('onInit: ticketRequestId found: ${args.ticketRequestId}');
        } else {
          log('onInit: ticketRequestId is null in Machine');
        }
      } else {
        log('onInit: Get.arguments is not a Machine instance');
      }
    } else {
      log('onInit: Get.arguments is null');
    }

    issueList();
    designationsList();
    issueCode = TextEditingController();
    issueDescription = TextEditingController();
    empName = TextEditingController();
    designation = TextEditingController();
    phone = TextEditingController();
    batch_no = TextEditingController();
    empName.text = Storage.getName() ?? "";
    phone.text = (Storage.getPhone() ?? 0).toString();
  }

  @override
  void onClose() {
    super.onClose();
    issueCode.dispose();
    issueDescription.dispose();
    empName.dispose();
    designation.dispose();
    phone.dispose();
    batch_no.dispose();
  }

  RxInt priorityIndex = 0.obs;

  RxString assigneeType = "".obs;
  void changeAssigneeType(String value) {
    assigneeType.value = value;
    Get.back();
  }

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  void changePriorityIndex(int index) {
    priorityIndex.value = index;
    Get.back();
  }

  RxInt currentMachineStatus = 0.obs;

  void changeCurrentMachineStatus(int index) {
    currentMachineStatus.value = index;
    Get.back();
  }

  RxString machineStatus = "Working".obs;

  void changeMachineStatus(String status) {
    machineStatus.value = status;
  }

  RxList<int> issueCodeId = <int>[].obs;

  void changeIssueCodeId(int id) {
    issueCodeId.contains(id) ? issueCodeId.remove(id) : issueCodeId.add(id);
    log(issueCodeId.toString());
  }

  RxList<String> issueCodeTitle = <String>[].obs;

  void changeIssueCodeTitle(String title) {
    issueCodeTitle.contains(title)
        ? issueCodeTitle.remove(title)
        : issueCodeTitle.add(title);
  }

  Future<void> checkActiveTicket(BuildContext context) async {
    if (assigneeType == "") {
      customToast(msg: "Please Select Assignee Type");
      return;
    }

    dynamic machineDetails;

    if (isFromRequest.value) {
      machineDetails = Get.arguments as Machine?;
    } else {
      machineDetails = Get.arguments as MachineDetails?;
    }

    final response = await NetworkRequester().post(
      api: () async => await checkActiveTicket(context),
      path: Urls.CHECKACTIVETICKET,
      data: {
        "user_id": Storage.getUserId(),
        "machine_id": machineDetails?.id.toString(),
      },
    );

    if (response != null) {
      CheckActiveTicketModel res = checkActiveTicketModelFromJson(
        jsonEncode(response),
      );

      if (res.message == "ONE_ACTIVE_TICKET") {
        showActiveTicketFoundDiolog(
            context: context,
            res: res,
            machineName: machineDetails?.name ?? "");
      } else if (res.message == "NO_ACTIVE_TICKET") {
        await raiseTicket();
      }
    } else {
      customToast(msg: "⚠️ 2 Active tickets already exist for this machine.");
    }
  }

  Future<void> raiseTicket() async {
    TicketRaisedController controller = Get.find<TicketRaisedController>();
    dynamic machineDetails;
    if (isFromRequest.value) {
      machineDetails = Get.arguments as Machine?;
    } else {
      machineDetails = Get.arguments as MachineDetails?;
    }
    final response = await NetworkRequester().post(
      api: () async => await raiseTicket(),
      path: Urls.RAISETICKET,
      data: {
        "user_id": Storage.getUserId(),
        "machine_name": machineDetails?.name ?? "",
        "machine_id": machineDetails?.id.toString(),
        "working_status": currentMachineStatus.value.toString(),
        "issue_code": issueCodeId,
        "priority": priorityIndex.value == 0
            ? "High"
            : priorityIndex.value == 1
                ? "Medium"
                : "Low",
        "vender_name": machineDetails?.vendorName ?? "",
        "vender_number": machineDetails?.vendorPhoneNumber ?? "",
        "description": issueDescription.value.text,
        "attachments": base64Image,
        "assignee_type": assigneeType.value,
        "emp_name": empName.text.trim(),
        "designation": selectedDesignationId.value,
        "phone": phone.text.trim(),
        "batch_no": batch_no.text.trim(),
        "ticket_request_id":
            isFromRequest.value ? machineDetails.ticketRequestId : "",
      },
    );
    if (response != null) {
      if (jsonDecode(jsonEncode(response))["success"] == true) {
        customToast(msg: "    Ticket raised successfully   ");
        RaiseTicketModel res = raiseTicketModelFromJson(
          jsonEncode(response),
        );

        await controller.ticketDetail(
          ticketId: res.data?.ticketId.toString() ?? "",
        );
        if (isFromRequest.value) {
          if (Get.isRegistered<TicketRequestController>()) {
            await Get.find<TicketRequestController>().ticketRequestProcessNew(
              action: 'accept',
              ticketRequestId: machineDetails.ticketRequestId,
              ticket_id: res.data?.ticketId.toString(),
            );
          } else {
            await Get.put(TicketRequestController()).ticketRequestProcessNew(
              action: 'accept',
              ticketRequestId: machineDetails.ticketRequestId,
              ticket_id: res.data?.ticketId.toString(),
            );
          }
        }
        if (Get.isRegistered<TickerCanceled>()) {
          await Get.find<TicketMaintenanceController>().getTicketList();
        }
        if (Get.isRegistered<TotalMachinesController>()) {
          Get.find<TotalMachinesController>().resetFilter();
          await Get.find<TotalMachinesController>().getMachineList();
        } else if (Get.isRegistered<ResMachineListController>()) {
          Get.find<ResMachineListController>().resetFilter();
          await Get.find<ResMachineListController>().getMachineList();
        }
        if (Get.isRegistered<TicketMaintenanceController>()) {
        Get.find<TicketMaintenanceController>().resetPagination();
          await Get.find<TicketMaintenanceController>().getTicketList();
        }
        if (Get.isRegistered<HomeController>()) {
          await Get.find<HomeController>().getHomeDetails();
        }
        if (Get.isRegistered<ResponseHomeController>()) {
          Get.find<ResponseHomeController>().getHomeDetails(isLoader: false);
        } else {
          await Get.put(ResponseHomeController())
              .getHomeDetails(isLoader: false);
        }

        if (Get.isRegistered<ResponseMainViewController>()) {
          Get.find<ResponseMainViewController>();
        } else {
          await Get.put(ResponseMainViewController());
        }
      }
    }
  }

  RxList<IssueCodeList> issueCodeList = <IssueCodeList>[].obs;

  Future<void> issueList() async {
    final response = await NetworkRequester().get(
      api: () async => await issueCodeList(),
      path: Urls.ISSUECODELIST,
    );
    if (response != null) {
      String res = jsonEncode(response);
      if (jsonDecode(res)["success"] == true) {
        IssueCodeModel res = issueCodeModelFromJson(
          jsonEncode(response),
        );
        issueCodeList.value = res.data?.issueCodeList ?? [];
        log("message: ${issueCodeList.length}");
      }
    }
  }

  RxInt selectedDesignationId = 0.obs;
  RxString selectedDesignationTitle = "".obs;

  RxList<DesignationList> designationList = <DesignationList>[].obs;

  Future<void> designationsList() async {
    final response = await NetworkRequester().get(
      api: () async => await designationsList(),
      path: Urls.DESIGNATIONLIST,
    );
    if (response != null) {
      String res = jsonEncode(response);
      if (jsonDecode(res)["success"] == true) {
        DesignationModel res = designationModelFromJson(
          jsonEncode(response),
        );
        designationList.value = res.data.designationList ?? [];
      }
    }
  }

  RxList<String> base64Image = <String>[].obs;
  RxList<String> localImagePath = <String>[].obs;
  String imageBaseUrl = "data:image/png;base64,";

  void selectAttachment() async {
    final List<XFile> pickedImage =
        await picker.pickMultiImage(imageQuality: 20);
    if (pickedImage.isNotEmpty) {
      for (int i = 0; i < pickedImage.length; i++) {
        localImagePath.add(pickedImage[i].path);
        File file = File(pickedImage[i].path);
        Uint8List bytes = file.readAsBytesSync();
        base64Image.add("${imageBaseUrl}${base64Encode(bytes)}");
      }
    }
  }

  void takePhoto() async {
    final pickedImage = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 20,
    );
    log("Img :: ${pickedImage?.path.toString()}");
    if (pickedImage?.path != "") {
      localImagePath.add(pickedImage?.path ?? "");
      File file = File(pickedImage?.path ?? "");
      Uint8List bytes = file.readAsBytesSync();
      base64Image.add("${imageBaseUrl}${base64Encode(bytes)}");
    }
  }
}
