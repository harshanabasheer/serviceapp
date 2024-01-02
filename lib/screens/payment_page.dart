import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../routes/rout_name.dart';
import '../utils/constants/app_color.dart';
import '../utils/constants/text_styles.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String _selectedCard = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: const BackButton(
            color: Colors.black,
          ),
          elevation: 0,
          title: Text('Payment',style: AppStyle.title3.copyWith(color: AppColor.black),),
          backgroundColor: AppColor.background,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Container(
              //   width: 374,
              //   height: 56,
              //   decoration: BoxDecoration(
              //     border: Border.all(color: Colors.grey),
              //     borderRadius: BorderRadius.circular(28),
              //   ),
              //   child: Center(
              //     child:Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceAround,
              //       children: [
              //         GestureDetector(
              //           onTap: () async {
              //             Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
              //             print('Current location: Lat=${position.latitude}, Long=${position.longitude}');
              //           },
              //           child: Text(
              //             'At my current location',
              //             style: AppStyle.headline.copyWith(color: AppColor.black),
              //           ),
              //         ),
              //         Icon(Icons.location_on)
              //       ],
              //     ),
              //   ),
              // ),
              SizedBox(height: 20),
              Container(
                width: 374.w,
                height: 250.h,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Added Card List",style: AppStyle.headline.copyWith(color: AppColor.black),),

                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, RoutName.addCard);

                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                                backgroundColor: AppColor.grey10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )
                            ),
                            child: Text('Change',style: AppStyle.caption2.copyWith(color: AppColor.black),),
                          ),
                        ],
                      ),

                      _buildAddressSelectionTile( 'assets/images/card.png','*********2345','Exp 03/2023', 'card'),
                      _buildAddressSelectionTile( 'assets/images/visa.png','*********2055','Exp 03/2023', 'visa'),
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

  Widget _buildAddressSelectionTile(String image,String text,String text1, String value) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCard = value;
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              image,
              width: 50.w,
              height: 50.h,
              fit: BoxFit.cover,
            ),
            SizedBox(width:20.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(text,style: AppStyle.subHeadline.copyWith(color: AppColor.black),),
                SizedBox(height: 5.h,),
                Text(text1,maxLines: 3,overflow: TextOverflow.ellipsis,style: AppStyle.body2book.copyWith(color: AppColor.grey40),),
              ],
            ),
            Spacer(),
            Radio(
              value: value,
              groupValue: _selectedCard,
              onChanged: (selectedValue) {
                setState(() {
                  _selectedCard = selectedValue.toString();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
