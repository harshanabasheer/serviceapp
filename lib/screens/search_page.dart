import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../controller/home_controller.dart';
import '../routes/rout_name.dart';
import '../utils/constants/api_constants.dart';
import '../utils/constants/app_color.dart';
import '../utils/constants/text_styles.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<HomeController>();

    return Scaffold(
      body: Column(
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
                  child: Row(
                    children: [
                      SizedBox(width: 16.w),
                      Icon(Icons.search),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          onChanged: (value) {
                            Provider.of<HomeController>(context, listen: false)
                                .searchServiceController(context, value);
                          },
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
            ],
          ),
          Expanded(
            child: _searchController.text.isEmpty  ?Text(""):
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 2.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: controller.searchService?.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                        context,
                        RoutName.bookingPage,
                        arguments: controller.searchService?[index]['id']
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(
                        "${Apiconstants.baseurl}${controller.searchService?[index]['ServiceImage']}",
                        width: 177.w,
                        height: 146.h,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 8),
                      Text(
                          controller.searchService?[index]['ServiceName'] ?? 'No Service',
                        style: AppStyle.subHeadline.copyWith(color: AppColor.black),
                      ),
                      Text(
                        '\$ ${controller.searchService?[index]['Price'] ?? 'No Price'}',
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
