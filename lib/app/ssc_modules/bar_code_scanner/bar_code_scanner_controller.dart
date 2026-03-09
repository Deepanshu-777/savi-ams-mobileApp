import 'dart:developer';

import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarCodeScannerController extends GetxController {
  final data = Get.arguments;
  MobileScannerController scannerController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    returnImage: true,
  );

  
}
