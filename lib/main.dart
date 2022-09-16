import 'package:companyattendence/preference.dart';
import 'package:companyattendence/showallemployee.dart';
import 'package:companyattendence/attendencescreen/todaysattendence.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'addemployee.dart';
import 'attendencehistory/employeeattendencehistory.dart';
import 'homepagescreen/homescreen.dart';
import 'homepagescreen/mainhomescreen.dart';
import 'loginemployee.dart';
import 'loginscreen/signupscreen.dart';
import 'model/user.dart';
import 'model/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Myprefferences.init();
  await Firebase.initializeApp();
  runApp(DevicePreview(
    enabled: true,
    builder: (context) => ScreenUtilInit(
      builder: (_, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthCheck(),
        localizationsDelegates: [MonthYearPickerLocalizations.delegate],
      ),
      designSize: const Size(393, 826),
    ),
  )
      //MyApp( )
      );
}

class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  _AuthCheckState createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  bool userAvailable = false;

  bool adminAvailable = false;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      if (Myprefferences.preference?.getString('stringkey') != null) {
        setState(() {
          User.employeeId =
              Myprefferences.preference!.getString('stringkey').toString();
          userAvailable = true;
        });
      }
    } catch (e) {
      print("hello not exist data");
      setState(() {
        userAvailable = false;
      });
    }

    try {
      if (Myprefferences.preference?.getString('email') != null) {
        setState(() {
          adminAvailable = true;
        });
      }
    } catch (e) {
      setState(() {
        print(e.toString());
        adminAvailable = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TodayScreen();
      //showallemployee();
      //TodayScreen();
      //SignupPage();
      //Mainhomescreen();
      //Loginemployee();
      // userAvailable
      //   ? TodayScreen()
      //   : adminAvailable
      //       ? homepage()
      //       : Mainhomescreen();
  }
}
