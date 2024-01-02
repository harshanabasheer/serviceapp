import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:serviceapp/widget/button.dart';

import '../routes/rout_name.dart';
import '../utils/constants/app_color.dart';
import '../utils/constants/text_styles.dart';

class CustomAlert extends StatelessWidget {
  final String image;
  final String tex1;
  final String text2;
  const CustomAlert({
    required this.image,required this.tex1,required this.text2,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            image,
            height: 100,
            width: 100,
            // Adjust image size as needed
          ),
          const SizedBox(height: 20),
          Text(
            tex1,
            style: AppStyle.title2.copyWith(color: AppColor.black),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
                text2,
                style: AppStyle.bodyBook.copyWith(color: AppColor.black),
                textAlign: TextAlign.center
            ),
          ),
        ],
      ),
      actions: [
        CustomButton(
          text:"OK",textStyle: AppStyle.caption1.copyWith(color: AppColor.black) ,
          functions:(){
            Navigator.pushNamed(context, RoutName.loginPage);
          } ,),

      ],
    );
  }
}
