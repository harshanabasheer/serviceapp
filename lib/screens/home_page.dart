import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:serviceapp/controller/home_controller.dart';
import 'package:serviceapp/utils/constants/api_constants.dart';
import 'package:serviceapp/widget/text_button.dart';
import '../controller/profile_controller.dart';
import '../routes/rout_name.dart';
import '../utils/constants/app_color.dart';
import '../utils/constants/text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    Provider.of<HomeController>(context,listen: false).handleLocationPermission(context);
    Provider.of<HomeController>(context,listen: false).getAllCategoriesController();
    Provider.of<HomeController>(context,listen: false).getRecommentedServiceController(context);
    Provider.of<HomeController>(context,listen: false).getAllCleaningServiceController(context);
    Provider.of<HomeController>(context,listen: false).locatePosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<HomeController>();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/profie.jpeg'),
                  ),
                   SizedBox(width: 20.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Jacob Jones",
                          maxLines: 1,
                          style: AppStyle.bodyBook.copyWith(color: AppColor.black),
                        ),
                        Text(
                          "jacobjones@gmail.com",
                          maxLines: 1,
                          style: AppStyle.bodyBook.copyWith(color: AppColor.grey40),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              buildGestureDetector(Icon(Icons.calendar_today), "Calender"),
               SizedBox(height: 20.h),
              buildGestureDetector(Icon(Icons.payment), "Payment Methods"),
               SizedBox(height: 20.h),
              buildGestureDetector(Icon(Icons.location_on), "Address"),
               SizedBox(height: 20.h),
              buildGestureDetector(Icon(Icons.notifications_none), "Notifications"),
               SizedBox(height: 20.h),
              buildGestureDetector(Icon(Icons.local_offer_sharp), "Offers"),
               SizedBox(height: 20.h),
              buildGestureDetector(Icon(Icons.supervisor_account_rounded), "Refer a Friends"),
               SizedBox(height: 20.h),
              buildGestureDetector(Icon(Icons.phone), "Support"),
            ],
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 414.w,
                  height: 236.h,
                  decoration: const ShapeDecoration(
                    color: AppColor.darkYellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Consumer<HomeController>(
                    builder: (context,provider,_) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.notes),
                            onPressed: () {
                              _scaffoldKey.currentState?.openDrawer();
                            },
                          ),

                           SizedBox(width: 70.w),
                          const Icon(Icons.location_on),
                          Consumer<HomeController>(
                            builder: (context,provider,_) {
                              return Text(
                                provider.location == null
                                    ? 'Loading...'
                                    : provider.location!.toString(),
                                style: AppStyle.body2book
                                    .copyWith(color: AppColor.black),
                              );
                            }
                          ),

                           SizedBox(width: 70.w),
                          const Icon(Icons.notifications),
                        ],
                      );
                    }
                  ),
                ),
                Positioned(
                  bottom: 80,
                  right: 20,
                  child: Container(
                    width: 374.w,
                    height: 44.h,
                    decoration: ShapeDecoration(
                      color: AppColor.grey10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child:  Row(
                      children: [
                        SizedBox(width: 16.w),
                        Icon(Icons.search),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: TextField(
                            onTap:(){
                              Navigator.pushNamed(context, RoutName.searchPage);
                            } ,
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 150,
                  right: 30,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      'assets/images/offer.png',
                      width: 350.w,
                      height: 150.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 100.h,
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Select Service",
                          style: AppStyle.headline.copyWith(color: AppColor.black)),
                      CustomTextButton(
                        text: "See All",
                        textStyle:
                        AppStyle.body2book.copyWith(color: AppColor.grey40),
                        functions: () {
                          Navigator.pushNamed(context, RoutName.selectService);
                        },
                      ),
                    ],
                  ),
                  Container(
                    height: 95.h,
                    child:
                    controller.loading?
                    const Center(
                      child: CircularProgressIndicator(
                        color: AppColor.darkYellow,
                      ),
                    ):
                    ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.categories?.data?.length,
                      itemBuilder: (context, index) {
                        return
                          GestureDetector(
                            onTap: ()  {
                              Navigator.pushNamed(
                                  context,
                                  RoutName.serviceDetailPage,
                                  arguments: controller.categories?.data![index].id
                              );
                            },
                            child: Card(
                            color: AppColor.background,
                            child: Container(
                              width: 79.w,
                              height: 85.h,
                              child: Column(
                                children: [
                                  Image.network(
                                   "${Apiconstants.baseurl}${controller.categories?.data![index].categoryImage}",
                                    width: 40.w,
                                    height: 40.h,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                    controller.categories?.data?[index].categoryName ?? 'No Category',
                                    style: AppStyle.body2book.copyWith(color: AppColor.black),
                                  ),
                                ],
                              ),
                            ),
                        ),
                          );
                      },
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Cleaning Service",
                        style: AppStyle.headline.copyWith(color: AppColor.black)),
                  ),
                  SizedBox(height: 10.h,),
                  Container(
                    height: 110.h,
                    child:controller.loading?Center(child: CircularProgressIndicator(color: AppColor.darkYellow,),)
                        : ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.cleaningServices?.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context,
                                RoutName.bookingPage,
                                arguments: controller.cleaningServices?[index].id
                            );
                          },
                          child: Card(
                            color: AppColor.background,
                            child: Container(
                              width: 340.w,
                              height: 110.h,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child:  Image.network(
                                      "${Apiconstants.baseurl}${controller.cleaningServices?[index].serviceImage}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 20.h),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.cleaningServices?[index].serviceName ?? 'No Service',
                                          style: AppStyle.subHeadline
                                              .copyWith(color: AppColor.black),
                                        ),
                                        Text(
                                          '\$${controller.cleaningServices?[index].price}',
                                          style: AppStyle.body2book
                                              .copyWith(color: AppColor.black),
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: Color(0xFFFFC107),
                                            ),
                                            Text(
                                              controller.cleaningServices?[index].rating ?? 'No Rating',
                                              style: AppStyle.body2book
                                                  .copyWith(color: AppColor.black),
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Recommended",
                        style: AppStyle.headline.copyWith(color: AppColor.black)),
                  ),
                  SizedBox(height: 10.h,),
                  Container(
                    height: 200.h,
                    child:controller.loading?Center(child: CircularProgressIndicator(color: AppColor.darkYellow,),)
                        :
                    ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return Card(
                          color: AppColor.background,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context,
                                  RoutName.bookingPage,
                                  arguments: controller.recommentedServices?[index].id
                              );
                            },
                            child: Container(
                              width: 142.w,
                              height: 181.h,
                              child: Column(
                                children: [
                                  Image.network(
                                    "${Apiconstants.baseurl}${controller.recommentedServices?[index].serviceImage}",
                                    width: 142.w,
                                    height: 126.h,
                                    fit: BoxFit.cover,
                                  ),
                                  Text(
                                    controller.recommentedServices?[index].serviceName ?? 'No Service',
                                    style: AppStyle.subHeadline
                                        .copyWith(color: AppColor.black),
                                  ),
                                  Text(
                                    '\$ ${controller.recommentedServices?[index].price ?? 'No Price'}',
                                    style: AppStyle.body2book
                                        .copyWith(color: AppColor.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
  GestureDetector buildGestureDetector(Icon icon,String text) {
    return GestureDetector(
              onTap: () {
              },
              child: Row(
                children: [
                  icon,
                   SizedBox(width: 10.h),
                  Text(
                    text,
                    style: AppStyle.bodyBook.copyWith(color: AppColor.black),
                  ),
                ],
              ),
            );
  }
}
