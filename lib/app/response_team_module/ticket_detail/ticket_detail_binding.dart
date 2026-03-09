import 'package:get/get.dart';

import 'ticket_detail_controller.dart';

class RTicketDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RTicketDetailController>(
      () => RTicketDetailController(),
    );
  }
}
