import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:serviceapp/routes/rout_name.dart';
import 'package:serviceapp/utils/constants/app_color.dart';
import 'package:serviceapp/utils/constants/text_styles.dart';
import 'package:serviceapp/widget/button.dart';
import 'package:serviceapp/widget/text_button.dart';
import 'package:serviceapp/widget/textfeild.dart';

import '../controller/auth_controller.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
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
            "Sign In",
            style: AppStyle.title1.copyWith(color: AppColor.black),
          ),
        ),
        automaticallyImplyLeading: false,
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
                preICon: const Icon(Icons.email_outlined),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFeild(
                  controller: _passwordController,
                  hinttext: "Password",
                  obscureText: controller.obscureText,
                  preICon: const Icon(Icons.lock_outline),
                  sufIcon: GestureDetector(
                    onTap: () {
                      controller.viewPassword();
                    },
                    child: Icon(controller.obscureText
                        ? Icons.visibility
                        : Icons.visibility_off),
                  )),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: CustomTextButton(
                  text: "Forgot Password?",
                  textStyle: AppStyle.bodyBook.copyWith(color: AppColor.black),
                  functions: () {
                    Navigator.pushNamed(context, RoutName.forgotPasswordPage);
                  },
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
             controller.loading?
             Center(
               child: CircularProgressIndicator(
                 color: AppColor.darkYellow,
               ),
             ):
             CustomButton(
                text: "Sign In",
                textStyle: AppStyle.caption1.copyWith(color: AppColor.black),
                functions: () {
                  controller.signIn(password: _passwordController.text, email: _usernameController.text,context: context);

                },
              ),

              SizedBox(
                height: 280.h,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: CustomTextButton(
                  text: "Don't have an account?Sign Up",
                  textStyle: AppStyle.bodyBook.copyWith(color: AppColor.black),
                  functions: () {
                    Navigator.pushNamed(context, RoutName.signUpPage);
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
