import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../model/category_model.dart';
import '../model/login_model.dart';
import '../model/user_model.dart';
import '../routes/rout_name.dart';
import '../services/api_services.dart';
import '../services/firebase_authentication_service.dart';
import '../services/preference_services.dart';
import '../widget/alert.dart';

class AuthController extends ChangeNotifier {
  bool obscureText = true;
  bool confirmText = true;
  String? validEmail;
  bool loading = false;
  UserModel ? user;
  bool resendTime = false;
  final ApiService apiService = ApiService();
  final FirebaseAuthentication firebaseService = FirebaseAuthentication();

  //password visibility
  void viewPassword() {
    obscureText = !obscureText;
    notifyListeners();
  }
  //confirmed visiblity
  void viewConfirmPassword() {
    confirmText = !confirmText;
    notifyListeners();
  }

//email validation
  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }

  //sign in
  void signIn(
      {required String password,
      required String email,
      required BuildContext context}) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        validEmail = validateEmail(email);
        if (validEmail != null) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(validEmail!)));
        } else {
          loading = true;
          notifyListeners();
          await apiService.signIn(email: email, password: password);

          Navigator.pushReplacementNamed(context, RoutName.bottomBarPage);
          loading = false;
          notifyListeners();
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('All field are required')));
      }
    } catch (e) {
      loading = false;
      notifyListeners();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
            ),
          ),
        );
      }
    }
  }

  void register({
    required String name,
    required String phone,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      if (name.isNotEmpty &&
          phone.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty) {
        var validEmail = validateEmail(email);
        if (validEmail != null) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(validEmail)));
        } else {
          loading = true;
          notifyListeners();
           user = await apiService.registerUser(
            name: name,
            phone: phone,
            email: email,
            password: password,
          );

          // Send OTP for phone number verification
          await FirebaseAuth.instance.verifyPhoneNumber(
            verificationCompleted: (PhoneAuthCredential credential) {},
            verificationFailed: (FirebaseAuthException ex) {},
            codeSent: (String verificationId, int? resendToken) {
              Navigator.pushNamed(context, RoutName.otpPage,
                  arguments:verificationId,
              );
             resendTime = true;
              notifyListeners();
            },
            codeAutoRetrievalTimeout: (String verificationId) {

              resendTime = false;
              notifyListeners();

            },
            phoneNumber: "+91$phone",
            timeout: Duration(seconds: 30)
          );
          loading = false;
          resendTime = false;
          notifyListeners();
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('All fields are required')));
      }
    } catch (e) {
      resendTime = false;
      loading = false;
      notifyListeners();
      print(e);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
            ),
          ),
        );
      }
    }
  }

  Future<void> verifyOTPAndSignIn(BuildContext context,String verificationId,String controller) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId:verificationId,
        smsCode:controller,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      _showConfirmationDialog(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );

    }
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlert(
            image: 'assets/images/security.png',
            tex1: "Account Created",
            text2: "Your account has been successfully created!");
      },
    );
  }

  Future<void> resendOTP(String phone, BuildContext context) async {
    try {
      resendTime = true;
      notifyListeners();
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91$phone",
        verificationCompleted: (PhoneAuthCredential credential) {
        },
        verificationFailed: (FirebaseAuthException ex) {},
        codeSent: (String verificationId, int? resendToken) {
          resendTime = true;
          notifyListeners();
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          resendTime = false;
          notifyListeners();

        },
      );
      resendTime = false;
      notifyListeners();
    } catch (e) {
      resendTime = false;
      notifyListeners();
      print(e);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
            ),
          ),
        );
      }
    }
  }

//reset password
  void restPassword(
      {required String password,
        required String email,
        required BuildContext context}) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        validEmail = validateEmail(email);
        if (validEmail != null) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(validEmail!)));
        } else {
          loading = true;
          notifyListeners();
          await apiService.forgotPassword(email: email, password: password);
          _showConfirmationDialog(context);
          loading = false;
          notifyListeners();
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('All field are required')));
      }
    } catch (e) {
      loading = false;
      notifyListeners();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
            ),
          ),
        );
      }
    }
  }









// void otpSend({
//     required String email,
//     required BuildContext context,
//   }) async {
//     print("hyee");
//     print(email);
//     try {
//       if (
//           email.isNotEmpty
//         ) {
//         var validEmail = validateEmail(email);
//         if (validEmail != null) {
//           ScaffoldMessenger.of(context)
//               .showSnackBar(SnackBar(content: Text(validEmail)));
//         } else {
//           loading = true;
//           notifyListeners();
//           await apiService.sendOtp(
//             context: context,
//             email: email,
//           );
//           Navigator.pushNamed(context, RoutName.otpPage);
//           loading = false;
//           notifyListeners();
//         }
//       } else {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text('All fields are required')));
//       }
//     } catch (e) {
//       loading = false;
//       notifyListeners();
//       if (context.mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               e.toString(),
//             ),
//           ),
//         );
//       }
//     }
//   }
}
