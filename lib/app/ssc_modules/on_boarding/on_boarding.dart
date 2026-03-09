import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rail_weld/app/ssc_modules/on_boarding/widgets.dart';
import 'package:rail_weld/theme/app_colors.dart';

import 'on_boarding_controller.dart';

class OnBoardingView extends GetView<OnBoardingController> {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    
    return Scaffold(
      backgroundColor: AppColors.white,
      bottomSheet: welcomeBottomSheet(
        width: width,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: height * 0.1),
        child: const Align(
          alignment: Alignment.topCenter,
          child: Logo(),
        ),
      ),
    );
  }
}
