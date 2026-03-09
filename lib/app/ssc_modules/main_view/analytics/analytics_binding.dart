import 'package:get/get.dart';
import 'package:rail_weld/app/ssc_modules/main_view/analytics/analytics_controller.dart';

class AnalyticsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnalyticsController>(
      () => AnalyticsController(),
    );
  }
}
