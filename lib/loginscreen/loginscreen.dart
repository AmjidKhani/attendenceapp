import 'dart:io';
import 'package:companyattendence/loginscreen/signupscreen.dart';
import 'package:companyattendence/preference.dart';
import 'package:companyattendence/resuable/util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../homepagescreen/homescreen.dart';
import '../resuable/resuabletextfield.dart';
import '../resuable/roundedbutton.dart';
import 'signupscreen.dart';
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

  void cleartextfield() {
    Email.clear();
    password.clear();
  }
  @override
  void dispose() {
    Email.dispose();
    password.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Container(
            margin: EdgeInsets.only(top: 150.h),
            height: MediaQuery
                .of(context)
                .size
                .height,
            width: double.infinity,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                      child: Column(
                       // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                "Welcome To Login ",
                                style: TextStyle(
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                "Login to your account",
                                style:
                                TextStyle(
                                    fontSize: 15.sp, color: Colors.grey[700]),
                              )
                            ],
                          ),
                          SizedBox(height: 29.h,),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40.w),
                            child: Column(
                              children: <Widget>[
                                textfield(
                                  label: " Email",
                                  controller: Email,
                                  obscureText: false,
                                  textInputType: TextInputType.emailAddress,
                                ),
                                textfield(
                                  label: " Password",
                                  controller: password,
                                  obscureText: true,
                                  textInputType: TextInputType.visiblePassword,
                                ),

                              ],
                            ),
                          ),
                          SizedBox(height: 30.h,),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40.h),
                            child: Container(
                                padding: EdgeInsets.only(top: 3.h, left: 3.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.r),
                                ),
                                child: RoundButton(
                                  onTap: () async {
                                    String mail = Email.text.trim();
                                    String pass = password.text.trim();

                                    if (Email.text.isEmpty) {
                                      Utils().toastMessage(
                                          "Email Must not be Empty");
                                    } else if (password.text.isEmpty) {
                                      Utils().toastMessage(
                                          "Password Must not be Empty");
                                    } else {
                                      setState(() {
                                        Loading = true;
                                      });
                                      _auth
                                          .signInWithEmailAndPassword(
                                          email: mail, password: pass)
                                          .then((value) async {
                                        Myprefferences.preference
                                        // SharedPreferences prefss =
                                        // await SharedPreferences.getInstance();
                                        ?.setString('email', mail);
                                        setState(() {
                                          Loading = false;
                                          Get.to(const homepage());
                                          cleartextfield();
                                        });
                                      }).onError((error, stackTrace) {
                                        Utils().toastMessage(error.toString());
                                        setState(() {
                                          Loading = false;
                                          cleartextfield();
                                        });
                                      });
                                    }
                                  },
                                  title: 'Login',
                                  loading: Loading,
                                )),
                          ),
                          SizedBox(height: 30.h,),
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
                      )
                  )
                ]
            )
        )
    );
  }

}


