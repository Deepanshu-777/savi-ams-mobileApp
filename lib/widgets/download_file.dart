import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'custom_loader.dart';

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
