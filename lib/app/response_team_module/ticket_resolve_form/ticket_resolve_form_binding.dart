import 'package:get/get.dart';
import 'package:rail_weld/app/response_team_module/ticket_resolve_form/ticket_resolve_form_controller.dart';

class TicketResolveFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TicketResolveFormController>(
      () => TicketResolveFormController(),
    );
  }
}
