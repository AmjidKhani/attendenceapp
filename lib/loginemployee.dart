import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:companyattendence/loginscreen/signupscreen.dart';
import 'package:companyattendence/resuable/util.dart';
import 'package:companyattendence/todaysattendence.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Firebase/firebasehelper.dart';
import '../Firebase/firebasehelper.dart';
import '../Firebase/firebasehelper.dart';
import 'homepagescreen/homescreen.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(top: 60),
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
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Login to your account",
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: <Widget>[
                      textfield(
                        label: " ID",
                        controller: idcontroller,
                        obscureText: false,
                      ),
                      textfield(
                        label: " Password",
                        controller: passwordcontroller,
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                        padding: EdgeInsets.only(top: 3, left: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: RoundButton(
                          onTap: () async {
                            FocusScope.of(context).unfocus();
                            String id = idcontroller.text.trim();
                            String password = passwordcontroller.text.trim();

                            if (id.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Employee id is still empty!"),
                              ));
                            } else if (password.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Password is still empty!"),
                              ));
                            } else {
                              QuerySnapshot snap = await FirebaseFirestore
                                  .instance
                                  .collection("Employee")
                                  .where('id', isEqualTo: id)
                                  .get();


                              try {
                                if (password == snap.docs[0]['password']) {
                                  sharedPreferences = await SharedPreferences.getInstance();

                                  sharedPreferences
                                      .setString('employeeId', id)
                                      .then((_) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TodayScreen()));
                                  });
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text("Password is not correct!"),
                                  ));
                                }
                              } catch (e) {
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
                        ))),

              ],
            ))
          ],
        ),
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: 80.0,
          // backgroundImage: profilepic == null
          //   ? AssetImage("assets/profile.jpeg")
          // : FileImage(File(profilepic!)) as ImageProvider,
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
