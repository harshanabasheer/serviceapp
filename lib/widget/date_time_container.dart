import 'package:flutter/material.dart';

import '../utils/constants/app_color.dart';
import '../utils/constants/text_styles.dart';

class DateTimeContainer extends StatelessWidget {
  final String text;
  final Icon icon;
  const DateTimeContainer({
    required this.text,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          icon,
          Text(text,style: AppStyle.bodyBook.copyWith(color: AppColor.black)),
          Spacer(),
          Icon(Icons.edit),

        ],
      ),
      decoration: BoxDecoration(
        color: AppColor.grey10,
        borderRadius: BorderRadius.circular(12.0),
      ),
    );
  }
}