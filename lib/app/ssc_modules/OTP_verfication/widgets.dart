import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rail_weld/app/ssc_modules/OTP_verfication/OTP_verfication_controller.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_sized_box.dart';
import '../../../widgets/custom_text.dart';

Widget loginBottomSheet({
  required TextEditingController emailController,
  double width = 20,
}) {
  OTPVerificationController controller = Get.find<OTPVerificationController>();
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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          mediumText(
            title: "Enter OTP",
          ),
          customSizedBox(height: 20),
          Form(
            key: controller.otpKey,
            child: PinCodeTextField(
              // onChanged: (value) => controller.isEnable.value =
              //     controller.otpController.text.length == 6,
              appContext: Get.context!,
              cursorColor: AppColors.black,
              autoDisposeControllers: false,
              length: 6,
              autovalidateMode: AutovalidateMode.disabled,
              textStyle: const TextStyle(color: AppColors.black),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              controller: controller.OTPController,
              animationType: AnimationType.none,
              enableActiveFill: true,
              validator: (value) {
                if ((value?.length ?? 0) < 6) {
                  return "Enter 6 digit OTP .";
                } else {
                  return null;
                }
              },
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(8),
                borderWidth: 1,
                fieldHeight: width * 0.12,
                fieldWidth: width * 0.12,
                activeFillColor: AppColors.white,
                selectedFillColor: AppColors.white,
                inactiveFillColor: AppColors.white,
                activeColor: AppColors.white,
                selectedColor: AppColors.white,
                inactiveColor: AppColors.white,
              ),
            ),
          ),
          customSizedBox(height: 15),
          Obx(
            () => controller.start.value != 0
                ? Align(
                    alignment: Alignment.centerRight,
                    child: smallText(
                      title: "Resend OTP in ${controller.start.value} sec",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                : const SizedBox(),
          ),
          Obx(
            () => GestureDetector(
              onTap: () async {
                controller.OTPController.text = "";
                await controller.forgotPasswordController
                    .forgotPassword(isResend: true);
                controller.start.value = 60;
                controller.startTimer();
              },
              child: controller.start.value == 0
                  ? Align(
                      alignment: Alignment.centerRight,
                      child: smallText(
                        title: "Resend OTP",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  : const SizedBox(),
            ),
          ),
          customSizedBox(
            height: width * 0.18,
          ),
          SizedBox(
            width: double.infinity,
            child: customElevatedButton(
              padding: const EdgeInsets.symmetric(
                vertical: 14.43,
              ),
              onPressed: () async {
                if (controller.otpKey.currentState!.validate()) {
                  await controller.otpVerification();
                }
              },
              title: "Proceed",
            ),
          ),
          customSizedBox(height: 7),
        ]),
      ),
    ],
  );
}
