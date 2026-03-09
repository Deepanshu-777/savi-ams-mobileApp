
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rail_weld/app/ssc_modules/main_view/ticket_request/ticket_request_controller.dart';
import 'package:rail_weld/app/ssc_modules/main_view/ticket_request/widget.dart';
import 'package:rail_weld/model/scc_module_models/ticket_request_model.dart';
import 'package:rail_weld/widgets/custom_app_bar.dart';
import 'package:rail_weld/widgets/custom_sized_box.dart';
import 'package:rail_weld/widgets/custom_text.dart';
import 'package:rail_weld/widgets/decorated_box.dart';

import '../../../../theme/app_colors.dart';

class TicketRequestView extends GetView<TicketRequestController> {
  const TicketRequestView({super.key});

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
                    Obx(() {
                      return largeText(
                        title:
                            "Total Requests : ${controller.totalRequests.value}",
                        fontSize: 20,
                        fontColor: AppColors.black,
                      );
                    }),
                    customSizedBox(width: 5),
                    customSizedBox(width: 12),
                  ],
                ),
                customSizedBox(height: 21),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () {
                      controller.resetPagination();
                      return controller.fetchTicketRequests();
                    },
                    child: Obx(
                      () {
                        bool status = controller.isTicketsLoaded.value;
                        return status
                            ? Obx(
                                () {
                                  RxList<Datum?>? ticketRequest =
                                      controller.ticketRequests;
                                  return ticketRequest.length == 0
                                      ? noRecord(
                                          height: height,
                                          width: width,
                                        )
                                      : ListView.builder(
                                          controller:
                                              controller.scrollController,
                                          itemCount: ticketRequest.length ?? 0,
                                          itemBuilder: (context, index) =>
                                              ticketRequestCard(
                                            context: context,
                                            ticketDetail:
                                                ticketRequest[index] ?? Datum(),
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
