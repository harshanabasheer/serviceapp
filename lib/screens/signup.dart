import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:serviceapp/routes/rout_name.dart';
import 'package:serviceapp/screens/otp_page.dart';
import 'package:serviceapp/utils/constants/app_color.dart';
import 'package:serviceapp/utils/constants/text_styles.dart';
import 'package:serviceapp/widget/button.dart';
import 'package:serviceapp/widget/text_button.dart';
import 'package:serviceapp/widget/textfeild.dart';

import '../controller/auth_controller.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  final GoogleSignIn googleSignIn = GoogleSignIn();

  void _handleSignIn() async {
    try {
      await googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AuthController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Sign Up",
            style: AppStyle.title1.copyWith(color: AppColor.black),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomTextFeild(
                controller: _nameController,
                hinttext: "Name",
                preICon: Icon(Icons.account_circle_outlined),
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextFeild(
                controller: _usernameController,
                hinttext: "Email",
                preICon: Icon(Icons.email_outlined),
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextFeild(
                controller: _phoneController,
                keyboardType: TextInputType.number,
                hinttext: "Phone Number",
                obscureText: controller.obscureText,
                preICon: Icon(Icons.phone),
                sufIcon: GestureDetector(
                  onTap: () {
                    controller.viewPassword();
                  },
                  child: Icon(controller.obscureText
                      ? Icons.visibility
                      : Icons.visibility_off),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextFeild(
                  controller: _passwordController,
                  hinttext: "Password",
                  obscureText: controller.obscureText,
                  preICon: Icon(Icons.lock_outline),
                  sufIcon: GestureDetector(
                    onTap: () {
                      controller.viewPassword();
                    },
                    child: Icon(controller.obscureText
                        ? Icons.visibility
                        : Icons.visibility_off),
                  )),
              SizedBox(
                height: 40.h,
              ),
              controller.loading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColor.darkYellow,
                      ),
                    )
                  : CustomButton(
                      text: "Sign Up",
                      textStyle:
                          AppStyle.caption1.copyWith(color: AppColor.black),
                      functions: () async {
                        controller.register(
                                      name: _nameController.text,
                                      phone: _phoneController.text,
                                      email: _usernameController.text,
                                      password: _passwordController.text,
                                      context: context);
                      },
                    ),
              SizedBox(
                height: 40.h,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Sign in with",
                  style: AppStyle.bodyBook.copyWith(color: AppColor.black),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: _handleSignIn,
                child: Image.asset(
                  'assets/images/Google.png',
                  height: 50,
                  width: 50,
                ),
              ),
              SizedBox(
                height: 150.h,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: CustomTextButton(
                  text: "Already have an account? Login",
                  textStyle: AppStyle.bodyBook.copyWith(color: AppColor.black),
                  functions: () {
                    Navigator.pushNamed(context, RoutName.loginPage);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
