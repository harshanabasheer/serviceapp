import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:serviceapp/controller/auth_controller.dart';
import 'package:serviceapp/routes/rout_name.dart';
import 'package:serviceapp/screens/login.dart';
import 'package:serviceapp/utils/constants/app_color.dart';
import 'package:serviceapp/utils/constants/text_styles.dart';
import 'package:serviceapp/widget/alert.dart';
import 'package:serviceapp/widget/button.dart';
import 'package:serviceapp/widget/text_button.dart';

class OtpPage extends StatefulWidget {
  String verificationId;
  OtpPage({super.key, required this.verificationId});

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController _otpController = TextEditingController();
  OtpTimerButtonController controller = OtpTimerButtonController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign Up",
          style: AppStyle.title1.copyWith(color: AppColor.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            PinCodeTextField(
              appContext: context,
              length: 6,
              keyboardType: TextInputType.number,
              obscureText: false,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 60.h,
                fieldWidth: 50.w,
                inactiveColor: AppColor.grey30,
              ),
              animationDuration: const Duration(milliseconds: 300),
              controller: _otpController,
              onCompleted: (v) {
                print("Completed");
              },
              onChanged: (value) {
                print(value);
              },
            ),
            SizedBox(
              height: 50.h,
            ),
            Consumer<AuthController>(
              builder: (context,provider,_) {
                return CustomButton(
                  text: "Verify",
                  textStyle: AppStyle.caption1.copyWith(color: AppColor.black),
                  functions: () {
                    provider.verifyOTPAndSignIn(context, widget.verificationId, _otpController.text);
                  },
                );
              }
            ),
            SizedBox(height: 50.h),
            Consumer<AuthController>(
              builder: (context,provider,_) {
                return provider.resendTime
                    ? Center(
                  child: OtpTimerButton(
                    controller: controller,
                    onPressed: () {},
                    buttonType: ButtonType.text_button,
                    text: Text('Re-send code in-',
                        style: AppStyle.bodyBook.copyWith(color: AppColor.black)),
                    duration: 20,
                  ),
                )
                    :CustomTextButton(
                  text: "Didn’t recieve code? Resend",
                  textStyle: AppStyle.bodyBook.copyWith(color: AppColor.black),
                  functions: () {
                    provider.resendOTP(provider.user!.phone!, context);
                  },
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
