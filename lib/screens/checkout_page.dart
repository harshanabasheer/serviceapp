import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:serviceapp/controller/booking_controller.dart';
import 'package:serviceapp/controller/home_controller.dart';
import 'package:serviceapp/widget/date_time_container.dart';

import '../routes/rout_name.dart';
import '../utils/constants/api_constants.dart';
import '../utils/constants/app_color.dart';
import '../utils/constants/text_styles.dart';
import '../widget/button.dart';
import '../widget/custom_row.dart';

class CheckoutPage extends StatefulWidget {
  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BookingController>(context, listen: false).initial(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        backgroundColor: AppColor.background,
        elevation: 0,
        title: Text('Checkout Page',
            style: AppStyle.title3.copyWith(color: AppColor.black)),
      ),
      body: Center(
        child: Container(
          width: 374.w,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 88.h,
                    child: Container(
                      child: Consumer<HomeController>(
                          builder: (context, provider, _) {

                        return Row(
                          children: [
                            Image.network(
                              "${Apiconstants.baseurl}${provider.oneService?.serviceImage ?? ''}",
                              height: 60.h,
                              width: 60.w,
                            ),
                            Text(
                              provider.oneService?.serviceName ?? 'No Service',
                              style: AppStyle.bodyBook
                                  .copyWith(color: AppColor.black),
                            )
                          ],
                        );
                      }),
                      decoration: BoxDecoration(
                        color: AppColor.grey20,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Date & Time",
                    style: AppStyle.headline.copyWith(color: AppColor.black),
                  ),
                  SizedBox(height: 20.h),
                  Consumer<BookingController>(builder: (context, provider, _) {
                    return SizedBox(
                        width: double.infinity,
                        height: 56.h,
                        child: DateTimeContainer(
                            text:
                                provider.selectedDate.toString().split(' ')[0],
                            icon: Icon(Icons.calendar_month)));
                  }),
                  SizedBox(height: 20.h),
                  Consumer<BookingController>(builder: (context, provider, _) {
                    return SizedBox(
                        width: double.infinity,
                        height: 56.h,
                        child: DateTimeContainer(
                            text: provider.selectedTime!.format(context),
                            icon: Icon(Icons.lock_clock)));
                  }),
                  SizedBox(height: 20.h),
                  CustomRow(
                    text: "Address",
                    functions: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.home),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      flex: 1,
                                      child: TextField(
                                        controller: _addressController,
                                        decoration: InputDecoration(
                                          hintText: 'Enter your Address',
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    ElevatedButton(
                                      onPressed: () {
                                        context
                                            .read<BookingController>()
                                            .addAddress(
                                                context: context,
                                                newAddress:
                                                    _addressController.text);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColor.darkYellow,
                                        shape: StadiumBorder(),
                                      ),
                                      child: Text(
                                        'Save',
                                        style: AppStyle.caption2
                                            .copyWith(color: AppColor.black),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  Consumer<BookingController>(
                    builder: (context, provider, _) {
                      if (provider.address != null) {
                        return Row(
                          children: [
                            Image.asset(
                              'assets/images/home.png',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Home',
                                    style: AppStyle.subHeadline
                                        .copyWith(color: AppColor.black),
                                  ),
                                  SizedBox(height: 5.h),
                                  Text(
                                    provider.address!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppStyle.body2book
                                        .copyWith(color: AppColor.grey40),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ),
                  SizedBox(height: 20.h),
                  CustomRow(
                    text: "Phone Number",
                    functions: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.phone),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      flex: 1,
                                      child: TextField(
                                        controller: _phoneController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          hintText: 'Enter your phone number',
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    ElevatedButton(
                                      onPressed: () {
                                        context
                                            .read<BookingController>()
                                            .addPhone(
                                                context: context,
                                                newPhone:
                                                    _phoneController.text);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColor.darkYellow,
                                        shape: StadiumBorder(),
                                      ),
                                      child: Text(
                                        'Save',
                                        style: AppStyle.caption2
                                            .copyWith(color: AppColor.black),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  Consumer<BookingController>(
                      builder: (context, provider, _) => provider.phone != null
                          ? Text(
                              "+91 ${provider.phone!}",
                              style: AppStyle.bodyBook
                                  .copyWith(color: AppColor.black),
                            )
                          : SizedBox.shrink()),
                  SizedBox(height: 20.h),
                  Consumer<BookingController>(builder: (context, provider, _) {
                    return Consumer<HomeController>(
                        builder: (context, provider, _) {
                      return Row(
                        children: [
                          Text('Total:',
                              style: AppStyle.bodyBook
                                  .copyWith(color: AppColor.black)),
                          Text('\$ ${provider.oneService?.price ?? 'No Price'}',
                              style: AppStyle.title3
                                  .copyWith(color: AppColor.black)),
                        ],
                      );
                    });
                  }),
                  SizedBox(height: 20.h),
                  Consumer<BookingController>(builder: (context, provider, _) {
                    return CustomRow(
                        text: "Pay With",
                        buttonvisible:
                            provider.paymentId == null ? true : false,
                        functions: () async {
                          final amount = double.tryParse(context
                              .read<HomeController>()
                              .oneService!
                              .price!);
                          if (amount != null) {
                            final amount = double.parse(context
                                .read<HomeController>()
                                .oneService!
                                .price!);
                            await context
                                .read<BookingController>()
                                .createOrder(amount: amount, context: context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Something Went Wrong")));
                          }
                        });
                  }),
                 SizedBox(height: 30.h),
                  Consumer<BookingController>(builder: (context, provider, _) {

                    return provider.paymentId != null &&
                            provider.address != null &&
                            provider.phone != null
                        ? CustomButton(
                            text: 'Place Booking',
                            textStyle: AppStyle.caption1
                                .copyWith(color: AppColor.black),
                            functions: () {
                             provider.placeBookingController(
                                 context: context,
                                 userId: "3",
                                 userName: "harshana",
                                 serviceId: context.read<HomeController>().oneService!.id.toString(),
                                 serviceName: context.read<HomeController>().oneService!.serviceName!,
                                 date:  provider.selectedDate.toString().split(' ')[0],
                                 time: provider.selectedTime!.format(context),
                                 status: "0",
                                 address: provider.address!,
                                 price: context.read<HomeController>().oneService!.price.toString());
                            },
                          )
                        : ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.grey10,
                                minimumSize: const Size.fromHeight(50),
                                shape: const StadiumBorder()),
                            child: Text("Place Order",
                                style: AppStyle.caption1
                                    .copyWith(color: AppColor.black)),
                          );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
