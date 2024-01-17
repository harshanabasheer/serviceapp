
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:serviceapp/model/user_model.dart';
import '../services/api_services.dart';

class ProfileController extends ChangeNotifier{
  bool loading = false;
  final ApiService apiService = ApiService();
  UserModel ? oneUser;
  File ?imageFile;


  Future<void> getOneUserController(BuildContext context, int userId) async {
    try {
      loading = true;
      notifyListeners();
      oneUser = await apiService.getOneUser(userId);
      loading = false;
      notifyListeners();
    } catch (error) {
      loading = false;
      notifyListeners();
      print('Error occurred: $error');
    }
  }

  //update user
  // Future<void> updateUserController(
  //     BuildContext context, int userId, String name, String email, String phone, String photo) async {
  //   try {
  //     loading = true;
  //     notifyListeners();
  //    oneUser =  await apiService.updateUser(userId, name, email, phone, photo);
  //     loading = false;
  //     notifyListeners();
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('User profile updated successfully'),
  //         duration: Duration(seconds: 3),
  //       ),
  //     );
  //   } catch (error) {
  //     loading = false;
  //     notifyListeners();
  //     print('Error occurred: $error');
  //
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Failed to update user profile: $error'),
  //         duration: Duration(seconds: 3),
  //       ),
  //     );
  //   }
  // }
  Future<void> updateUserController(
      BuildContext context,
      int userId,
      String name,
      String email,
      String phone,

      ) async {
    try {
      loading = true;
      notifyListeners();

      print('image$imageFile');

      oneUser = await apiService.updateUser(userId, name, email, phone, imageFile!);

      loading = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User profile updated successfully'),
          duration: Duration(seconds: 3),
        ),
      );
    } catch (error) {
      loading = false;
      notifyListeners();
      print('Error occurred: $error');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update user profile: $error'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Choose from"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: const Text("Gallery"),
                    onTap: () {
                      _getFromGallery();
                      Navigator.pop(context);
                      //  _openGallery(context);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    child: const Text("Camera"),
                    onTap: () {
                      _getFromCamera();
                      Navigator.pop(context);
                      //  _opencamera(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _getFromGallery() async {
    print("hello");
    final picker = ImagePicker();
    try {

      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      if (pickedFile != null) {
          imageFile = File(pickedFile.path);
          notifyListeners();

      }
    } catch (e) {
      print("Error picking image from gallery: $e");
    }
  }

  _getFromCamera() async {
    print("hye");
    final picker = ImagePicker();
    try {
      print("harshana");
      final pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      print("jfhhhjhjhj");
      if (pickedFile != null) {
          imageFile = File(pickedFile.path);
          notifyListeners();
      }
    } catch (e) {
      // Handle the exception if something goes wrong
      print("Error picking image from camera: $e");
    }
  }

}