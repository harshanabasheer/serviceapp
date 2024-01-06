import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:serviceapp/routes/rout_name.dart';
import 'package:serviceapp/screens/forgot.dart';
import 'package:serviceapp/screens/home_page.dart';
import 'package:serviceapp/screens/login.dart';
import 'package:serviceapp/screens/otp_page.dart';
import 'package:serviceapp/screens/phone_page.dart';
import 'package:serviceapp/screens/rest_password.dart';
import 'package:serviceapp/screens/signup.dart';

import '../screens/add_card.dart';
import '../screens/adress_page.dart';
import '../screens/booking_page.dart';
import '../screens/checkout_page.dart';
import '../screens/on_board_screen.dart';
import '../screens/payment_page.dart';
import '../screens/service_detail.dart';
import '../screens/service_page.dart';
import '../screens/success_page.dart';

class Routing{
  static Route<dynamic> generateRoute(RouteSettings settings) {



    switch (settings.name) {
      case RoutName.onBoardingPage:
        return MaterialPageRoute(builder: (_) => const OnBoardScreen());
      case RoutName.loginPage:
        return MaterialPageRoute(builder: (_) => const Login());
      case RoutName.forgotPasswordPage:
        return MaterialPageRoute(builder: (_) => const ForgotPassword());
      case RoutName.restPasswordPage:
        return MaterialPageRoute(builder: (_) => RestPassword());
      case RoutName.signUpPage:
        return MaterialPageRoute(builder: (_) => SignUp());
      case RoutName.otpPage:
        return MaterialPageRoute(builder: (_) => OtpPage());
      case RoutName.homepage:
        return MaterialPageRoute(builder: (_) =>  HomePage());
      case RoutName.selectService:
        return MaterialPageRoute(builder: (_) => SeeAllServices());
      case RoutName.serviceDetailPage:
        final  id = settings.arguments as int;
        return MaterialPageRoute(builder: (_) => ServiceDetail(categoryId: id,));
      case RoutName.bookingPage:
        final  id = settings.arguments as int;
        return MaterialPageRoute(builder: (_) => BookingPage(serviceId: id,));
      case RoutName.checkoutPage:
        return MaterialPageRoute(builder: (_) => CheckoutPage());
      case RoutName.addressPage:
        return MaterialPageRoute(builder: (_) => AddressPage());
      case RoutName.phonePage:
        return MaterialPageRoute(builder: (_) => PhonePage());
      case RoutName.paymentPage:
        return MaterialPageRoute(builder: (_) => PaymentPage());
      case RoutName.addCard:
        return MaterialPageRoute(builder: (_) => AddCard());
      case RoutName.successPage:
        return MaterialPageRoute(builder: (_) => SuccessPage());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}