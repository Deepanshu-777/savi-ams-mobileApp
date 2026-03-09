import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rail_weld/app/response_team_module/main_view/ticket_maintenance/ticket_maintenance_controller.dart';
import 'package:rail_weld/app/ssc_modules/main_view/total_tickets/widget.dart';
import 'package:rail_weld/model/scc_module_models/tickets_list_model.dart';
import 'package:rail_weld/theme/app_colors.dart';
import 'package:rail_weld/widgets/custom_app_bar.dart';
import 'package:rail_weld/widgets/custom_sized_box.dart';
import 'package:rail_weld/widgets/decorated_box.dart';
import 'package:rail_weld/widgets/filter_bar%20.dart';
import '../../../../widgets/no_tickets.dart';

class TotalTicketsView extends GetView<TicketMaintenanceController> {
  const TotalTicketsView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customAppBar(isBackButton: false),
          decoratedBox(
            width: width,
            children: [
              customSizedBox(height: 30),
              Obx(
                () => ticketFilters(
                  isFilter: true,
                  isCount: true,
                  isRequestCard: true,
                  ticketRequestCount: controller.ticketRequestCount.value,
                  count:
                      (controller.ticketList.value.data?.ticketsList?.total ??
                              0)
                          .toString(),
                  onDesc: () {
                    controller.sortBy.value = "desc";
                    Get.back();
                    controller.resetPagination();
                    controller.getTicketList();
                    controller.fetchTicketRequests();
                  },
                  onAsc: () {
                    controller.sortBy.value = "asc";
                    Get.back();
                    controller.fetchTicketRequests();
                    controller.resetPagination();
                    controller.getTicketList();
                  },
                ),
              ),
              customSizedBox(height: 21),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    controller.fetchTicketRequests();
                    controller.resetPagination();
                    return await controller.getTicketList(
                      isLoader: true,
                    );
                  },
                  child: Obx(
                    () {
                      bool status = controller.isTicketsLoaded.value;
                      return status
                          ? Obx(
                              () {
                                RxList<Datum>? tickets =
                                    controller.selectedFilterTickets;
                                log("ABB: ${tickets?.length.toString()}");
                                return tickets?.length == 0
                                    ? noTickets(height: height)
                                    : ListView.builder(
                                        physics:
                                            AlwaysScrollableScrollPhysics(),
                                        controller: controller.scrollController,
                                        itemCount: tickets?.length ?? 0,
                                        itemBuilder: (context, index) {
                                          return ticketCard(
                                            ticketDetail:
                                                tickets?[index] ?? Datum(),
                                            bgColor: (index % 2 == 0)
                                                ? AppColors.white
                                                : AppColors.logCardColor,
                                            dateCardColor: index % 2 == 0
                                                ? AppColors.lGrey
                                                : AppColors.white,
                                            onTap: () {
                                              controller.getTicketDetails(
                                                isSsc: true,
                                                ticketId: tickets?[index]
                                                    .id
                                                    .toString(),
                                              );
                                            },
                                          );
                                        },
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
    );
  }
}
