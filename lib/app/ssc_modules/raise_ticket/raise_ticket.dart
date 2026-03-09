import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rail_weld/app/ssc_modules/raise_ticket/raise_ticket_controller.dart';
import 'package:rail_weld/app/ssc_modules/raise_ticket/widget.dart';
import 'package:rail_weld/data/strings.dart';
import 'package:rail_weld/theme/app_colors.dart';
import 'package:rail_weld/widgets/custom_toast.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_elevated_button.dart';

class RaiseTicketView extends GetView<RaiseTicketController> {
  const RaiseTicketView({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        color: AppColors.white,
        margin: EdgeInsets.only(
          left: width * 0.055,
          right: width * 0.055,
        ),
        width: double.infinity,
        child: customElevatedButton(
          bgColor: AppColors.navyBlue,
          padding: const EdgeInsets.symmetric(vertical: 17),
          onPressed: () async {
            FocusManager.instance.primaryFocus?.unfocus();
            if (controller.issueCodeTitle.isEmpty) {
              customToast(msg: Strings.ISSUECODEREQUIRED);
            } else if (controller.raiseTicketFormKey.currentState!.validate()) {
              controller.checkActiveTicket(context);
            }
          },
          title: "Submit",
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customAppBar(),
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
