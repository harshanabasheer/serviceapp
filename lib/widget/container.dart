import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constants/app_color.dart';
import '../utils/constants/text_styles.dart';

class CustomContainer extends StatelessWidget {
  final String text;
  final Icon icon;
  const CustomContainer({
    required this.text,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 111.w,
      height: 60.h,
      decoration: BoxDecoration(
        color: AppColor.darkYellow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon.icon,
            color: AppColor.black,
          ),
          SizedBox(width: 8.w),
          Text(
            text,
            style: AppStyle.body2book
                .copyWith(color: AppColor.black),
          ),
        ],
      ),
    );
  }
}