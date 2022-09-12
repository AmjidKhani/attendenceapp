import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:companyattendence/loginscreen/signupscreen.dart';
import 'package:companyattendence/resuable/util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Firebase/firebasehelper.dart';
import '../Firebase/firebasehelper.dart';
import '../Firebase/firebasehelper.dart';
import '../homepagescreen/homescreen.dart';
import '../resuable/resuabletextfield.dart';
import '../resuable/roundedbutton.dart';

class LoginPage extends StatefulWidget {

  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  bool Loading = false;
  String? Designation;
  String? Password;
  String firstvalue = "Please Select Designation";
  final TextEditingController Email = TextEditingController();
  final TextEditingController password = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(top: 60.h),
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            imageProfile(),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "Welcome To Login ",
                      style:
                          TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "Login to your account",
                      style: TextStyle(fontSize: 15.sp, color: Colors.grey[700]),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: Column(
                    children: <Widget>[

                      textfield(
                        label: " Email",
                        controller: Email,
                        obscureText: false,
                      ),
                      textfield(
                        label: " Password",
                        controller: password,
                        obscureText: true,
                      ),


                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.h),
                  child: Container(
                      padding: EdgeInsets.only(top: 3.h, left: 3.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      child: RoundButton(
                        onTap: () async{
                          String mail = Email.text.trim();
                          String pass = password.text.trim();
                          setState(() {
                            Loading = true;
                          });
                             _auth
                              .signInWithEmailAndPassword(
                                  email: mail, password: pass)
                              .then((value) async{


                            SharedPreferences prefss=await SharedPreferences.getInstance();
                            prefss.setString('email', mail);
                            setState(() {
                              Loading = false;
                               Get.to(homepage());
                            });
                          }).onError((error, stackTrace) {
                            Utils().toastMessage(error.toString());
                            setState(() {
                              Loading = false;
                            });
                          });
                        },
                        title: 'Login',
                        loading: Loading,
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Don't have an Company?"),
                    GestureDetector(
                        onTap: () {
                          Get.to(SignupPage());
                        },
                        child: Text(
                          " Sign up",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18.sp,
                          ),
                        )),
                  ],
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
SignInUser(){

  final userlogin=     _auth
      .signInWithEmailAndPassword(
      email: Email.text, password: password.text)
      .then((value) {
    setState(() {
      Loading = false;
      // Get.to(homepage());
    });
  }).onError((error, stackTrace) {
    Utils().toastMessage(error.toString());
    setState(() {
      Loading = false;
    });
  });
}

  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: 80.0.r,
          backgroundImage: profilepic == null
              ? AssetImage("assets/profile.jpeg")
              : FileImage(File(profilepic!)) as ImageProvider,
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () async {
              final XFile? pickImage = await ImagePicker()
                  .pickImage(source: ImageSource.gallery, imageQuality: 50);
              if (pickImage != null) {
                setState(() {
                  profilepic = pickImage.path;
                });
              }
            },
            child: Icon(
              Icons.camera_alt,
              color: Colors.teal,
              size: 28.0,
            ),
          ),
        ),
      ]),
    );
  }
}
