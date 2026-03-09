import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../routes/img_routes.dart';
import '../theme/app_colors.dart';
import 'custom_sized_box.dart';
import 'custom_text.dart';

Widget noTickets({
  double height = 20,
}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        customSizedBox(height: height * 0.14),
        SvgPicture.asset(
          ImgRoutes.ZEROTICKETS,
        ),
        customSizedBox(height: 20),
        smallText(
          title: "No Ticket!",
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontColor: AppColors.navyBlue,
        )
      ],
    ),
  );
}
