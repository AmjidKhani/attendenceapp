import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:companyattendence/loginscreen/signupscreen.dart';
import 'package:companyattendence/preference.dart';
import 'package:companyattendence/resuable/util.dart';
import 'package:companyattendence/attendencescreen/todaysattendence.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../resuable/resuabletextfield.dart';
import '../resuable/roundedbutton.dart';
class Loginemployee extends StatefulWidget {
  @override
  State<Loginemployee> createState() => _LoginemployeeState();
}
class _LoginemployeeState extends State<Loginemployee> {
  bool Loading = false;
  String? Designation;
  String? Password;
  String firstvalue = "Please Select Designation";
  final TextEditingController idcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  late SharedPreferences sharedPreferences;
  void cleartextfield() {
    idcontroller.clear();
    passwordcontroller.clear();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(top: 200.h),
        height: MediaQuery.of(context).size.height,
        width: double.infinity,

            child:
            Column(

              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "Welcome To Login ",
                      style:
                          TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      "Login to your account",
                      style: TextStyle(fontSize: 15.sp, color: Colors.grey[700]),
                    )
                  ],
                ),
                SizedBox(height:50.h ,),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      textfield(
                        label: " ID",
                        controller: idcontroller,
                        obscureText: false,
                        textInputType: TextInputType.emailAddress,
                      ),
                      textfield(
                        label: " Password",
                        controller: passwordcontroller,
                        obscureText: true,
                        textInputType: TextInputType.visiblePassword,
                      ),
                      // SizedBox(
                      //   height: 20.h,
                      // ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h,),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: Container(
                        padding: EdgeInsets.only(top: 3.h, left: 3.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                        child: RoundButton(
                          onTap: () async {
                            FocusScope.of(context).unfocus();
                            String id = idcontroller.text.trim();
                            String password = passwordcontroller.text.trim();

                            if (id.isEmpty) {
                              Utils().toastMessage("ID Must not be Empty");
                            } else if (password.isEmpty) {
                              Utils().toastMessage("Password Must not be Empty");
                            } else {
                              setState(() {
                                 Loading = true;
                              });

                              QuerySnapshot snap = await FirebaseFirestore
                                  .instance
                                  .collection("Employee")
                                  .where('id', isEqualTo: id)
                                  .get();
                              try {
                                if (password == snap.docs[0]['password']) {
                                  Myprefferences.saveString(id);
                                        setState(() {
                                          Loading = false;
                                        });
                                        Get.to(TodayScreen());
                                        cleartextfield();
                                      // });
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text("Password is not correct!"),
                                  ));
                                  setState(() {
                                    Loading = false;
                                  });
                                  cleartextfield();
                                }
                              } catch (e) {
                                setState(() {
                                  Loading = false;
                                });
                                String error = " ";

                                if (e.toString() ==
                                    "RangeError (index): Invalid value: Valid value range is empty: 0") {
                                  setState(() {
                                    error = "Employee id does not exist!";
                                  });
                                } else {
                                  setState(() {
                                    error = "Error occurred!";
                                  });
                                }

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(error),
                                ));
                              }
                            }
                          },
                          title: 'Submit',
                          loading: Loading,
                        ))),
              ],
            ))
    );
  }

}
