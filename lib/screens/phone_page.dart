import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/constants/app_color.dart';
import '../utils/constants/text_styles.dart';

class PhonePage extends StatefulWidget {
  @override
  _PhonePageState createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {


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
            'Add Number', style: AppStyle.title3.copyWith(color: AppColor.black),),
          backgroundColor: AppColor.background,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Add New Number",style: AppStyle.headline.copyWith(color: AppColor.black),),
              SizedBox(height: 10,),
              Container(
                width: 374,
                height: 56,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(28),
                ),
                child:  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.phone),
                        SizedBox(width: 10),
                        Expanded(
                          flex: 1,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Enter your phone number',
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.darkYellow,
                            shape: StadiumBorder()
                          ),
                          child: Text('Save',style: AppStyle.caption2.copyWith(color: AppColor.black),),
                        ),
                      ],
                    ),

                  ),
                ),
              ),

              SizedBox(height: 20),
              Container(
                width: 374,
                height: 129,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 10.h,),
                      Text("Phone Number",style: AppStyle.headline.copyWith(color: AppColor.black),),
                      SizedBox(height: 20.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset('assets/images/profie.jpeg',
                            width: 50.w,
                            height: 50.h,
                            fit: BoxFit.cover,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("(603) 555-0123",style: AppStyle.bodyBook.copyWith(color: AppColor.black),),
                              Text("Primary",style: AppStyle.footNote.copyWith(color: AppColor.grey40),),

                            ],
                          ),

                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


