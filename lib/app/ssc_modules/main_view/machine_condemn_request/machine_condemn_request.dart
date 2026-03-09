
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rail_weld/app/ssc_modules/main_view/machine_condemn_request/machine_condemn_request_controller.dart';
import 'package:rail_weld/app/ssc_modules/main_view/machine_condemn_request/widget.dart';
import 'package:rail_weld/widgets/custom_app_bar.dart';
import 'package:rail_weld/widgets/custom_sized_box.dart';
import 'package:rail_weld/widgets/custom_text.dart';
import 'package:rail_weld/model/scc_module_models/machine_condemn_request_list_model.dart';
import 'package:rail_weld/widgets/decorated_box.dart';

import '../../../../theme/app_colors.dart';

class MachineCondemnRequestView
    extends GetView<MachineCondemnRequestController> {
  const MachineCondemnRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customAppBar(),
            decoratedBox(
              width: width,
              children: [
                customSizedBox(height: 30),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(
                      () {
                        return largeText(
                          title:
                              "Machine Condemn Requests : ${controller.totalRequests.value}",
                          fontSize: 20,
                          fontColor: AppColors.black,
                        );
                      },
                    ),
                    customSizedBox(width: 5),
                    customSizedBox(width: 12),
                  ],
                ),
                customSizedBox(height: 21),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () {
                      controller.resetPagination();
                      return controller.fetchMachineCondemnRequests();
                    },
                    child: Obx(
                      () {
                        bool status = controller.isRequestLoaded.value;
                        return status
                            ? Obx(
                                () {
                                  RxList<Datum?>? machineCondemnRequest =
                                      controller.machineCondemnRequests
                                          as RxList<Datum?>?;
                                  return machineCondemnRequest?.length == 0
                                      ? noRecord(
                                          height: height,
                                          width: width,
                                        )
                                      : ListView.builder(
                                          controller:
                                              controller.scrollController,
                                          itemCount:
                                              machineCondemnRequest?.length ??
                                                  0,
                                          itemBuilder: (context, index) =>
                                              machineCodemnRequestCard(
                                            context: context,
                                            requestDetail:
                                                machineCondemnRequest?[index] ??
                                                    Datum(),
                                          ),
                                        );
                                },
                              )
                            : const SizedBox();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
