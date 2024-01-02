import 'package:flutter/material.dart';
import 'package:serviceapp/utils/constants/app_color.dart';

class CustomTextFeild extends StatelessWidget {
  final TextEditingController controller;
  final String hinttext;
  final Icon preICon;
  final Widget ? sufIcon;
  final TextInputType ? keyboardType;
  final bool ?obscureText;
  const CustomTextFeild({
    required this.controller,
    required this.hinttext,
    required this.preICon,
    this.sufIcon,
    this.obscureText,
    this.keyboardType,
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return TextField(
      controller:controller,
      keyboardType: keyboardType,
      obscureText: obscureText?? false,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColor.grey10,
        hintText: hinttext,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        prefixIcon: preICon,
        suffixIcon: sufIcon

      ),
    );
  }
}