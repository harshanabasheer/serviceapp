import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../controller/home_controller.dart';
import '../routes/rout_name.dart';
import '../utils/constants/api_constants.dart';
import '../utils/constants/app_color.dart';
import '../utils/constants/text_styles.dart';

class SeeAllServices extends StatefulWidget {
  @override
  State<SeeAllServices> createState() => _SeeAllServicesState();
}

class _SeeAllServicesState extends State<SeeAllServices> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeController>(context,listen: false).getAllCategoriesController();
    });
    super.initState();
  }
  Widget build(BuildContext context) {

    final controller = context.watch<HomeController>();

    return Scaffold(
      appBar: AppBar(
        title: Text("All Services",style: AppStyle.title3.copyWith(color: AppColor.black)),
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
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: controller.categories?.data?.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: ()  {
                        Navigator.pushNamed(
                          context,
                          RoutName.serviceDetailPage,
                          arguments: controller.categories?.data![index].id
                        );
                      },
                      child: Card(
                        color: AppColor.grey10,
                        child: Container(
                          width: 111.w,
                          height: 108.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                "${Apiconstants.baseurl}${controller.categories?.data![index].categoryImage}",
                                width: 40.w,
                                height: 40.h,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                controller.categories?.data?[index].categoryName ?? 'No Category',
                                style: AppStyle.bodyBook.copyWith(color: AppColor.black),
                              ),
                            ],
                          ),
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

