import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rail_weld/app/ssc_modules/notifications/notifications_controller.dart';
import 'package:rail_weld/theme/app_colors.dart';
import 'package:rail_weld/widgets/custom_sized_box.dart';
import 'package:rail_weld/widgets/custom_text.dart';

Widget notificationContainer(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  NotificationsController controller = Get.find<NotificationsController>();
  return Expanded(
    child: Container(
      padding: EdgeInsets.only(
        top: 10,
        left: width * 0.055,
        right: width * 0.055,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: Obx(
        () =>
            controller.notificationsList.value.data?.notifications?.length == 0
                ? SizedBox(
                    child: Center(
                      child: smallText(
                        title: "No Notifications!",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontColor: AppColors.black,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.only(top: 15),
                    itemCount: controller.notificationsList.value.data
                            ?.notifications?.length ??
                        0,
                    itemBuilder: (context, index) {
                      final notificationData = controller
                          .notificationsList.value.data?.notifications?[index];
                      return notificationCard(
                        image: notificationData?.hasImage ?? "",
                        title: notificationData?.title ?? "No Title",
                        description: notificationData?.msgBody ?? "No Body",
                        time: notificationData?.createdAt != null
                            ? DateFormat('dd-MM-yyyy')
                                .format(
                                  notificationData?.createdAt ?? DateTime.now(),
                                )
                                .toString()
                            : "",
                      );
                    },
                  ),
      ),
    ),
  );
}

Widget notificationCard({
  required String title,
  required String description,
  required String time,
  required String image,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 0),
    child: Column(
      children: [
        customSizedBox(height: 15),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            circularImageContainer(imageUrl: image),
            customSizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: largeText(
                          title: title,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontColor: AppColors.navyBlue,
                        ),
                      ),
                      smallText(
                        title: time,
                        fontSize: 9,
                        fontWeight: FontWeight.w400,
                        fontColor: AppColors.greyE,
                      ),
                    ],
                  ),
                  customSizedBox(height: 5),
                  mediumText(
                    title: description,
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    fontColor: AppColors.greyE,
                    height: 1.5,
                  ),
                ],
              ),
            )
          ],
        ),
        customSizedBox(height: 15),
        Divider(color: AppColors.lightOffWhite),
      ],
    ),
  );
}

Widget circularImageContainer({
  required String imageUrl,
  double size = 40,
}) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: AppColors.grey,
      image: DecorationImage(
        image: NetworkImage(
          imageUrl,
        ),
      ),
    ),
  );
}
