import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rail_weld/data/strings.dart';
import 'package:rail_weld/widgets/custom_loader.dart';
import 'package:rail_weld/widgets/custom_toast.dart';

import '../routes/img_routes.dart';
import '../theme/app_colors.dart';
import 'custom_text.dart';

Future<dynamic> attachmentViewer({
  double width = 20,
  BoxFit? fit = BoxFit.cover,
  String imgPath = "",
}) {
  return showDialog(
    context: Get.context!,
    builder: (context) => AlertDialog(
      title: Row(
        children: [
          largeText(
            title: "Savi Assets",
            fontSize: 24,
            fontColor: AppColors.navyBlue,
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              downloadFile(
                fileUrl: imgPath,
                // onProgressUpdate: () {},
                // onDioException: () {},
              );
            },
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.only(
                left: 18.0,
                right: 7,
              ),
              child: SvgPicture.asset(
                ImgRoutes.DOWNLOAD,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.white,
      surfaceTintColor: AppColors.white,
      content: squareImg(
        width: width * 0.6,
        height: width * 0.75,
        imageUrl: imgPath,
        fit: fit,
      ),
    ),
  );
}

Widget squareImg({
  BoxFit? fit = BoxFit.cover,
  String? imageUrl,
  double height = 51.67,
  double width = 51.67,
  IconData placeHolder = Icons.person,
  Widget errorIcon = const Icon(
    Icons.person,
    color: AppColors.navyBlue,
  ),
}) {
  return Container(
    height: height,
    width: width,
    decoration: const BoxDecoration(
      color: AppColors.lightNavyBlue,
    ),
    child: CachedNetworkImage(
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.navyBlue),
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
          ),
          color: AppColors.white,
        ),
      ),
      fit: BoxFit.cover,
      imageUrl: imageUrl ?? "",
      errorWidget: (context, url, error) => errorIcon,
      placeholder: (context, url) => Center(
        child: CircularProgressIndicator(
          color: AppColors.navyBlue,
        ),
      ),
    ),
  );
}

void downloadFile({
  required String fileUrl,
}) async {
  PermissionStatus permission = PermissionStatus.granted;
  String fileName = "";
  List res = [];
  List fileNameList = fileUrl.split("/");

  if (fileNameList.isNotEmpty) {
    res = fileNameList[fileNameList.length - 1].split(".");
    log(res.toString());
    if (res.isNotEmpty) {
      fileName = res[0];
    }
  }

  if (Platform.isAndroid) {
    DeviceInfoPlugin plugin = DeviceInfoPlugin();
    AndroidDeviceInfo android = await plugin.androidInfo;

    if (android.version.sdkInt < 33) {
      permission = await Permission.storage.request();
      if (permission != PermissionStatus.granted) {
        openAppSettings();
      }
    }

    if (res[1] == "png" || res[1] == "jpg") {
      if (android.version.sdkInt >= 33) {
        // permission = await Permission.photos.request();
      }

      if (permission != PermissionStatus.granted) {
        openAppSettings();
      } else {
        await downloadMediaFromUrl(
          fileName: fileName,
          mediaType: res[1],
          url: fileUrl,
        );
      }
    } else {
      if (permission != PermissionStatus.granted) {
        openAppSettings();
      } else {
        await downloadMediaFromUrl(
          fileName: fileName,
          mediaType: res[1],
          url: fileUrl,
        );
      }
    }
  } else if (Platform.isIOS) {
    await downloadMediaFromUrl(
      fileName: fileName,
      mediaType: res[1],
      url: fileUrl,
    );
  }
}

Future<void> downloadMediaFromUrl({
  required String fileName,
  required String mediaType,
  required String url,
}) async {
  log(url);
  Permission.storage.request();
  final dio = Dio();
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
  loader(); // try {
  await dio.download(
    url,
    savePath,
    onReceiveProgress: (count, total) {
      log("$count / $total");
    },
  );
  Get.back();
  debugPrint("SAve path : $savePath $url");
  // var res = await OpenFile.open(savePath);
  // log(res.message);
  customToast(msg: Strings.DOWNLOADSUCCESS);
  Get.back();
  // } on DioException catch (e) {
  //   onDioException();
  //   ExceptionHandler.handleError(error: e);
  // }
}
