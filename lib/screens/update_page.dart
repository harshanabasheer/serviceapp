import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:serviceapp/controller/profile_controller.dart';

import '../model/user_model.dart';
import '../utils/constants/app_color.dart';
import '../utils/constants/text_styles.dart';
import '../widget/button.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key,});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
   TextEditingController? _nameController;
   TextEditingController? _emailController;
   TextEditingController? _phoneController;

   UserModel ?  user;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
       user = Provider.of<ProfileController>(context, listen: false).oneUser;
       _nameController = TextEditingController(text: user?.name);
       _emailController = TextEditingController(text: user?.email);
       _phoneController = TextEditingController(text: user?.phone);
       setState(() {
       });
    });
    super.initState();

  }

  @override
  void dispose() {
    _nameController!.dispose();
    _emailController!.dispose();
    _phoneController!.dispose();
    // _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<ProfileController>(
                builder: (context,provider,_) {
                  return Container(
                    child: provider.imageFile == null
                        ? Row(
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/profie.jpeg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Consumer<ProfileController>(
                          builder: (context,provider,_) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(),
                              onPressed: ()  async{
                                //    _getFromGallery();

                               provider.showChoiceDialog(context);
                              },
                              child: Text("Upload Image"),
                            );
                          }
                        ),
                      ],
                    )
                        : Row(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Image.file(
                            provider.imageFile!,
                            width: 150,
                            height: 200,
                            //  fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Consumer<ProfileController>(
                          builder: (context,provider,_) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(),
                              onPressed: () {
                                //    _getFromGallery();
                                provider.showChoiceDialog(context);
                              },
                              child: Text("Upload Image"),
                            );
                          }
                        ),
                      ],
                    ),
                  );
                }
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone No'),
              ),
              // TextField(
              //   controller: _imageUrlController,
              //   decoration: InputDecoration(labelText: 'Photo URL'),
              // ),
              SizedBox(height: 16.0),
              CustomButton(
                text: "Save",
                textStyle:
                AppStyle.caption1.copyWith(color: AppColor.black),
                functions: ()async {

                  context.read<ProfileController>()
                      .updateUserController(
                      context,
                      user!.id!,
                      _nameController!.text,
                      _emailController!.text,
                      _phoneController!.text,



                  );
                  Navigator.pop(context);


                },
              ),
              // ElevatedButton(
              //   onPressed: () async{
              //     // Call the update user function from the controller
              //     context.read<ProfileController>()
              //         .updateUserController(
              //       context,
              //       user!.id!,
              //       _nameController!.text,
              //       _emailController!.text,
              //       _phoneController!.text,
              //      ''
              //     );
              //     Navigator.pop(context); // Close the EditProfilePage
              //   },
              //   child: Text("Save"),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
