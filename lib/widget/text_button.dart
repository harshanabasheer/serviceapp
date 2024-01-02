import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final TextStyle ? textStyle;
  final VoidCallback functions;
  const CustomTextButton({
    required this.text,
    required this.functions,
    this.textStyle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: functions,
      child: Text(
        text,
        style: textStyle),);

  }
}