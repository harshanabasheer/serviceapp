import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serviceapp/screens/home_page.dart';
import 'package:serviceapp/screens/profile_page.dart';
import '../controller/bottom_bar_controller.dart';
import '../utils/constants/app_color.dart';
import 'all_booking_page.dart';

class BottomBar extends StatelessWidget {
  List<Widget> pages = [
    HomePage(),
    AllBookings(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<BottomBarController>();
    return Scaffold(
      body: pages[provider.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: provider.currentIndex,
        selectedItemColor: AppColor.darkYellow,
        unselectedItemColor: AppColor.black,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: AppColor.black),
            activeIcon: Icon(Icons.home, color: AppColor.darkYellow),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.my_library_books_outlined, color: AppColor.black),
            activeIcon: Icon(Icons.my_library_books_outlined, color: AppColor.darkYellow),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: AppColor.black,
            ),
            activeIcon: Icon(
              Icons.person,
              color: AppColor.darkYellow,
            ),
            label: 'Profile',
          ),
        ],
        onTap: (int index) {
          provider.setIndex(index);
        },
      ),
    );
  }
}
