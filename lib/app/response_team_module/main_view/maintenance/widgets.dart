import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rail_weld/app/response_team_module/main_view/maintenance/maintenance_controller.dart';
import 'package:rail_weld/routes/app_pages.dart';
import '../../../../model/response_team_models/maintenance_list_model.dart';
import '../../../../routes/img_routes.dart';
import '../../../../theme/app_colors.dart';
import '../../../../widgets/custom_date_container.dart';
import '../../../../widgets/custom_elevated_button.dart';
import '../../../../widgets/custom_rich_text.dart';
import '../../../../widgets/custom_sized_box.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/filter_bar .dart';
import '../ticket_maintenance/widgets.dart';

List<Widget> maintenanceBody({
  double height = 20,
}) {
  MaintenanceController controller = Get.find<MaintenanceController>();
  return [
    maintenanceFilter(
      isFilter: true,
      isSort: false,
    ),
    customSizedBox(height: 10),
    Expanded(
      child: RefreshIndicator(
        onRefresh: () => controller.scheduledMaintenanceList(
          isLoader: false,
        ),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Obx(
            () {
              return controller.currentFilterIndex.value == 0
                  ? dueMaintenanceList(height: height)
                  : controller.currentFilterIndex.value == 1
                      ? upcomingMaintenanceList(height: height)
                      : controller.currentFilterIndex.value == 2
                          ? completeMaintenanceList(height: height)
                          : const SizedBox();
            },
          ),
        ),
      ),
    ),
  ];
}

Widget upcomingMaintenanceList({
  double height = 20,
}) {
  MaintenanceController controller = Get.find<MaintenanceController>();

  return Obx(
    () {
      List<UpcomingMaintenceList>? upcomingMaintenceList =
          controller.maintenanceList.value.data?.upcomingMaintenceList;
      return upcomingMaintenceList?.length == 0
          ? noRecord(height: height)
          : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: upcomingMaintenceList?.length ?? 0,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () => Get.toNamed(
                        Routes.MACHINEDETAILS,
                        arguments: {
                          "machineId": upcomingMaintenceList?[index].id ?? 0,
                          "buttonTitle": "Start Maintenance",
                          "navigation": "${Routes.BARCODESCANNER}",
                          "onBarCodeScan": "${Routes.REMARK}",
                          "maintenance_date": upcomingMaintenceList?[index]
                              .upcomingMaintenceDate,
                        },
                      ),
                      child: Column(
                        children: [
                          upcomingMaintenanceCard(
                            data: upcomingMaintenceList?[index] ??
                                UpcomingMaintenceList(),
                          ),
                        ],
                      ),
                    ),
                    customSizedBox(height: 17)
                  ],
                );
              },
            );
    },
  );
}

Widget completeMaintenanceList({
  double height = 20,
}) {
  MaintenanceController controller = Get.find<MaintenanceController>();

  return Obx(
    () {
      List<CompletedMaintenceList>? upcomingMaintenceList =
          controller.maintenanceList.value.data?.completedMaintenceList;
      return upcomingMaintenceList?.length == 0
          ? noRecord(height: height)
          : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: upcomingMaintenceList?.length ?? 0,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.getMaintenanceReport(
                          id: upcomingMaintenceList?[index].id ?? 0,
                        );
                      },
                      child: Column(
                        children: [
                          maintenanceDoneCard(
                            data: upcomingMaintenceList?[index] ??
                                CompletedMaintenceList(),
                          ),
                        ],
                      ),
                    ),
                    customSizedBox(height: 17)
                  ],
                );
              },
            );
    },
  );
}

Widget dueMaintenanceList({
  double height = 20,
}) {
  MaintenanceController controller = Get.find<MaintenanceController>();

  return Obx(
    () {
      List<DueMaintenanceList>? upcomingMaintenceList =
          controller.maintenanceList.value.data?.dueMaintenenceList;
      return upcomingMaintenceList?.length == 0
          ? noRecord(height: height)
          : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: upcomingMaintenceList?.length ?? 0,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () => Get.toNamed(
                        Routes.MACHINEDETAILS,
                        arguments: {
                          "buttonTitle": "Start Maintenance",
                          "navigation": "${Routes.BARCODESCANNER}",
                          "onBarCodeScan": "${Routes.REMARK}",
                          "machineId": upcomingMaintenceList?[index].id ?? 0,
                          "maintenance_date": upcomingMaintenceList?[index]
                              .upcomingMaintenceDate,
                        },
                      ),
                      child: Column(
                        children: [
                          dueMaintenanceCard(
                            data: upcomingMaintenceList?[index] ??
                                DueMaintenanceList(),
                          ),
                        ],
                      ),
                    ),
                    customSizedBox(height: 17)
                  ],
                );
              },
            );
    },
  );
}

Widget noRecord({
  double height = 20,
}) {
  return Center(
    child: Column(
      children: [
        customSizedBox(height: height * 0.14),
        SvgPicture.asset(ImgRoutes.MAINTENANCE),
        customSizedBox(height: 20),
        smallText(
          title: "No Record!",
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontColor: AppColors.navyBlue,
        )
      ],
    ),
  );
}

Widget maintenanceDoneCard({
  required CompletedMaintenceList data,
}) {
  return Container(
    padding: const EdgeInsets.only(
      bottom: 11,
      top: 11,
      left: 13,
      right: 13,
    ),
    decoration: BoxDecoration(
      border: Border.all(
        width: 0.5,
        color: AppColors.dGrey,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        customDateContainer(
          boxColor: AppColors.lightNavyBlue,
          dayNo: data.maintenenceDay ?? "",
          month: data.maintenenceMonth ?? "",
          year: data.maintenenceYear ?? "",
        ),
        customSizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // ticketStatus(
              //   currentStatus: "Maintenance Done",
              //   fontColor: AppColors.green,
              // ),
              //customSizedBox(height: 10),
              richText(
                title: "Local No. : ",
                subTitle: data.itemCode ?? "",
              ),
              customSizedBox(height: 5),
              richText(
                title: "Machine Name : ",
                subTitle: data.name.toString(),
              ),
              customSizedBox(height: 5),
              // richText(
              //   title: "Time : ",
              //   subTitle: data.time ?? "",
              // ),
            ],
          ),
        ),
        SvgPicture.asset(
          ImgRoutes.VIEWMORE,
        ),
      ],
    ),
  );
}

Widget upcomingMaintenanceCard({
  required UpcomingMaintenceList data,
}) {
  return Container(
    padding: const EdgeInsets.only(
      bottom: 11,
      top: 11,
      left: 13,
      right: 13,
    ),
    decoration: BoxDecoration(
      border: Border.all(
        width: 0.5,
        color: AppColors.dGrey,
      ),
      color: AppColors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        customDateContainer(
          boxColor: AppColors.lightNavyBlue,
          dayNo: data.upcomingMaintenenceDay ?? "",
          month: data.upcomingMaintenenceMonth ?? "",
          year: data.upcomingMaintenenceYear ?? "",
        ),
        customSizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // ticketStatus(
              //   currentStatus: "Upcoming",
              //   fontColor: AppColors.yellow,
              // ),
              // customSizedBox(height: 10),
              richText(
                title: "Local No. : ",
                subTitle: data.itemCode ?? "",
              ),
              customSizedBox(height: 5),
              richText(
                title: "Machine Name : ",
                subTitle: data.name ?? "",
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget dueMaintenanceCard({
  required DueMaintenanceList data,
}) {
  return Container(
    padding: const EdgeInsets.only(
      bottom: 11,
      top: 11,
      left: 13,
      right: 13,
    ),
    decoration: BoxDecoration(
      border: Border.all(
        width: 0.5,
        color: AppColors.dGrey,
      ),
      color: AppColors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        customDateContainer(
          boxColor: AppColors.lightNavyBlue,
          dayNo: data.upcomingMaintenenceDay ?? "",
          month: data.upcomingMaintenenceMonth ?? "",
          year: data.upcomingMaintenenceYear ?? "",
        ),
        customSizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // ticketStatus(
              //   currentStatus: "Pending",
              //   fontColor: AppColors.red,
              // ),
              // customSizedBox(height: 10),
              richText(
                title: "Local No. : ",
                subTitle: data.itemCode ?? "",
              ),
              customSizedBox(height: 5),
              richText(
                title: "Machine Name : ",
                subTitle: data.name ?? "",
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget maintenanceFilter({
  double width = 20,
  double height = 20,
  bool isFilter = true,
  bool isSort = true,
  void Function()? onAsc,
  void Function()? onDesc,
}) {
  MaintenanceController controller = Get.find<MaintenanceController>();
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.only(
          left: width * 0.055,
          right: width * 0.055,
        ),
        child: filterBar(
          isSort: isSort,
          title: "Scheduled Maintenance",
          isFilter: isFilter,
          onAsc: onAsc,
          onDesc: onDesc,
        ),
      ),
      customSizedBox(height: 10),
      SizedBox(
        height: 31,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(
            left: width * 0.055,
          ),
          shrinkWrap: true,
          children: [
            Obx(
              () => statusContainer(
                title: "Due Maintenance",
                controller: controller,
                hPadding: 31,
                index: 0,
                boxColor: controller.currentFilterIndex.value == 0
                    ? AppColors.navyBlue
                    : null,
              ),
            ),
            Obx(
              () => statusContainer(
                title: "Upcoming Maintenance",
                controller: controller,
                hPadding: 31,
                index: 1,
                boxColor: controller.currentFilterIndex.value == 1
                    ? AppColors.navyBlue
                    : null,
              ),
            ),
            Obx(
              () => statusContainer(
                title: "Completed Maintenance",
                controller: controller,
                hPadding: 31,
                index: 2,
                boxColor: controller.currentFilterIndex.value == 2
                    ? AppColors.navyBlue
                    : null,
              ),
            ),
          ],
        ),
      ),
      customSizedBox(height: 10),
    ],
  );
}

class FilterScreenMaintenance extends StatefulWidget {
  const FilterScreenMaintenance({super.key});

  @override
  _FilterScreenMaintenanceState createState() =>
      _FilterScreenMaintenanceState();
}

class _FilterScreenMaintenanceState extends State<FilterScreenMaintenance> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return GetBuilder<MaintenanceController>(
      init: MaintenanceController(),
      builder: (controller) => Container(
        padding: const EdgeInsets.only(
          top: 20,
          left: 24,
          right: 24,
        ),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  largeText(
                    title: "Filter",
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    fontColor: AppColors.black,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.all(18.0),
                      child: SvgPicture.asset(ImgRoutes.CROSS),
                    ),
                  ),
                ],
              ),
              customSizedBox(height: 20),
              mediumText(
                title: "Search By Name or Local No.",
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontColor: AppColors.black,
              ),
              customSizedBox(height: 13),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                height: _isFocused ? 200 : 50,
                child: TextFormField(
                  controller: controller.searchByNameOrItemCode,
                  focusNode: _focusNode,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    hintText: "Enter Name or Local No.",
                    filled: true,
                    fillColor: AppColors.whiteBg,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: AppColors.offWhite,
                        width: 1,
                      ),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  ),
                ),
              ),
              customSizedBox(height: 41),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customElevatedButton(
                    onPressed: () {
                      controller.isFilter.value = false;
                      controller.searchByNameOrItemCode.text = "";
                      controller.scheduledMaintenanceList();
                      Get.back();
                    },
                    title: "Reset",
                    bgColor: AppColors.offBlue,
                    fontColor: AppColors.navyBlue,
                    fontSize: 14,
                    padding: EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: width * 0.155,
                    ),
                    fontWeight: FontWeight.w400,
                  ),
                  customElevatedButton(
                    onPressed: () async {
                      Get.back();
                      // controller.resetPagination();
                      // await controller.getMachineList();
                      controller.isFilter.value = true;
                      controller.scheduledMaintenanceList();
                    },
                    title: "Search",
                    bgColor: AppColors.navyBlue,
                    fontColor: AppColors.white,
                    fontSize: 14,
                    padding: EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: width * 0.155,
                    ),
                    fontWeight: FontWeight.w400,
                  )
                ],
              ),
              customSizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
