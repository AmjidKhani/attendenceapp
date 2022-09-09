import 'package:companyattendence/loginscreen/signupscreen.dart';
import 'package:companyattendence/resuable/roundedbutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../loginemployee.dart';
import '../loginscreen/loginscreen.dart';
import '../loginscreen/signupscreen.dart';
import '../model/user.dart';
import '../todaysattendence.dart';

class Mainhomescreen extends StatefulWidget {
  const Mainhomescreen({Key? key}) : super(key: key);

  @override
  State<Mainhomescreen> createState() => _MainhomescreenState();
}

class _MainhomescreenState extends State<Mainhomescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendence Managment System",),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            RoundButton(title: 'Register a Company',
              onTap: () {
                Get.to(SignupPage());
              },),
            SizedBox(height: 30,),
            RoundButton(title: 'Login As an Admin',
              onTap: () {
                Get.to(
                    LoginPage()
                );
              },),
            SizedBox(height: 30,),
            RoundButton(title: 'Login As an Employee',
              onTap: () {
                Get.to(
                    Loginemployee()
                );
              },),
      ]
        ),
      ),
    );
  }
}

