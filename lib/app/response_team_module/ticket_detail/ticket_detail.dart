import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rail_weld/app/response_team_module/ticket_detail/ticket_detail_controller.dart';
import 'package:rail_weld/app/response_team_module/ticket_detail/widgets.dart';
import 'package:rail_weld/model/scc_module_models/ticket_detail_model.dart';
import 'package:rail_weld/routes/img_routes.dart';
import 'package:rail_weld/theme/app_colors.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_elevated_button.dart';

class RTicketDetailView extends GetView<RTicketDetailController> {
  const RTicketDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Rx<TicketDetailModel>? ticketDetail =
        controller.detailController.ticketDetails;
    Ticketetail? ticket = ticketDetail.value.data?.ticketetail;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: (controller.isSsc && ticket?.status == "0")
          ? Container(
              color: AppColors.white,
              margin: EdgeInsets.only(
                left: width * 0.055,
                right: width * 0.055,
              ),
              width: double.infinity,
              child: customElevatedButton(
                bgColor: AppColors.navyBlue,
                padding: const EdgeInsets.symmetric(vertical: 17),
                onPressed: () {
                  cancelTicketPopup(
                    ticketId: ticket?.id.toString() ?? "",
                    height: height,
                    width: width,
                  );
                },
                title: "Cancel Ticket",
              ),
            )
          : (controller.isSsc && ticket?.status == "2")
              ? Container(
                  color: AppColors.white,
                  margin: EdgeInsets.only(
                    left: width * 0.055,
                    right: width * 0.055,
                  ),
                  width: double.infinity,
                  child: customElevatedButton(
                    bgColor: AppColors.navyBlue,
                    padding: const EdgeInsets.symmetric(vertical: 17),
                    onPressed: () {
                      verifyTicketPopup(
                        ticketId: ticket?.id.toString() ?? "",
                        height: height,
                        width: width,
                      );
                    },
                    title: "Ticket Verification",
                  ),
                )
              : (controller.isSsc &&
                      (ticket?.status == "3" || ticket?.status == "4"))
                  ? Container(
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
                          await controller.changeTicketStatus(
                            status: "5",
                            ticketId: ticket?.id.toString() ?? "",
                          );
                          Get.back();
                          Get.back();
                        },
                        title: "Re-Open Ticket",
                      ),
                    )
                  : controller.isSsc
                      ? const SizedBox()
                      : Obx(
                          () {
                            Ticketetail? ticket =
                                ticketDetail.value.data?.ticketetail;
                            return ticket?.status == "1"
                                ? swipeButton(
                                    width: width,
                                    title: "Swipe right to Mark Resolve",
                                    action: () async {
                                      ticketRessolvePopUp(
                                        height: height,
                                        ticketId: ticket?.id.toString() ?? "",
                                      );
                                      // await controller.changeTicketStatus(
                                      //   status: "2",
                                      //   ticketId: ticket?.id.toString() ?? "",
                                      //   remark: controller.resolvedRemark.value.text,
                                      // );
                                      return false;
                                    },
                                    bgColor: AppColors.lightGreen,
                                    color: AppColors.green,
                                    icon: ImgRoutes.RESOLVEDICON,
                                    height: height,
                                    ticketId: ticket?.id.toString() ?? "",
                                  )
                                : ticket?.status == "2"
                                    ? Container(
                                        color: AppColors.white,
                                        margin: EdgeInsets.only(
                                          left: width * 0.055,
                                          right: width * 0.055,
                                        ),
                                        width: double.infinity,
                                        child: customElevatedButton(
                                          bgColor: AppColors.navyBlue,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 17),
                                          onPressed: () {
                                            cancelTicketPopup(
                                              ticketId:
                                                  ticket?.id.toString() ?? "",
                                              height: height,
                                              width: width,
                                            );
                                          },
                                          title: "Cancel Ticket",
                                        ),
                                      )
                                    : Obx(
                                        () {
                                          Ticketetail? ticket = ticketDetail
                                              .value.data?.ticketetail;
                                          return (ticket?.status == "0" ||
                                                  ticket?.status == "5")
                                              ? swipeButton(
                                                  width: width,
                                                  height: height,
                                                  ticketId:
                                                      ticket?.id.toString() ??
                                                          "",
                                                  action: () async {
                                                    ticketAcknowledgedPopUp(
                                                      height: height,
                                                      ticketId: ticket?.id
                                                              .toString() ??
                                                          "",
                                                    );
                                                    return false;
                                                  },
                                                )
                                              : const SizedBox();
                                        },
                                      );
                          },
                        ),
      
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customAppBar(),
            Obx(
              () => bodyNew(
                width: width,
                padding: EdgeInsets.only(
                  top: 25,
                  left: width * 0.055,
                  right: width * 0.055,
                  bottom: ((ticketDetail.value.data?.ticketetail?.status ==
                                  "1" ||
                              ticketDetail.value.data?.ticketetail?.status ==
                                  "5" ||
                              ticketDetail.value.data?.ticketetail?.status ==
                                  "6") &&
                          controller.isSsc)
                      ? 20
                      : ((ticketDetail.value.data?.ticketetail?.status == "3" ||
                                  ticketDetail
                                          .value.data?.ticketetail?.status ==
                                      "4" ||
                                  ticketDetail
                                          .value.data?.ticketetail?.status ==
                                      "6") &&
                              controller.isSsc == false)
                          ? 0
                          : 90,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
