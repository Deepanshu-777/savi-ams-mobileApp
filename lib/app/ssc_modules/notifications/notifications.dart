import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rail_weld/app/ssc_modules/notifications/notifications_controller.dart';
import 'package:rail_weld/app/ssc_modules/notifications/widgets.dart';
import '../../../widgets/custom_app_bar.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customAppBar(),
            notificationContainer(
              context,
            )
          ],
        ),
      ),
    );
  }
}
