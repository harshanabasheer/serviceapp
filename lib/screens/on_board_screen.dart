import 'package:flutter/material.dart';
import 'package:serviceapp/screens/intro_1.dart';
import 'package:serviceapp/screens/intro_2.dart';
import 'package:serviceapp/screens/intro_3.dart';


class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {

  final PageController _pageController = PageController();
  List<Widget>  ? pages;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     pages=[
      Intro1(controller: _pageController),
      Intro2(controller: _pageController,),
      Intro3(controller:  _pageController,)
    ];

  }

  @override
  Widget build(BuildContext context) {
    return
       PageView.builder(
         itemCount: pages?.length,
        controller: _pageController,
        itemBuilder: (context, index) {
          return pages![index];

        },
      );
  }
}
