import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:serviceapp/controller/booking_controller.dart';
import '../utils/constants/api_constants.dart';
import '../utils/constants/app_color.dart';
import '../utils/constants/text_styles.dart';

class AllBookings extends StatefulWidget {
  @override
  State<AllBookings> createState() => _AllBookingsState();
}

class _AllBookingsState extends State<AllBookings> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BookingController>(context,listen: false).getAllBookingsController(context);
    });
    super.initState();
  }
  Widget build(BuildContext context) {

    final controller = context.watch<BookingController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Bookings',style: AppStyle.title3.copyWith(color: AppColor.black)),
        centerTitle: true,
      ),
      body:
      Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: controller.loading?
                const Center(
                  child: CircularProgressIndicator(
                    color: AppColor.darkYellow,
                  ),
                ):
                ListView.builder(
                  itemCount: controller.allBookings?.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: AppColor.baseText,
                      child: Container(
                        width: 374.w,
                        height: 171.h,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SingleChildScrollView(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(width: 20.w,),
                                  Image.network(
                                    "${Apiconstants.baseurl}${controller.allBookings?[index].serviceImage}",
                                    width: 91.w,
                                    height: 91.h,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(width: 20.w,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 250.w,
                                        child: Text(
                                          controller.allBookings?[index].serviceName ?? 'No service',
                                          style: AppStyle.headline.copyWith(color: AppColor.black),
                                        ),
                                      ),
                                      SizedBox(height: 5.h,),
                                      Text(
                                        "${controller.allBookings?[index].date},${controller.allBookings?[index].time}" ?? 'No date',
                                        style: AppStyle.body2book.copyWith(color: AppColor.grey40),
                                      ),
                                      SizedBox(height: 5.h,),
                                      Text(
                                        "\$${controller.allBookings?[index].price}" ?? 'No price',
                                        style: AppStyle.headline.copyWith(color: AppColor.darkYellow),
                                      ),

                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

              ),
            ),
          ],
        ),
      ),
    );
  }
}

