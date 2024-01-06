import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:serviceapp/controller/booking_controller.dart';
import '../routes/rout_name.dart';
import '../utils/constants/app_color.dart';
import '../utils/constants/text_styles.dart';
import '../widget/button.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/confirm.png',
              height: 100,
              width: 100,
              // Adjust image size as needed
            ),
             SizedBox(height:20.h),
            Text(
              'Booking Confirmed',
              style: AppStyle.title2.copyWith(color: AppColor.black),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                  'Your booking has been successfully\nconfirmed!',
                  style: AppStyle.bodyBook.copyWith(color: AppColor.black),
                  textAlign: TextAlign.center
              ),
            ),
            SizedBox(height:20.h),
            CustomButton(
              text:"OK",textStyle: AppStyle.caption1.copyWith(color: AppColor.black) ,
              functions:(){
                context.read<BookingController>().clearData();
                Navigator.pushNamedAndRemoveUntil(context, RoutName.homepage, (route) => false);
              } ,),
          ],
        ),
      ),
    );
  }
}
