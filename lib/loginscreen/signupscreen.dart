import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:companyattendence/loginscreen/loginscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'dart:developer';

import 'package:image_picker/image_picker.dart';

import '../Firebase/firebasehelper.dart';
import '../resuable/resuabletextfield.dart';

class
SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

String? profilepic;

class _SignupPageState extends State<SignupPage> {
  String _selectedRole = "Select Role";
  String? valueselected;
  final items = ['Educational', 'IT', 'Hospital', 'Product'];
  final _rolelist = ["Educational", "IT", "Hospital", "Product"];
  String? _RoleSelect = "Select Role";
  final FirebaseAuth _auth = FirebaseAuth.instance;
   final FirebaseFirestore _db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final TextEditingController companyname = TextEditingController();
    final TextEditingController Emailcontroller = TextEditingController();
    final TextEditingController PasswordController = TextEditingController();
    final TextEditingController ConformPasswordController =
        TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 40.h),
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              imageProfile(),
              Column(
                children: <Widget>[

                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Create a Comapany, It's free ",
                    style: TextStyle(fontSize: 15.sp, color: Colors.grey[700]),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  DropdownButtonFormField(
                    items: _rolelist
                        .map((e) => DropdownMenuItem(
                              child: Text(e),
                              value: e,
                            ))
                        .toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _RoleSelect = value;
                      });
                    },
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black38,
                      size: 40,
                    ),
                    decoration: InputDecoration(
                        labelText: "Select Company Type",
                        border: UnderlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  textfield (label: "Company Name", controller: companyname,obscureText: false,),
                  textfield (label: "Email", controller: Emailcontroller,obscureText: false,),
                  textfield (
                      label: "Password",
                      obscureText: true,
                      controller: PasswordController),
                  textfield (
                      label: "Confirm Password ",
                      obscureText: true,
                      controller: ConformPasswordController),
                  //inputFile(label: "Designation"),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 3.h, left: 3.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.r),
                ),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60.h,
                  onPressed: () {

                    firebaseHelper(). signup(Emailcontroller.text ,PasswordController.text).then((value) async {
                      User? user =FirebaseAuth.instance.currentUser;
                      await FirebaseFirestore.instance.collection(
                          'Users').doc(user?.uid).
                      set({
                        'uid':user?.uid,
                        'company_name':companyname.text,
                        'email':Emailcontroller.text,
                        'password':PasswordController.text,
                        'Conform Password':ConformPasswordController.text,
                        'Role':_RoleSelect,
                      }).onError((error, stackTrace) {
                        print("Error$error");
                      });
                      //Get.to(LoginPage());
                    });
                    if(User== null){

                      Get.to(SignupPage());
                      print("Please Add the User ");

                    }
                    else {
                      Get.to(LoginPage());
                    }

                  },
                  color: Color(0xff0095FF),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Already have an Company pf8up ?"),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Text(
                        " Login",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.sp,
                        ),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  Future<String> signup(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Sign_Up In";
    } catch (e) {
      return e.toString();
    }
  }

  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: 80.0,
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
} //main close
// we will be creating a widget for text field


