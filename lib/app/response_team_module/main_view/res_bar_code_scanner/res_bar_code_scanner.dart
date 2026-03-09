import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:rail_weld/app/response_team_module/res_machine_details/res_machine_details_controller.dart';
import 'package:rail_weld/routes/app_pages.dart';
import 'package:rail_weld/routes/img_routes.dart';
import 'package:rail_weld/theme/app_colors.dart';
import 'package:rail_weld/widgets/custom_back_button.dart';
import 'package:rail_weld/widgets/custom_sized_box.dart';
import 'package:rail_weld/widgets/custom_text.dart';
import 'package:rail_weld/widgets/custom_toast.dart';
import 'package:scanning_effect/scanning_effect.dart';
import 'res_bar_code_scanner_controller.dart';

class ResBarCodeScannerView extends GetView<ResBarCodeScannerController> {
  const ResBarCodeScannerView({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                customSizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    customBackButton(
                      color: AppColors.white,
                      padding: const EdgeInsets.only(
                        right: 25,
                      ),
                    ),
                    customSizedBox(width: width * 0.1),
                    Column(
                      children: [
                        SvgPicture.asset(ImgRoutes.APPICON),
                        customSizedBox(height: 4),
                        largeText(
                          title: "Barcode Scanner",
                        ),
                      ],
                    )
                  ],
                ),
                customSizedBox(height: height * 0.06),
                Container(
                  padding: EdgeInsets.all(
                    width * 0.06,
                  ),
                  height: height * 0.5,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ScanningEffect(
                    scanningHeightOffset: 0.1,
                    scanningLinePadding: const EdgeInsets.all(0),
                    scanningColor: AppColors.navyBlue,
                    borderLineColor: AppColors.navyBlue,
                    delay: const Duration(seconds: 0),
                    duration: const Duration(seconds: 2),
                    child: Container(
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: AppColors.dGrey.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: MobileScanner(
                        // overlay: ScanningEffect(
                        //   scanningHeightOffset: 1,
                        //   scanningLinePadding: EdgeInsets.all(0),
                        //   scanningColor: AppColors.navyBlue,
                        //   borderLineColor: AppColors.navyBlue,
                        //   delay: Duration(seconds: 0),
                        //   duration: Duration(seconds: 2),
                        //   child: Container(
                        //     child: SizedBox(),
                        //   ),
                        // ),
                        controller: controller.scannerController,
                        onDetect: (captures) {
                          final List<Barcode> barcodes = captures.barcodes;
                          final Uint8List? image = captures.image;
                          String barCodeUrl = barcodes.first.rawValue ?? "";

                          Uri uri = Uri.parse(barCodeUrl);
                          num? machineId = int.parse(
                              uri.queryParameters['machine_id'] ?? "0");

                          for (var codes in barcodes) {
                            log("Barcode found! ${codes.rawValue}");
                          }
                          if (image != null) {
                            controller.data?["after_barcode"] != null
                                ? {
                                    log("${controller.data?["machine_id"]}  ${machineId}"),
                                    controller.data?["machine_id"] ==
                                            machineId.toString()
                                        ? {
                                            Get.offNamed(
                                              Routes.REMARK,
                                              arguments: controller
                                                  .data?["machine_id"],
                                            ),
                                          }
                                        : {
                                            Get.back(),
                                            customToast(
                                                msg: "QR Code Doesn't Match")
                                          }
                                  }
                                : (machineId.toString() != "")
                                    ? {
                                        Get.toNamed(
                                          Routes.RESMACHINEDETAILS,
                                          arguments: {"machineId": machineId},
                                        )
                                      }
                                    : showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            backgroundColor: AppColors.navyBlue,
                                            title: smallText(
                                              title:
                                                  " ${barcodes.first.rawValue.toString()}",
                                            ),
                                            content: Image(
                                              image: MemoryImage(image),
                                            ),
                                          );
                                        },
                                      );
                          }
                        },
                      ),
                    ),
                  ),
                ),
                customSizedBox(height: height * 0.06),
                mediumText(
                  title: "Align Barcode Within\nFrame to Scan",
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500,
                  fontSize: 28,
                  height: 1.2,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
