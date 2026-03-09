import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/decorated_box.dart';
import '../../../ssc_modules/main_view/home/widget.dart';
import 'maintenance_controller.dart';
import 'widgets.dart';

class MaintenanceView extends GetView<MaintenanceController> {
  const MaintenanceView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        FocusManager.instance.primaryFocus?.unfocus();
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              homeAppBar(),
              decoratedBox(
                width: width,
                padding: EdgeInsets.only(
                  top: 30,
                  left: width * 0.055,
                  right: width * 0.056,
                ),
                children: maintenanceBody(height: height),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
