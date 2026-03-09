import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rail_weld/app/response_team_module/res_machine_details/res_machine_details_controller.dart';
import 'package:rail_weld/app/response_team_module/res_machine_details/widget.dart';
import 'package:rail_weld/routes/app_pages.dart';
import 'package:rail_weld/theme/app_colors.dart';
import 'package:rail_weld/widgets/custom_app_bar.dart';
import 'package:rail_weld/widgets/custom_elevated_button.dart';
import 'package:rail_weld/widgets/decorated_box.dart';

class ResMachineDetailsView extends GetView<ResMachineDetailsController> {
  const ResMachineDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        controller.abandonedAttachment = <String>[].obs;
        controller.localImagePath = <String>[].obs;
        controller.abondenedRemark.text = "";
        return true;
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
              controller.data?["navigation"] != null
                  ? Get.offNamed(
                      controller.data?["navigation"] ?? "",
                      arguments: {
                        "after_barcode": "${Routes.REMARK}",
                        "machine_id": controller.data?["machineId"],
                        "maintenance_date":
                            controller.data?["maintenance_date"],
                      },
                    )
                  : Get.toNamed(
                      Routes.RAISETICKET,
                      arguments:
                          controller.machineDetail.value.data?.machineDetails,
                    );
            },
            title: controller.data?["buttonTitle"] ?? "Raise Ticket",
          ),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customAppBar(),
              decoratedBox(
                padding: const EdgeInsets.only(bottom: 10),
                width: width,
                children: body(
                  height: height,
                  width: width,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
