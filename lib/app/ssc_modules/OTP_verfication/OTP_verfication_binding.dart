import 'package:get/get.dart';
import 'package:rail_weld/app/ssc_modules/OTP_verfication/OTP_verfication_controller.dart';

class OTPVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OTPVerificationController>(
      () => OTPVerificationController(),
    );
  }
}
