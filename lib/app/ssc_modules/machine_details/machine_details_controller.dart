import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rail_weld/app/ssc_modules/main_view/home/home_controller.dart';
import 'package:rail_weld/app/ssc_modules/main_view/total_machines/total_machines_controller.dart';
import 'package:rail_weld/model/response_team_models/maintenance_report.dart';
import 'package:rail_weld/model/scc_module_models/machine_details_edit.dart';
import 'package:rail_weld/routes/app_pages.dart';
import 'package:rail_weld/storage/storage.dart';
import 'package:rail_weld/widgets/custom_toast.dart';
import '../../../model/scc_module_models/machine_details.dart';
import '../../../routes/urls.dart';
import '../../../service/network_requester.dart';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../widgets/custom_loader.dart';

class MachineDetailsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  late TextEditingController abondenedRemark;
  late TextEditingController raisedByRemarks;
  final data = Get.arguments;
  RxString? role = "3".obs;

  RxString fromDay = ''.obs;
  RxString fromMonth = ''.obs;
  RxString fromYear = ''.obs;

  RxString toDay = ''.obs;
  RxString toMonth = ''.obs;
  RxString toYear = ''.obs;

  RxBool isReportDetailed = true.obs;
  RxString selectedReportType = "Both".obs; // default selection

  void toggleReportType() {
    isReportDetailed.value = !isReportDetailed.value;
  }

  @override
  void onInit() {
    super.onInit();
    abondenedRemark = TextEditingController();
    raisedByRemarks = TextEditingController();
    tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: 0,
    );
    role?.value = Storage.getRole() ?? "3";
    if (data?["machineId"] != null) {
      getMachineDetail(machineId: data?["machineId"] ?? 0);
    }
    log("maintenance_datemaintenance_datemaintenance_date ${data?["maintenance_date"]}");

    // monthController = TextEditingController();
  }

  RxInt tabIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  RxBool isExpanded = false.obs;

  void toggleExpand() {
    isExpanded.value = !(isExpanded.value);
  }

  RxInt selectedDetailIndex = 0.obs;

  void changeSelectedDetailIndex(int currentIndex) {
    selectedDetailIndex.value = currentIndex;
  }

  Rx<MachineDetailsModel> machineDetail = MachineDetailsModel().obs;
  num? id;
  Future<void> getMachineDetail({
    required num machineId,
    dynamic arguments = null,
    bool isLoader = true,
  }) async {
    id = machineId;
    final response = await NetworkRequester().get(
      api: () async => await getMachineDetail(machineId: machineId),
      path: "${Urls.MACHINEDETAIL}/$machineId",
      isLoader: isLoader,
    );
    if (response != null) {
      machineDetail.value = machineDetailsModelFromJson(
        jsonEncode(response),
      );
    }
  }

  Future<void> editMaintenance({
    required String machineId,
    required String month,
  }) async {
    final response = await NetworkRequester().post(
      api: () async => await editMaintenance(
        machineId: machineId,
        month: month,
      ),
      path: Urls.EDITMAINTENANCE,
      data: {
        "machine_id": machineId,
        "maintenence_month": month,
      },
    );
    String res = jsonEncode(response);
    if (jsonDecode(res)["success"] == true) {
      customToast(msg: "Maintenance Edited!");
    }
  }

  Future<void> getMachineDetailToEdit() async {
    final response = await NetworkRequester().get(
      api: () async => await getMachineDetailToEdit(),
      path: "${Urls.MACHINEDETAILFOREDIT}/$id",
    );
    String res = jsonEncode(response);
    if (jsonDecode(res)["success"] == true) {
      MachineDetailsToEdit details = machineDetailsToEditFromJson(
        jsonEncode(response),
      );
      Get.toNamed(
        Routes.ADDMACHINE,
        arguments: details,
      );
    }
  }

  Future<void> updateMachineStatus({
    required String status,
    String remark = "",
  }) async {
    final response = await NetworkRequester().post(
      api: () async => await updateMachineStatus(
        status: status,
        remark: remark,
      ),
      path: Urls.UPDATEMACHINESTATUS,
      data: {
        "machine_id": id,
        "status": status,
        "remarks": remark,
        "attachments": abandonedAttachment,
      },
    );
    String res = jsonEncode(response);
    if (jsonDecode(res)["success"] == true) {
      customToast(msg: "Machine Status Updated");
      await getMachineDetail(
        machineId: id ?? 0,
      );
      Get.back();
      abandonedAttachment = <String>[].obs;
      localImagePath = <String>[].obs;
      abondenedRemark.text = "";
      if (Get.isRegistered<TotalMachinesController>()) {
        Get.find<TotalMachinesController>().resetPagination();
        await Get.find<TotalMachinesController>().getMachineList(
          isLoader: true,
        );
      }
      if (Get.isRegistered<HomeController>()) {
        await Get.find<HomeController>().getHomeDetails(
          isLoader: false,
        );
      }
    }
  }

  final ImagePicker picker = ImagePicker();
  String imageBaseUrl = "data:image/png;base64,";
  RxList<String> abandonedAttachment = <String>[].obs;
  RxList<String> localImagePath = <String>[].obs;

  void selectAttachment({
    required RxList<String> base64Image,
    required RxList<String> localImagePath,
  }) async {
    final List<XFile> pickedImage =
        await picker.pickMultipleMedia(imageQuality: 20);
    if (pickedImage.isNotEmpty) {
      for (int i = 0; i < pickedImage.length; i++) {
        localImagePath.add(pickedImage[i].path);
        File file = File(pickedImage[i].path);
        Uint8List bytes = file.readAsBytesSync();
        abandonedAttachment.add("${imageBaseUrl}${base64Encode(bytes)}");
      }
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
    if (pickedImage != null) {
      localImagePath.add(pickedImage.path ?? "");
      File file = File(pickedImage.path ?? "");
      Uint8List bytes = file.readAsBytesSync();
      base64Image.add("${imageBaseUrl}${base64Encode(bytes)}");
    }
  }

  Future<void> deleteAttachment({
    required String id,
    required String endpoint,
    required num machineId,
  }) async {
    final response = await NetworkRequester().post(
      api: () async => await deleteAttachment(
        endpoint: endpoint,
        id: id,
        machineId: machineId,
      ),
      path: endpoint,
      data: {
        "id": id,
      },
    );
    String res = jsonEncode(response);
    if (jsonDecode(res)["success"] == true) {
      getMachineDetail(machineId: machineId);
      Get.back();
      customToast(msg: "Attachment deleted!");
    }
  }

  RxString machineBase64 = "".obs;
  RxString machineLocalFiles = "".obs;
  RxBool isMachineImageSelected = false.obs;
  void singlePhotoSelect(
    ImageSource source,
  ) async {
    final pickedImage = await picker.pickImage(
      source: source,
      imageQuality: 20,
    );
    log("Img :: ${pickedImage?.path.toString()}");
    File file = File(pickedImage?.path ?? "");
    Uint8List bytes = file.readAsBytesSync();
    machineBase64.value = imageBaseUrl + base64Encode(bytes);
    isMachineImageSelected.value = true;
    machineLocalFiles.value = pickedImage?.path ?? "";
  }

  Future<void> requestMachineCondemnation({
    required String machine_id,
    required String type,
    String request_by_remarks = "",
    String support_attachment = "",
  }) async {
    final response = await NetworkRequester().post(
      data: {
        "machine_id": machine_id,
        "user_id": Storage.getUserId(),
        "type": type,
        "request_by_remarks": request_by_remarks,
        "support_attachment": support_attachment,
      },
      api: () async => await requestMachineCondemnation(
        machine_id: machine_id,
        type: type,
        request_by_remarks: request_by_remarks,
        support_attachment: support_attachment,
      ),
      path: Urls.MACHINEDCREQUEST,
    );
    if (response != null) {
      String res = jsonEncode(response);
      if (jsonDecode(res)["success"] == true) {
        customToast(msg: 'Machine Condemnation Request Sent Successfully');
      }
      getMachineDetail(machineId: data?["machineId"] ?? 0);
      if (Get.isRegistered<TotalMachinesController>()) {
        TotalMachinesController controller =
            Get.find<TotalMachinesController>();
        controller.fetchTotalMachineCondemnRequests();
      }
    }
  }

  String capitalize(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1);
  }

  Rx<GetMaintenanceReport> report = GetMaintenanceReport().obs;

  Future<void> getMachineMaintenanceReport({
    bool isLoader = true,
    required int id,
  }) async {
    final controller = Get.find<MachineDetailsController>();

    String? startDate;
    if (controller.fromDay.value.isNotEmpty &&
        controller.fromMonth.value.isNotEmpty &&
        controller.fromYear.value.isNotEmpty) {
      startDate =
          "${controller.fromYear.value.padLeft(4, '0')}-${controller.fromMonth.value.padLeft(2, '0')}-${controller.fromDay.value.padLeft(2, '0')}";
    }

    String? endDate;
    if (controller.toDay.value.isNotEmpty &&
        controller.toMonth.value.isNotEmpty &&
        controller.toYear.value.isNotEmpty) {
      endDate =
          "${controller.toYear.value.padLeft(4, '0')}-${controller.toMonth.value.padLeft(2, '0')}-${controller.toDay.value.padLeft(2, '0')}";
    }

    final response = await NetworkRequester().get(
        isLoader: isLoader,
        api: () async => await getMachineMaintenanceReport(
              id: id,
            ),
        path: "${Urls.MACHINEMAINTENANCEREPORT}/${id}",
        query: {
          "start_date": startDate,
          "end_date": endDate,
          "is_detailed": isReportDetailed.value ? "detailed" : "simple",
          "report_type": selectedReportType.value.toLowerCase(),
        });

    if (response != null) {
      String res = jsonEncode(response);
      if (jsonDecode(res)["success"] == true) {
        report.value = getMaintenanceReportFromJson(jsonEncode(response));
        await downloadMachineMaintenanceReport(
          fileName:
              report.value.data?.maintenenceReportPdfDetails?.pdfName ?? "",
          base64String:
              report.value.data?.maintenenceReportPdfDetails?.pdfContent ?? "",
        );
      }
    }
  }

  Future<void> downloadMachineMaintenanceReport({
    required String base64String,
    required String fileName,
  }) async {
    List res = [];

    if (fileName.isNotEmpty) {
      res = fileName.split(".");
      log(res.toString());
      if (res.isNotEmpty) {
        fileName = res[0];
      }
    }

    PermissionStatus permission = PermissionStatus.granted;
    if (Platform.isAndroid) {
      DeviceInfoPlugin plugin = DeviceInfoPlugin();
      AndroidDeviceInfo android = await plugin.androidInfo;

      if (android.version.sdkInt < 33) {
        permission = await Permission.storage.request();
        if (permission != PermissionStatus.granted) {
          openAppSettings();
        }
      }

      if (permission != PermissionStatus.granted) {
        openAppSettings();
      } else {
        await download(
          fileName: fileName,
          mediaType: res[1],
          base64String: base64String,
        );
      }
    } else if (Platform.isIOS) {
      await download(
        fileName: fileName,
        mediaType: res[1],
        base64String: base64String,
      );
    }
  }

  Future<void> download({
    required String fileName,
    required String mediaType,
    required String base64String,
  }) async {
    try {
      Permission.storage.request();

      Directory tempDir;
      if (Platform.isIOS) {
        tempDir = await getApplicationDocumentsDirectory();
      } else {
        tempDir = Directory('/storage/emulated/0/Download');
      }

      String savePath = "${tempDir.path}/$fileName.$mediaType";

      for (int i = 0; i < 100; i++) {
        bool exists = await File(savePath).exists();
        if (exists) {
          savePath = "${tempDir.path}/$fileName(${i + 1}).$mediaType";
        } else {
          break;
        }
      }
      log("Save path: $savePath");
      loader();
      List<int> bytes = base64Decode(base64String);

      File file = File(savePath);
      await file.writeAsBytes(bytes);

      print('File saved to $savePath');
      Get.back();
      var res = await OpenFile.open(savePath);
      log(res.message);
    } catch (e) {
      print('Error saving file: $e');
    }
  }
}
