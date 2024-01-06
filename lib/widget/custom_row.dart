import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/constants/app_color.dart';
import '../utils/constants/text_styles.dart';

class CustomRow extends StatelessWidget {
  final String text;
  final bool buttonvisible;
  final VoidCallback functions;
  const CustomRow({
    required this.text,
    required this.functions,
    this.buttonvisible = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text,style: AppStyle.headline.copyWith(color: AppColor.black)),
        Spacer(),
         buttonvisible?
         ElevatedButton(
          onPressed: functions,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.grey10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text('Add +',style: AppStyle.footNote.copyWith(color: AppColor.black)),
        ) :Icon(Icons.check,color: Colors.green,)
      ],
    );
  }
}

