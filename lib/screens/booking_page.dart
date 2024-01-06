import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:read_more_text/read_more_text.dart';
import 'package:serviceapp/widget/container.dart';
import '../controller/booking_controller.dart';
import '../controller/home_controller.dart';
import '../routes/rout_name.dart';
import '../utils/constants/api_constants.dart';
import '../utils/constants/app_color.dart';
import '../utils/constants/text_styles.dart';
import '../widget/button.dart';

class BookingPage extends StatefulWidget {

  final  int  serviceId;
  const BookingPage({super.key, required this.serviceId});
  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {


  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeController>(context,listen: false).getOneServiceController(context, widget.serviceId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<HomeController>();

    return Scaffold(
      body:
      controller.loading?Center(child: CircularProgressIndicator(color: AppColor.darkYellow,),) :
      controller.oneService == null ?
      Center(child: Text('No data'),) :
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 414.w,
                height: 450.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:  NetworkImage(
                      "${Apiconstants.baseurl}${controller.oneService?.serviceImage}",
                  ),
                    fit: BoxFit.cover,
                  ),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
              ),
              Positioned(
                top: 300,
                right: 15,
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: AppColor.baseText,
                  child: Container(
                    width: 374.w,
                    height: 110.h,
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            controller.oneService?.serviceName ?? 'No Service',
                            style: AppStyle.title3.copyWith(color: AppColor.black)
                        ),
                        Row(
                          children: [
                            Text(
                                '\$ ${controller.oneService?.price ?? 'No Price'}',
                                style: AppStyle.bodyBook.copyWith(color: AppColor.black)
                            ),
                            SizedBox(width: 250.w,),
                            const Icon(
                              Icons.star,
                              color: Color(0xFFFFC107),
                            ),
                            Text(
                                controller.oneService?.rating ?? 'No Rating',
                              style: AppStyle.body2book
                                  .copyWith(color: AppColor.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 40.h),
          
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: 30.h,),
                  Text("Description", style: AppStyle.headline.copyWith(color: AppColor.black),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ReadMoreText(controller.oneService?.description ?? 'No Description', style: AppStyle.body2book.copyWith(color: AppColor.black),
                        numLines: 5,
                        readMoreText: 'Read More',
                        readLessText: 'Read Less',
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text("Total:", style: AppStyle.bodyBook.copyWith(color: AppColor.grey40),),
                      Text(
                        '\$ ${controller.oneService?.price ?? 'No Price'}',
                        style: AppStyle.title3.copyWith(color: AppColor.black),),
                    ],
                  ),
                  SizedBox(height: 20.h,),
                  CustomButton(
                    text: "Book Now",
                    textStyle: AppStyle.caption1.copyWith(color: AppColor.black),
                    functions: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return  Consumer<BookingController>(
                              builder: (context, provider, _) {
                                return SizedBox(
                                  width: double.maxFinite,
                                  child: Column(
                                     mainAxisSize: MainAxisSize.min,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          await provider.selectDate(context);

                                        },
                                        child:Container(
                                          width: 374.w,
                                          height: 56.h,
                                          decoration: ShapeDecoration(
                                            color: AppColor.grey10,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(16),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              provider.selectedDate != null
                                                  ? provider.selectedDate.toString().split(' ')[0]
                                                  : "Select Date",
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20.h),
                                      GestureDetector(
                                        onTap: () async {
                                          await provider.selectTime(context);

                                        },
                                        child:Container(
                                          width: 374,
                                          height: 56,
                                          decoration: ShapeDecoration(
                                            color:AppColor.grey10,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(16),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              provider.selectedTime != null
                                                  ? provider.selectedTime!.format(context)
                                                  : "Select Time",
                                            ),
                                          ),
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: CustomButton(
                                          text: (provider.selectedDate != null && provider.selectedTime != null)
                                              ? 'Continue'
                                              : 'Book Now',
                                          textStyle: AppStyle.caption1.copyWith(color: AppColor.black),
                                          functions: () {
                                            Navigator.pushNamed(context, RoutName.checkoutPage);

                                        },),
                                      )


                                    ],
                                  ),
                                );
                              },
                            );

                        },
                      );
                    },
                  ),
                  SizedBox(height: 30.h,),

                ],
              ),
            ),
          ),


        ],
      ),
    );
  }
}


