import 'dart:convert';

import 'package:get/get.dart';
import 'package:rail_weld/model/scc_module_models/get_notification_list.dart';

import '../../../routes/urls.dart';
import '../../../service/network_requester.dart';

class NotificationsController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getNotificationsList();
  }

  Rx<GetNotificationsList> notificationsList = GetNotificationsList().obs;
  Future<void> getNotificationsList() async {
    final response = await NetworkRequester().get(
      path: Urls.NOTIFICATIONSLIST,
      api: () async => await getNotificationsList(),
    );
    print(response);
    if (response != null) {
      notificationsList.value = getNotificationsListFromJson(
        jsonEncode(response),
      );
    } else {
      Get.back();
    }
  }
}
