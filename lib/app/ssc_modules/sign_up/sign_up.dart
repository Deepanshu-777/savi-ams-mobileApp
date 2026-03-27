import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rail_weld/app/ssc_modules/sign_up/sign_up_controller.dart';
import 'package:rail_weld/app/ssc_modules/sign_up/widget.dart';

import '../../../theme/app_colors.dart';
import '../../../widgets/custom_sized_box.dart';
import '../../../widgets/custom_text.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: const Padding(
          padding: EdgeInsets.only(top: 25),
          child: Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      bottomSheet: signUpBottomsheet(width: width),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customSizedBox(height: 30),
              largeText(
                title: "Sign Up",
                fontColor: AppColors.black,
              ),
              customSizedBox(height: 11),
              mediumText(
                title:
                    "Fill in the the details and get started with “SAVI AMS” Asset Management Tool",
                height: 1.5,
                fontColor: AppColors.black,
              )
            ],
          ),
        ),
      ),
    );
  }
}
