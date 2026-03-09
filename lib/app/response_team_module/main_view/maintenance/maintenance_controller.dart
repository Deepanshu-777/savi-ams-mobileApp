import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rail_weld/model/response_team_models/maintenance_list_model.dart';
import 'package:rail_weld/routes/urls.dart';
import 'package:rail_weld/service/network_requester.dart';
import 'package:rail_weld/widgets/custom_loader.dart';
import '../../../../model/response_team_models/maintenance_report.dart';

class MaintenanceController extends GetxController {
  Rx<MaintenanceListModel> maintenanceList = MaintenanceListModel().obs;
  Rx<GetMaintenanceReport> report = GetMaintenanceReport().obs;

  late TextEditingController searchByNameOrItemCode;
  RxBool isFilter = false.obs;

  Future<void> scheduledMaintenanceList({
    bool isLoader = true,
  }) async {
    final response = await NetworkRequester().get(
      isLoader: isLoader,
      api: () async => await scheduledMaintenanceList(),
      path: Urls.SCHEDULEDMAINTENANCELIST,
      query: isFilter.value ? {
         "search_by_item_code_name" : searchByNameOrItemCode.text.trim(),
      } : {},
    );
    if (response != null) {
      String res = jsonEncode(response);
      if (jsonDecode(res)["success"] == true) {
        maintenanceList.value =
            maintenanceListModelFromJson(jsonEncode(response));
      }
    }
  }

  Future<void> getMaintenanceReport({
    bool isLoader = true,
    required int id,
  }) async {
    final response = await NetworkRequester().get(
      isLoader: isLoader,
      api: () async => await getMaintenanceReport(
        id: id,
      ),
      path: "${Urls.MAINTENANCEREPORT}/${id}",
    );
    if (response != null) {
      String res = jsonEncode(response);
      if (jsonDecode(res)["success"] == true) {
        report.value = getMaintenanceReportFromJson(jsonEncode(response));
        await downloadMaintenanceReport(
          fileName:
              report.value.data?.maintenenceReportPdfDetails?.pdfName ?? "",
          base64String:
              report.value.data?.maintenenceReportPdfDetails?.pdfContent ?? "",
        );
      }
    }
  }

  Future<void> downloadMaintenanceReport({
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

  RxInt currentFilterIndex = 0.obs;

  void changeFilterIndex(int currentIndex) {
    currentFilterIndex.value = currentIndex;
  }

  @override
  void onInit() {
    super.onInit();
    scheduledMaintenanceList();
    searchByNameOrItemCode = TextEditingController();
  }


  String formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return '--';

    try {
      DateTime date = DateTime.parse(dateString);
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (e) {
      return '--';
    }
  }
}
