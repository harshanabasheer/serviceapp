import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:serviceapp/controller/profile_controller.dart';
import 'package:serviceapp/services/preference_services.dart';
import '../routes/rout_name.dart';
import '../utils/constants/api_constants.dart';
import '../utils/constants/app_color.dart';
import '../utils/constants/text_styles.dart';
import '../widget/button.dart';

class ProfilePage extends StatefulWidget {

  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void initState() {
      Provider.of<ProfileController>(context, listen: false)
          .getOneUserController(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ProfileController>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text("My Profile"),
        actions: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: AppColor.darkYellow,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RoutName.updatePage,);
              },
              child: Icon(
                Icons.edit,
                color: AppColor.black,
                size: 20,
              ),
            ),
          ),
        ],
      ),
      body: controller.loading
          ? Center(
              child: CircularProgressIndicator(
                color: AppColor.darkYellow,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child:controller.oneUser?.photo ==null? Image.asset("assets/images/profie.jpeg"):
                      Image.network(
                        "${Apiconstants.baseurl}${controller.oneUser?.photo}",),

                    ),
                  ),
                  SizedBox(height: 30.h),
                  buildProfileItem(
                    'Name',
                    controller.oneUser?.name ?? 'No Name',
                  ),
                  buildProfileItem(
                      'Email', controller.oneUser?.email ?? 'No email'),
                  buildProfileItem(
                      'Phone No', controller.oneUser?.phone ?? 'No phone'),
                  SizedBox(
                    height: 30.h,
                  ),
                  CustomButton(
                    text: "Log Out",
                    textStyle:
                        AppStyle.caption1.copyWith(color: AppColor.black),
                    functions: () {
                      LocalStorage.clear();
                      Navigator.pushNamed(context, RoutName.loginPage);
                    },
                  ),
                ],
              ),
            ),
    );
  }

  Widget buildProfileItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppStyle.bodyBook.copyWith(color: AppColor.grey40),
        ),
        Text(
          value,
          style: AppStyle.bodyBook.copyWith(color: AppColor.black),
        ),
        Divider(
          color: Color(0xFFE4E7F1),
          thickness: 1,
          height: 30,
        ),
      ],
    );
  }
}
