import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:serviceapp/routes/rout_name.dart';
import 'package:serviceapp/utils/constants/app_color.dart';
import 'package:serviceapp/utils/constants/text_styles.dart';
import 'package:serviceapp/widget/alert.dart';
import 'package:serviceapp/widget/button.dart';
import 'package:serviceapp/widget/text_button.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController _otpController = TextEditingController();
  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlert(image: 'assets/images/security.png', tex1: "Account Created", text2: "Your account has been successfully created!");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
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
              length: 5,
              keyboardType: TextInputType.number,
              obscureText: false,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 60.h,
                fieldWidth: 70.w,
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
            SizedBox(height: 50.h,),
            CustomButton(text:"Verify",textStyle: AppStyle.caption1.copyWith(color: AppColor.black) ,
              functions:(){
                _showConfirmationDialog(context);
              } ,),
             SizedBox(height: 50.h),
            CustomTextButton(text:"Didn’t recieve code? Resend",textStyle: AppStyle.bodyBook.copyWith(color: AppColor.black) ,functions:(){
              // Navigator.pushNamed(context, RoutName.signUpPage);
            } ,),


          ],
        ),
      ),
    );
  }
}

