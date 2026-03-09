import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rail_weld/app/ssc_modules/main_view/analytics/widget.dart';
import 'package:rail_weld/app/ssc_modules/main_view/home/widget.dart';
import 'analytics_controller.dart';

class AnalyticsView extends GetView<AnalyticsController> {
  const AnalyticsView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            homeAppBar(),
            body(
              height: height,
              width: width,
            ),
          ],
        ),
      ),
    );
  }
}
