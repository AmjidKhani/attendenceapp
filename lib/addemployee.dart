import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:companyattendence/resuable/resuabletextfield.dart';
import 'package:companyattendence/resuable/roundedbutton.dart';
import 'package:companyattendence/showallemployee.dart';
import 'package:companyattendence/resuable/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class addingnewemployee extends StatefulWidget {
  const addingnewemployee({Key? key}) : super(key: key);

  @override
  State<addingnewemployee> createState() => _addingnewemployeeState();
}


bool loading = false;
final TextEditingController UserNameController = TextEditingController();
final TextEditingController idcontroller = TextEditingController();
final TextEditingController PasswordController = TextEditingController();
final TextEditingController phonenoController = TextEditingController();
final TextEditingController CnicController = TextEditingController();
final TextEditingController CityController = TextEditingController();

class _addingnewemployeeState extends State<addingnewemployee> {
  void cleartextfield() {
    UserNameController.clear();
    idcontroller.clear();
    PasswordController.clear();
    phonenoController.clear();
    CnicController.clear();
    CityController.clear();
  }

  @override
  // void dispose() {
  //   UserNameController.dispose();
  //   idcontroller.dispose();
  //   PasswordController.dispose();
  //   phonenoController.dispose();
  //   CnicController.dispose();
  //   CityController.dispose();
  //
  //   // TODO: implement dispose
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 40.h),
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          // height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              //  imageProfile(),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Add an Employee ",
                style: TextStyle(fontSize: 30.sp, color: Colors.grey[700]),
              ),
              SizedBox(
                height: 20.sp,
              ),
              textfield(
                label: "Name",
                controller: UserNameController,
                obscureText: false,
                textInputType: TextInputType.name,
              ),
              SizedBox(
                height: 10.h,
              ),
              textfield(
                label: "Id ",
                controller: idcontroller,
                obscureText: false,
                textInputType: TextInputType.text,
              ),
              textfield(
                label: "Password ",
                controller: PasswordController,
                obscureText: true,
                textInputType: TextInputType.text,
              ),
              SizedBox(
                height: 10.h,
              ),
              textfield(
                label: "Phone No",
                obscureText: false,
                controller: phonenoController,
                textInputType: TextInputType.phone,
              ),

              SizedBox(
                height: 10.h,
              ),
              textfield(
                label: "Cnic ",
                obscureText: false,
                controller: CnicController,
                textInputType: TextInputType.number,
              ),
              SizedBox(
                height: 10.h,
              ),

              textfield(
                label: "City ",
                obscureText: false,
                controller: CityController,
                textInputType: TextInputType.text,
              ),

              SizedBox(
                height: 20.h,
              ),

              RoundButton(
                title: 'Submit',
                onTap: () {
                  // setState(() {
                  //   loading = true;
                  // });
                  addEmplyee();
                },
              ),
              //inputFile(label: "Designation"),
            ],
          ),
        ),
      ),
    );
  }

  CollectionReference Employee =
      FirebaseFirestore.instance.collection("Employee");

  void addEmplyee() async {
    if (UserNameController.text.isEmpty) {
      Utils().toastMessage("Name Must not be Empty");
    } else if (idcontroller.text.isEmpty) {
      Utils().toastMessage("ID Must not be Empty");
    } else if (PasswordController.text.isEmpty) {
      Utils().toastMessage("Password Must not be Empty");
    } else if (phonenoController.text.isEmpty) {
      Utils().toastMessage("Phone_no Must not be Empty");
    } else if (CnicController.text.isEmpty) {
      Utils().toastMessage("Cnic Must not be Empty");
    } else if (CityController.text.isEmpty) {
      Utils().toastMessage("City Must not be Empty");
    } else {
      setState(() {
        loading = true;
      });
      await Employee.add({
        'name': UserNameController.text,
        'id': idcontroller.text,
        'password': PasswordController.text,
        'phoneno': phonenoController.text,
        'cnic': CnicController.text,
        'city': CityController.text
      }).then((value) {
        setState(() {
          loading = false;
        });
        Get.to(showallemployee());
        cleartextfield();
      }).onError((error, stackTrace) {
        setState(() {
          loading = false;
        });

        Utils().toastMessage(error.toString());
      });
    }
  }
}
