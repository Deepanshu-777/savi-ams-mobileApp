import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rail_weld/app/ssc_modules/main_view/total_machines/filter_screen.dart';
import 'package:rail_weld/app/ssc_modules/main_view/total_machines/sort_screen.dart';
import 'package:rail_weld/app/ssc_modules/main_view/total_machines/widget.dart';
import 'package:rail_weld/model/scc_module_models/machine_list_model.dart';
import 'package:rail_weld/routes/app_pages.dart';
import 'package:rail_weld/widgets/custom_app_bar.dart';
import 'package:rail_weld/widgets/custom_sized_box.dart';
import 'package:rail_weld/widgets/custom_text.dart';
import 'package:rail_weld/widgets/decorated_box.dart';

import '../../../../routes/img_routes.dart';
import '../../../../theme/app_colors.dart';
import 'total_machines_controller.dart';

class TotalMachinesView extends GetView<TotalMachinesController> {
  const TotalMachinesView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customAppBar(isBackButton: false),
            decoratedBox(
              width: width,
              children: [
                customSizedBox(height: 30),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    largeText(
                      title: "Total Machines : ",
                      fontSize: 20,
                      fontColor: AppColors.black,
                    ),
                    customSizedBox(width: 5),
                    Obx(
                      () {
                        num? machineCount = controller
                            .machineList.value.data?.machinesList?.total;
                        return largeText(
                          title: "${(machineCount ?? 0).toString()}",
                          fontSize: 16,
                          fontColor: AppColors.black,
                          decoration: TextDecoration.underline,
                        );
                      },
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.ADDMACHINE);
                      },
                      child: Image.asset(
                        "assets/images/png_img/Group 1000003588.png",
                        height: 35,
                        width: 35,
                      ),
                    ),
                    customSizedBox(width: 12),
                    GestureDetector(
                      onTap: () => showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => SortBottomSheet(
                          sortByTitle: true,
                          onDesc: () {
                            controller.sortBy.value = "desc";
                            controller.resetPagination();
                            Get.back();
                            controller.getMachineList();
                          },
                          onAsc: () {
                            controller.sortBy.value = "asc";
                            controller.resetPagination();
                            Get.back();
                            controller.getMachineList();
                          },
                        ),
                      ),
                      child: SvgPicture.asset(
                        ImgRoutes.SORT,
                        height: 35,
                        width: 35,
                      ),
                    ),
                    customSizedBox(width: 12),
                  ],
                ),
                customSizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () => showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) => const FilterScreen(),
                            ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              ImgRoutes.FILTER,
                              height: 35,
                              width: 35,
                            ),
                          ],
                        )),
                    const Spacer(),
                    Obx(() {
                      return condemnRequestCard(
                        title: "Condemn Requests",
                        count: controller.totalCondemnRequests.value,
                        onTap: () {
                          Get.toNamed(
                            Routes.MACHINECONDEMNREQUEST,
                          );
                        },
                      );
                    })
                  ],
                ),
                customSizedBox(height: 15),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () {
                      controller.resetPagination();
                      controller.fetchTotalMachineCondemnRequests();
                      controller.getShopList();
                      return controller.getMachineList();
                    },
                    child: Obx(
                      () {
                        bool status = controller.isMachineLoaded.value;
                        return status
                            ? Obx(
                                () {
                                  RxList<Data?>? machine = controller.machines;
                                  log("ABB: ${machine?.length.toString()}");
                                  return machine?.length == 0
                                      ? noRecord(
                                          height: height,
                                          width: width,
                                        )
                                      : ListView.builder(
                                          controller:
                                              controller.scrollController,
                                          itemCount: machine?.length ?? 0,
                                          itemBuilder: (context, index) =>
                                              machineCard(
                                            machineDetail:
                                                machine?[index] ?? Data(),
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
