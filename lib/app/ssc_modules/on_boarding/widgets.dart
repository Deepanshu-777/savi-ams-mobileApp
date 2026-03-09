import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/img_routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_sized_box.dart';
import '../../../widgets/custom_text.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Image.asset(
        ImgRoutes.LOGO,
        width: width,
        height: height * 0.4,
      ),
    );
  }
}

Widget welcomeBottomSheet({
  double width = 20,
}) {
  return Wrap(
    children: [
      Container(
        decoration: const BoxDecoration(
          color: AppColors.navyBlue,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 36,
          vertical: 35,
        ),
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            largeText(title: "Welcome"),
            customSizedBox(height: 15),
            mediumText(
              title:
                  "Keep track of every item effortlessly with our adaptable, asset management and tracking platform, designed to fit seamlessly into your workflow.",
              height: 1.5,
            ),
            customSizedBox(height: 58),
            SizedBox(
              width: double.infinity,
              child: customElevatedButton(
                onPressed: () => Get.toNamed(Routes.LOGIN),
                title: "Login",
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                ),
                fontColor: AppColors.white,
                bgColor: AppColors.lightBlue,
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     SizedBox(
            //       width: width * 0.35,
            //       child: customElevatedButton(
            //         onPressed: () => Get.toNamed(Routes.LOGIN),
            //         title: "Login",
            //         padding: const EdgeInsets.symmetric(
            //           vertical: 12,
            //         ),
            //         fontColor: AppColors.white,
            //         bgColor: AppColors.lightBlue,
            //       ),
            //     ),
            // SizedBox(
            //   width: width * 0.35,
            //   child: customElevatedButton(
            //     onPressed: () => Get.toNamed(Routes.SIGNUP),
            //     padding: const EdgeInsets.symmetric(
            //       vertical: 12,
            //     ),
            //     title: "Sign Up",
            //     fontColor: AppColors.navyBlue,
            //     bgColor: AppColors.white,
            //   ),
            //     // ),
            //   ],
            // )
          ],
        ),
      ),
    ],
  );
}
