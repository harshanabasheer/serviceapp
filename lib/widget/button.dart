import 'package:flutter/material.dart';
import 'package:serviceapp/utils/constants/app_color.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final TextStyle ? textStyle;
  final VoidCallback functions;
  const CustomButton({
    required this.text,
    required this.functions,
    this.textStyle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: functions,
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.darkYellow,
          minimumSize: const Size.fromHeight(50), //
          shape: const StadiumBorder()),
      child: Text(
        text,
        style:textStyle,
      ),
    );
  }
}
