import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/constants/app_color.dart';
import '../utils/constants/text_styles.dart';

class AddCard extends StatefulWidget {
  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: const BackButton(
            color: Colors.black,
          ),
          elevation: 0,
          title: Text(
            'Add Card', style: AppStyle.title3.copyWith(color: AppColor.black),),
          backgroundColor: AppColor.background,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Add New Card",style: AppStyle.headline.copyWith(color: AppColor.black),),
              SizedBox(height: 10,),
              Container(
                width: 374.w,
                height: 56.h,
                decoration: BoxDecoration(
                  color: AppColor.grey10,
                  borderRadius: BorderRadius.circular(12),
                ),
                child:  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.credit_card),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Card number',
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                  ),
                ),
              ),

              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 177.w,
                    height: 56.h,
                    decoration: BoxDecoration(
                      color: AppColor.grey10,
                      borderRadius: BorderRadius.circular(12),
                    ),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'MM/YY',
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                  ),
                  Container(
                    width: 177.w,
                    height: 56.h,
                    decoration: BoxDecoration(
                      color: AppColor.grey10,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'CVV',
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Checkbox(
                    value: false,
                    onChanged: (bool? value) {
                    },
                    checkColor: AppColor.darkYellow,
                    activeColor: AppColor.darkYellow,
                  ),
                  Text(
                    'Save Card',
                    style: AppStyle.bodyBook.copyWith(color: AppColor.black),
                  ),
                ],
              ),


            ],
          ),
        ),
      ),
    );
  }
}


