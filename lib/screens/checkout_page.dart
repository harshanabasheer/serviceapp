import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serviceapp/widget/date_time_container.dart';

import '../routes/rout_name.dart';
import '../utils/constants/app_color.dart';
import '../utils/constants/text_styles.dart';
import '../widget/button.dart';
import '../widget/custom_row.dart';

class CheckoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: const BackButton(
            color: Colors.black,
          ),
          backgroundColor: AppColor.background,
          elevation: 0,
          title: Text('Checkout Page',style: AppStyle.title3.copyWith(color: AppColor.black)),
        ),
        body: Center(
          child: Container(
            width: 374.w,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 88.h,
                    child: Container(
                      child:Row(
                        children: [
                          Image.asset(
                          'assets/images/ac.png',
                          height: 60.h,
                          width: 60.w,
                          ),
                          Text("AC Repair Service",style: AppStyle.bodyBook.copyWith(color: AppColor.black),)
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.grey20,
                        borderRadius: BorderRadius.circular(12.0),
                      ),

                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text("Date & Time",style: AppStyle.headline.copyWith(color: AppColor.black),),
                  SizedBox(height: 20.h),
                  SizedBox(
                    width: double.infinity,
                    height: 56.h,
                    child: DateTimeContainer(text: "17 December,2022", icon:Icon(Icons.calendar_month) )
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    width: double.infinity,
                    height: 56.h,
                    child: DateTimeContainer(text: "04:14:02 PM", icon:Icon(Icons.lock_clock) )
                    ),
                  SizedBox(height: 20.h),
                  CustomRow(text: "Address", functions: (){
                    Navigator.pushNamed(context, RoutName.addressPage);
                  }),
                  SizedBox(height: 20.h),
                  CustomRow(text: "Phone Number", functions: (){
                    Navigator.pushNamed(context, RoutName.phonePage);
                  }),

                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Text('Total:',style: AppStyle.bodyBook.copyWith(color: AppColor.black)),
                      Text('30.00',style: AppStyle.title3.copyWith(color: AppColor.black)),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  CustomRow(text: "Pay With", functions: (){
                    Navigator.pushNamed(context, RoutName.paymentPage);
                  }),
                  SizedBox(height: 100.h),

                  ElevatedButton(
                    onPressed:(){},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.grey10,
                        minimumSize: const Size.fromHeight(50),
                        shape: const StadiumBorder()),
                    child: Text("Place Order",
                        style: AppStyle.caption1.copyWith(color: AppColor.black)
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


