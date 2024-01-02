import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../controller/home_controller.dart';
import '../routes/rout_name.dart';
import '../utils/constants/api_constants.dart';
import '../utils/constants/app_color.dart';
import '../utils/constants/text_styles.dart';

class ServiceDetail extends StatefulWidget {


  final  int  categoryId;
  const ServiceDetail({super.key, required this.categoryId});

  @override
  State<ServiceDetail> createState() => _ServiceDetailState();
}

class _ServiceDetailState extends State<ServiceDetail> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeController>(context,listen: false).getAllServiceController(context, widget.categoryId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final controller = context.watch<HomeController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Ac Repaire',style: AppStyle.title3.copyWith(color: AppColor.black)),
      ),
      body: controller.loading?Center(child: CircularProgressIndicator(color: AppColor.darkYellow,),)
          :
      controller.services == null ?
      Center(child: Text('No data'),)
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 374.w,
              height: 44.h,
              decoration: ShapeDecoration(
                color: AppColor.grey10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Row(
                children: [
                  SizedBox(width: 16),
                  Icon(Icons.search),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 2.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: controller.services?.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {

                    Navigator.pushNamed(
                        context,
                        RoutName.bookingPage,
                        arguments: controller.services?[index].id
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(
                        "${Apiconstants.baseurl}${controller.services?[index].serviceImage}",
                        width: 177.w,
                        height: 146.h,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        controller.services?[index].serviceName ?? 'No Service',
                        style: AppStyle.subHeadline.copyWith(color: AppColor.black),
                      ),
                      Text(
                        controller.services?[index].price ?? 'No Price',
                        style: AppStyle.body2book.copyWith(color: AppColor.black),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
