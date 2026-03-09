import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rail_weld/app/ssc_modules/ticket_raised/ticket_raised_controller.dart';
import 'package:rail_weld/app/ssc_modules/ticket_raised/widget.dart';
import 'package:rail_weld/routes/app_pages.dart';
import 'package:rail_weld/storage/storage.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../theme/app_colors.dart';

class TicketRaisedView extends GetView<TicketRaisedController> {
  const TicketRaisedView({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        final role = Storage.getRole();
        if (role == "3" || role == "1") {
          Get.offAllNamed(Routes.MAINVIEW);
        } else {
          Get.offAllNamed(Routes.RESPONSEMAINVIEW);
        }
        return false;
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          margin: EdgeInsets.symmetric(
            horizontal: width * 0.055,
          ),
          width: double.infinity,
          child: customElevatedButton(
            bgColor: AppColors.navyBlue,
            padding: const EdgeInsets.symmetric(vertical: 17),
            onPressed: () {
              // Get.to(webView());
              controller.getTicketReport();
            },
            title: "Download",
          ),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customAppBar(
                onBackPressed: () {
                  final role = Storage.getRole();
                  if (role == "3" || role == "1") {
                    Get.offAllNamed(Routes.MAINVIEW);
                  } else {
                    Get.offAllNamed(Routes.RESPONSEMAINVIEW);
                  }
                },
              ),
              body(
                height: height,
                width: width,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
