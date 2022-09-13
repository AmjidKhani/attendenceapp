import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:companyattendence/loginscreen/loginscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';

import '../Firebase/firebasehelper.dart';
import '../resuable/resuabletextfield.dart';
import '../resuable/util.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

String? profilepic;
bool Loading=false;
class _SignupPageState extends State<SignupPage> {

  String? valueselected;
  final items = ['Educational', 'IT', 'Hospital', 'Product'];
  final _rolelist = ["Educational", "IT", "Hospital", "Product"];
  String? _RoleSelect = "Select Role";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final TextEditingController companyname = TextEditingController();
  final TextEditingController Emailcontroller = TextEditingController();
  final TextEditingController PasswordController = TextEditingController();
  final TextEditingController ConformPasswordController =
      TextEditingController();

  void cleartextfield() async{
    companyname.clear();
    Emailcontroller.clear();
    PasswordController.clear();
    PasswordController.clear();
    ConformPasswordController.clear();

  }

  @override
/*  void dispose() {
    companyname.dispose();
    Emailcontroller.dispose();
    PasswordController.dispose();
    ConformPasswordController.dispose();
    _RoleSelect;
    // TODO: implement dispose
    super.dispose();

  }*/
  @override
  Widget build(BuildContext context) {
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
                  textfield(
                    label: "Company Name",
                    controller: companyname,
                    obscureText: false,
                    textInputType: TextInputType.text,
                  ),
                  textfield(
                    label: "Email",
                    controller: Emailcontroller,
                    obscureText: false,
                    textInputType: TextInputType.text,
                  ),
                  textfield(
                    label: "Password",
                    obscureText: true,
                    controller: PasswordController,
                    textInputType: TextInputType.text,
                  ),
                  textfield(
                    label: "Confirm Password ",
                    obscureText: true,
                    controller: ConformPasswordController,
                    textInputType: TextInputType.text,
                  ),
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
                    if (Emailcontroller.text.isEmpty) {
                      Utils().toastMessage("Email Must not be Empty");

                    }
                    else if(PasswordController.text.isEmpty){
                      Utils().toastMessage("Password Must not be Empty");
                    }
                    else if(companyname.text.isEmpty){
                      Utils().toastMessage("CompanyName Must not be Empty");
                    }
                    else if(ConformPasswordController.text.isEmpty){
                      Utils().toastMessage("Conform Password Must not be Empty");
                    }
                    else if(_RoleSelect=="Select Role"){
                      Utils().toastMessage("Company type Must not be Empty");
                    }
                    else{

                      firebaseHelper()
                        .signup(Emailcontroller.text, PasswordController.text)
                        .then((value) async {

                      User? user = FirebaseAuth.instance.currentUser;
                      await FirebaseFirestore.instance
                          .collection('Users')
                          .doc(user?.uid)
                          .set({
                        'uid': user?.uid,
                        'company_name': companyname.text,
                        'email': Emailcontroller.text,
                        'password': PasswordController.text,
                        'Conform Password': ConformPasswordController.text,
                        'Role': _RoleSelect,
                      }).whenComplete(() => cleartextfield())
                          .onError((error, stackTrace) {
                        print("Error$error");
                      });

                      //Get.to(LoginPage());
                    });
                    if (User == null) {
                      Get.to(SignupPage());
                      print("Please Add the User ");
                    } else {
                      // setState(() {
                      //   Loading = false;
                      // });
                      Get.to(LoginPage());

                    }
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
                  Text("Already have an Company Loginup ?"),
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

  // Future<String> signup(String email, String password) async {
  //   try {
  //     await _auth.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //     return "Sign_Up In";
  //   } catch (e) {
  //     return e.toString();
  //   }
  // }

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

