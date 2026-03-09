import 'package:get/get.dart';
import 'package:rail_weld/app/response_team_module/main_view/res_bar_code_scanner/res_bar_code_scanner_controller.dart';

class ResBarCodeScannerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResBarCodeScannerController>(
      () => ResBarCodeScannerController(),
    );
  }
}
