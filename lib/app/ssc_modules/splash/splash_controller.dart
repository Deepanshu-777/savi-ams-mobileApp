import 'package:get/get.dart';
import 'package:rail_weld/service/app_update_service.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    AppUpdateService().checkIfUpdateAvailable();
  }
}
