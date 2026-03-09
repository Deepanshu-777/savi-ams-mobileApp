import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ResBarCodeScannerController extends GetxController {
  Map<String, String?>? data = Get.arguments;
  MobileScannerController scannerController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    returnImage: true,
  );
}
