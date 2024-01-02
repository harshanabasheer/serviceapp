import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serviceapp/routes/rout_name.dart';
import 'package:serviceapp/utils/constants/app_color.dart';
import 'package:serviceapp/utils/constants/text_styles.dart';
import 'package:serviceapp/widget/button.dart';

class Intro1 extends StatelessWidget {
   Intro1({Key? key, required this.controller}) : super(key: key);

    PageController  controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
                width: double.infinity,
                height: 500.h,
                child: Image.asset(
                  'assets/images/intro1.png',
                  fit: BoxFit.fitWidth,
                )),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Beauty parlour at your home',
                    style: AppStyle.largeTitle.copyWith(color: AppColor.black),
                    textAlign: TextAlign.center,),
                  Text('Lorem ipsum is a placeholder text commonly used to demonstrate the visual.',
                    style: AppStyle.bodyBook.copyWith(color: AppColor.black),
                    textAlign: TextAlign.center,),
                  SizedBox(height: 20.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...List.generate(
                          3,
                              (index) => Container(
                            margin: const EdgeInsets.all(4.0),
                            width: index == 0 ? 15.0 : 10.0,
                            height: index == 0 ? 15.0 : 10.0,
                            decoration: BoxDecoration(
                              color: index == 0
                                  ? AppColor.darkYellow
                                  : AppColor.grey30,
                              shape: BoxShape.circle,
                            ),
                          )),
                    ],
                  ),
                  SizedBox(height: 20.h,),

                  CustomButton(text:"Next",textStyle: AppStyle.caption1.copyWith(color: AppColor.black) ,functions:(){
                    controller.jumpToPage(1);
                  } ,),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
