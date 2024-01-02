import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serviceapp/routes/rout_name.dart';
import 'package:serviceapp/utils/constants/app_color.dart';
import 'package:serviceapp/utils/constants/text_styles.dart';
import 'package:serviceapp/widget/button.dart';
import 'package:serviceapp/widget/textfeild.dart';
class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _usernameController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:   Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Forgot Password",
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
                controller: _usernameController,
                hinttext: "Email",
                preICon: Icon(Icons.email_outlined),),

              SizedBox(height: 60.h,),
              CustomButton(text:"Submit",textStyle: AppStyle.caption1.copyWith(color: AppColor.black) ,functions:(){
                Navigator.pushNamed(context, RoutName.restPasswordPage);
              } ,),

            ],
          ),
        ),
      ),

    );
  }
}


