import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rail_weld/app/response_team_module/maintenance_detail/maintenance_detail_controller.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/decorated_box.dart';
import 'widgets.dart';

class MaintenanceDetailView extends GetView<MaintenanceDetailController> {
  const MaintenanceDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customAppBar(),
            decoratedBox(
              width: width,
              children: body(height: height),
            ),
          ],
        ),
      ),
    );
  }
}
