import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serviceapp/routes/rout_name.dart';
import 'package:serviceapp/utils/constants/app_color.dart';
import 'package:serviceapp/utils/constants/text_styles.dart';
import 'package:serviceapp/widget/alert.dart';
import 'package:serviceapp/widget/button.dart';
import 'package:serviceapp/widget/textfeild.dart';
class RestPassword extends StatefulWidget {
  const RestPassword({super.key});

  @override
  State<RestPassword> createState() => _RestPasswordState();
}

class _RestPasswordState extends State<RestPassword> {
  TextEditingController _passwordController=TextEditingController();
  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlert(image: 'assets/images/password.png',
            tex1: 'Password Changed',
            text2: 'Your password has been successfully changed!');
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:   Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Reset Password",
            style: AppStyle.title1.copyWith(color: AppColor.black),
          ),),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomTextFeild(
                controller: _passwordController,
                hinttext: "New Password",
                preICon: Icon(Icons.lock_outline),
                sufIcon: Icon(Icons.remove_red_eye_outlined),),
              SizedBox(height: 20,),
              CustomTextFeild(
                controller: _passwordController,
                hinttext: "Confirm Password",
                preICon: Icon(Icons.lock_outline),
                sufIcon: Icon(Icons.remove_red_eye_outlined),),

              SizedBox(height: 60.h,),
              CustomButton(text:"Submit",textStyle: AppStyle.caption1.copyWith(color: AppColor.black) ,
                functions:(){
                  _showConfirmationDialog(context);
              } ,),


            ],
          ),
        ),
      ),

    );
  }
}


