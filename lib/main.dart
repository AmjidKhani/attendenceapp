import 'package:companyattendence/showallemployee.dart';
import 'package:companyattendence/todaysattendence.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'addemployee.dart';
import 'loginemployee.dart';
import 'loginscreen/signupscreen.dart';
import 'mainhomescreen.dart';
import 'model/user.dart';
import 'model/user.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();


  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home:
      //TodayScreen(),
      AuthCheck(),
      //addingnewemployee(),
     // Loginemployee (),
      //SignupPage(),
    );
  }
}
class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  bool userAvailable = false;
  late SharedPreferences sharedPreferences;

 @override
  void initState() {
   _getCurrentUser();
    // TODO: implement initState
    super.initState();
  }
  void _getCurrentUser() async {
    sharedPreferences = await SharedPreferences.getInstance();

    try {
      if(sharedPreferences.getString('employeeId') != null) {
        setState(() {
        User.username= sharedPreferences.getString('employeeId')!;
          userAvailable = true;
        });
      }
    } catch(e) {
      setState(() {
        userAvailable = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return userAvailable ? TodayScreen() :Loginemployee() ;
  }
}

