import 'package:companyattendence/showallemployee.dart';
import 'package:companyattendence/todaysattendence.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
    runApp(
        DevicePreview(
          enabled: true,
          builder: (context)=>
           ScreenUtilInit(
             builder:(_,child) => GetMaterialApp(
    home: Mainhomescreen(),
    //userAvailable ? TodayScreen():adminAvailable?homepage():
    //Mainhomescreen(),
  ),
             designSize:const Size(393,826),
           ),
        )
      //MyApp( )
  );
}


