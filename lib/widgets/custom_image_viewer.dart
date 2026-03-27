import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rail_weld/widgets/custom_sized_box.dart';
import 'package:rail_weld/widgets/decorated_box.dart';

import '../theme/app_colors.dart';
import 'custom_back_button.dart';
import 'custom_text.dart';

Widget customImageViewer({
  required String imgUrl,
  double width = 20,
}) {
  return Scaffold(
    body: SafeArea(
      child: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                right: 24,
                top: 35,
                bottom: 38,
              ),
              decoration: const BoxDecoration(
                color: AppColors.navyBlue,
              ),
              child: Row(
                children: [
                  customBackButton(color: AppColors.white),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      mediumText(
                        title: "SAVI AMS",
                        fontSize: 42,
                        fontFamily: "Bebas",
                        height: 0.7,
                      ),
                      smallText(
                        title: "Asset Management Tool",
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Blinker",
                      )
                    ],
                  ),
                ],
              ),
            ),
            decoratedBox(width: width ?? 20, children: [
              customSizedBox(
                height: 50,
              ),
              customNetworkImage(
                errorIcon: Icon(
                  Icons.person,
                  color: AppColors.white,
                  size: width * 0.3,
                ),
                fit: BoxFit.contain,
                size: 500,
                imageUrl: imgUrl,
              ),
            ])
          ],
        ),
      ),
    ),
  );
}

Widget customNetworkImage({
  BoxFit? fit = BoxFit.cover,
  String? imageUrl,
  double size = 51.67,
  BoxShape shape = BoxShape.circle,
  IconData placeHolder = Icons.person,
  Widget errorIcon = const Icon(
    Icons.person,
    color: AppColors.navyBlue,
  ),
}) {
  return Container(
    height: size,
    width: size,
    decoration: const BoxDecoration(
      color: AppColors.lightNavyBlue,
      shape: BoxShape.circle,
    ),
    child: CachedNetworkImage(
      imageBuilder: (context, imageProvider) => Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
          ),
          color: AppColors.white,
          shape: shape,
        ),
      ),
      fit: BoxFit.cover,
      imageUrl: imageUrl ?? "",
      errorWidget: (context, url, error) => errorIcon,
      placeholder: (context, url) => Center(
        child: CircularProgressIndicator(
          color: AppColors.navyBlue,
        ),
      ),
      // placeholder: (context, url) => Icon(
      //   placeHolder,
      //   size: 40,
      //   color: AppColors.navyBlue,
      // ),
    ),
  );
}
