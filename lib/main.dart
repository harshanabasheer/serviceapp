import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:serviceapp/controller/address_controller.dart';
import 'package:serviceapp/controller/booking_controller.dart';
import 'package:serviceapp/controller/home_controller.dart';
import 'package:serviceapp/controller/payment_controller.dart';
import 'package:serviceapp/controller/profile_controller.dart';
import 'package:serviceapp/controller/rout_controller.dart';
import 'package:serviceapp/routes/rout_name.dart';
import 'package:serviceapp/routes/routing.dart';
import 'package:serviceapp/screens/bottombar.dart';
import 'controller/auth_controller.dart';
import 'controller/bottom_bar_controller.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => AuthController()),
      ChangeNotifierProvider(create: (_) =>AddressController ()),
      ChangeNotifierProvider(create: (_) =>BookingController ()),
      ChangeNotifierProvider(create: (_) =>HomeController ()),
      ChangeNotifierProvider(create: (_) =>PaymentController ()),
      ChangeNotifierProvider(create: (_) =>ProfileController ()),
      ChangeNotifierProvider(create: (_) =>RoutController ()),
      ChangeNotifierProvider(create: (_) => BottomBarController()),
    ],
     child: const MyApp(),
    ));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(414,896),

      builder: (context,child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            fontFamily: 'CircularStd',
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: Routing.generateRoute,
          initialRoute: RoutName.onBoardingPage,
          // home: BottomBar(),
        );
      }
    );
  }
}

