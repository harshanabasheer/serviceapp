import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import '../utils/constants/app_color.dart';
import '../utils/constants/text_styles.dart';

class AddressPage extends StatefulWidget {
  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  String _selectedAddress = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: const BackButton(
            color: Colors.black,
          ),
          elevation: 0,
          title: Text('Address',style: AppStyle.title3.copyWith(color: AppColor.black),),
          backgroundColor: AppColor.background,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 374,
                height: 56,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Center(
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                          print('Current location: Lat=${position.latitude}, Long=${position.longitude}');
                        },
                        child: Text(
                          'At my current location',
                          style: AppStyle.headline.copyWith(color: AppColor.black),
                        ),
                      ),
                      const Icon(Icons.location_on)
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("Address",style: AppStyle.headline.copyWith(color: AppColor.black),),
                      SizedBox(
                        height: 20.h,
                      ),
                      _buildAddressSelectionTile(
                          'assets/images/home.png',
                          'Home','2972 Westheimer Rd. Santa Ana, Illinois', 
                          'home',
                      ),
                      _buildAddressSelectionTile(
                          'assets/images/office.png',
                          'Office',
                          '8502 Preston Rd. Inglewood, Maine 98380', 
                          'office',
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

  Widget _buildAddressSelectionTile(String image,String text,String text1, String value) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAddress = value;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Image.asset(
             image,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            SizedBox(width:20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(text,style: AppStyle.subHeadline.copyWith(color: AppColor.black),),
                  SizedBox(height: 5.h,),
                  Text(text1,maxLines: 2  ,overflow: TextOverflow.ellipsis,style: AppStyle.body2book.copyWith(color: AppColor.grey40),),
                ],
              ),
            ),
            Spacer(),
            Radio(
              value: value,
              groupValue: _selectedAddress,
              onChanged: (selectedValue) {
                setState(() {
                  _selectedAddress = selectedValue.toString();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
