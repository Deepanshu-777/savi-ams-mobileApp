import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rail_weld/app/response_team_module/main_view/ticket_maintenance/ticket_maintenance_controller.dart';
import 'package:rail_weld/app/ssc_modules/main_view/home/widget.dart';
import 'package:rail_weld/model/scc_module_models/ssc_home_model.dart';
import 'package:rail_weld/theme/app_colors.dart';
import 'package:rail_weld/widgets/custom_sized_box.dart';
import '../../../../routes/img_routes.dart';
import '../main_view_controller.dart';
import '../total_machines/total_machines_controller.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Column(
      children: [
        homeAppBar(),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(
              top: 5,
              left: width * 0.055,
              right: width * 0.055,
            ),
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: RefreshIndicator(
              onRefresh: () => controller.getHomeDetails(
                isLoader: false,
              ),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(children: [
                  customSizedBox(height: 30),
                  Obx(() {
                    Machines? machines = controller.detail?.value.machines;
                    return cardSet(
                      isCalender: false,
                      width: width,
                      mainTitle: "Machines",
                      icon1: ImgRoutes.TOTALMACHINES,
                      title1: "Total",
                      subTitle1: "Machines",
                      onTap1: () async {
                        if (Get.isRegistered<TotalMachinesController>()) {
                          TotalMachinesController machinesController =
                              Get.find<TotalMachinesController>();
                          machinesController.resetFilter();
                          machinesController.resetPagination();
                          await machinesController.getMachineList(
                            isReset: true,
                          );
                        }
                        if (Get.isRegistered<MainViewController>()) {
                          MainViewController mainViewController =
                              Get.find<MainViewController>();
                          mainViewController.selectedTabIndex.value = 1;
                        }
                      },
                      icon2: ImgRoutes.ACTIVEMACHINES,
                      title2: "Working",
                      subTitle2: "Machines",
                      onTap2: () async {
                        if (Get.isRegistered<TotalMachinesController>()) {
                          TotalMachinesController machinesController =
                              Get.find<TotalMachinesController>();
                          machinesController.resetFilter();
                          machinesController.changeCurrentConditionIndex(0);
                          machinesController.changeCurrentMachineStatusIndex(0);
                          machinesController.resetPagination();
                          await machinesController.getMachineList();
                        }
                        if (Get.isRegistered<MainViewController>()) {
                          MainViewController mainViewController =
                              Get.find<MainViewController>();
                          mainViewController.selectedTabIndex.value = 1;
                        }
                      },
                      icon3: ImgRoutes.INACTIVEMACHINES,
                      title3: "Out of Order",
                      subTitle3: "Machines",
                      onTap3: () async {
                        if (Get.isRegistered<TotalMachinesController>()) {
                          TotalMachinesController machinesController =
                              Get.find<TotalMachinesController>();
                          machinesController.resetFilter();
                          machinesController.changeCurrentConditionIndex(0);
                          machinesController.changeCurrentMachineStatusIndex(1);
                          machinesController.resetPagination();
                          await machinesController.getMachineList();
                        }
                        if (Get.isRegistered<MainViewController>()) {
                          MainViewController mainViewController =
                              Get.find<MainViewController>();
                          mainViewController.selectedTabIndex.value = 1;
                        }
                      },
                      icon4: ImgRoutes.ABANDONEDMACHINES,
                      title4: "Condemned",
                      subTitle4: "Machines",
                      onTap4: () async {
                        if (Get.isRegistered<TotalMachinesController>()) {
                          TotalMachinesController machinesController =
                              Get.find<TotalMachinesController>();
                          machinesController.resetFilter();
                          machinesController.changeCurrentConditionIndex(2);
                          machinesController.resetPagination();
                          await machinesController.getMachineList();
                        }
                        if (Get.isRegistered<MainViewController>()) {
                          MainViewController mainViewController =
                              Get.find<MainViewController>();
                          mainViewController.selectedTabIndex.value = 1;
                        }
                      },
                      count1: machines?.totalMachineCount.toString() ?? "",
                      count2: machines?.activeMachineCount.toString() ?? "",
                      count3: machines?.inActiveMachineCount.toString() ?? "",
                      count4: machines?.abandonedMachineCount.toString() ?? "",
                    );
                  }),
                  customSizedBox(height: height * 0.06),
                  Obx(
                    () {
                      Tickets? tickets = controller.detail?.value.tickets;
                      return cardSet(
                        width: width,
                        isNext: true,
                        mainTitle: "Tickets",
                        totalCount:
                            "( ${(tickets?.allTickets ?? "").toString()} )",
                        icon1: ImgRoutes.TICKETRAISED,
                        title1: "Ticket",
                        subTitle1: "Raised",
                        onTap1: () async {
                          if (Get.isRegistered<TicketMaintenanceController>()) {
                            TicketMaintenanceController ticketController =
                                Get.find<TicketMaintenanceController>();
                            ticketController.changeFilterIndex(0);
                          }
                          if (Get.isRegistered<MainViewController>()) {
                            MainViewController mainViewController =
                                Get.find<MainViewController>();
                            mainViewController.selectedTabIndex.value = 3;
                          }
                        },
                        icon2: ImgRoutes.TICKETRESOLVED,
                        title2: "Ticket",
                        subTitle2: "Resolved",
                        onTap2: () async {
                          if (Get.isRegistered<TicketMaintenanceController>()) {
                            TicketMaintenanceController ticketController =
                                Get.find<TicketMaintenanceController>();
                            ticketController.changeFilterIndex(2);
                          }
                          if (Get.isRegistered<MainViewController>()) {
                            MainViewController mainViewController =
                                Get.find<MainViewController>();
                            mainViewController.selectedTabIndex.value = 3;
                          }
                        },
                        icon3: ImgRoutes.TICKETPENDING,
                        title3: "Ticket",
                        subTitle3: "Acknowledged",
                        onTap3: () async {
                          if (Get.isRegistered<TicketMaintenanceController>()) {
                            TicketMaintenanceController ticketController =
                                Get.find<TicketMaintenanceController>();
                            ticketController.changeFilterIndex(1);
                          }
                          if (Get.isRegistered<MainViewController>()) {
                            MainViewController mainViewController =
                                Get.find<MainViewController>();
                            mainViewController.selectedTabIndex.value = 3;
                          }
                        },
                        icon4: ImgRoutes.TICKETABANDONED,
                        title4: "Ticket",
                        subTitle4: "Cancelled",
                        onTap4: () async {
                          if (Get.isRegistered<TicketMaintenanceController>()) {
                            TicketMaintenanceController ticketController =
                                Get.find<TicketMaintenanceController>();
                            ticketController.changeFilterIndex(6);
                          }
                          if (Get.isRegistered<MainViewController>()) {
                            MainViewController mainViewController =
                                Get.find<MainViewController>();
                            mainViewController.selectedTabIndex.value = 3;
                          }
                        },
                        icon5: ImgRoutes.TICKETAPPROVED,
                        title5: "Ticket",
                        subTitle5: "Approved",
                        onTap5: () async {
                          if (Get.isRegistered<TicketMaintenanceController>()) {
                            TicketMaintenanceController ticketController =
                                Get.find<TicketMaintenanceController>();
                            ticketController.changeFilterIndex(3);
                          }
                          if (Get.isRegistered<MainViewController>()) {
                            MainViewController mainViewController =
                                Get.find<MainViewController>();
                            mainViewController.selectedTabIndex.value = 3;
                          }
                        },
                        count1: tickets?.totalTicketData.toString() ?? "",
                        count2: tickets?.resolvedTicketData.toString() ?? "",
                        count3: tickets?.pendingTicketData.toString() ?? "",
                        count4: tickets?.abondonedTicketData.toString() ?? "",
                        count5: (tickets?.ticketsApproved ?? 0).toString(),
                      );
                    },
                  ),
                  customSizedBox(height: 30),
                ]),
              ),
            ),
          ),
        )
      ],
    ));
  }
}
