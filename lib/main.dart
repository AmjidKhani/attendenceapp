import 'package:companyattendence/showallemployee.dart';
import 'package:companyattendence/todaysattendence.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homepagescreen/homescreen.dart';
import 'homepagescreen/mainhomescreen.dart';
import 'model/user.dart';
import 'model/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  bool userAvailable = false;
  bool adminAvailable = false;
  bool Available = false;

  final sharedPreferences = await SharedPreferences.getInstance();
  final prefss = await SharedPreferences.getInstance();
  try {
    if (sharedPreferences.getString('employeeId') != null) {

        User.username = sharedPreferences.getString('employeeId')!;
        userAvailable = true;
      }
    }
   catch (e) {

    userAvailable = false;

  }
  try {
      if (prefss.getString('email') != null) {
        adminAvailable = true;
      }
    }
    catch (e) {
      print(e.toString());
      adminAvailable = false;
    }
    runApp(GetMaterialApp(
    home: userAvailable ? TodayScreen():adminAvailable?homepage():
    Mainhomescreen(),
  )
      //MyApp( )
  );
}

/*class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home:
      AuthCheck(),
    );
  }
}

class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
 // bool userAvailable = false;
  bool adminAvailable = false;
  bool Available = false;
  var email;
   //SharedPreferences? sharedPreferences;

  @override
  void initState() {
     _getAdmin();
 //   _getCurrentUser();
    // _getnotUser();
     // TODO: implement initState
    super.initState();
  }

  void _getAdmin() async {
    SharedPreferences prefss = await SharedPreferences.getInstance();
    try {
      if (prefss.getString('email') != null) {
        setState(() {
          //email=prefss.getString('email');
          adminAvailable = true;
        }
        );
      }
    }
    catch (e) {
      print(e.toString());
      adminAvailable = false;
    }
  }

  /*void _getCurrentUser() {
   // sharedPreferences = await SharedPreferences.getInstance();

    try {
      if (Widget.sharedPreferences.getString('employeeId') != null) {
        setState(() {
          User.username = Widget.sharedPreferences!.getString('employeeId')!;
          userAvailable = true;
        });
      }
    } catch (e) {

        userAvailable = false;

    }
  }

  void _getnotUser() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() async {
      User.username =await   sharedPreferences!.getString('employeeId')!;
      Future.delayed(Duration(seconds: 1));
      Available = false;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return
      //userAvailable
    //    ?
    TodayScreen();
       // :
    //adminAvailable ? homepage()
           // : Available
            //    ? CircularProgressIndicator()
    //            :
    Mainhomescreen();
  }
}*/
