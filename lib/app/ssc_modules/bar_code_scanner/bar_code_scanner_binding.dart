import 'package:get/get.dart';
import 'package:rail_weld/app/ssc_modules/bar_code_scanner/bar_code_scanner_controller.dart';

class BarCodeScannerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BarCodeScannerController>(
      () => BarCodeScannerController(),
    );
  }
}
