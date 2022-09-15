import 'package:companyattendence/showallemployee.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../addemployee.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        body: Container(
          margin: EdgeInsets.only(top: 30.h),
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20.h,
            ),
            Text("Dashboard",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400),
                textAlign: TextAlign.start),
            SizedBox(
              height: 30.h,
            ),
            Container(

              child: Flexible(
                child: GridView.count(
                  mainAxisSpacing: 10.w,
                  primary: false,
                  crossAxisCount: 2,
                  children: [

                    GestureDetector(
                      onTap: () {
                        Get.to(showallemployee());
                      },
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[

                            Image.asset(
                              'assets/division.png',
                              fit: BoxFit.fill,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              "Employee",
                              style: TextStyle(
                                  fontSize: 20.sp, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    //approval screen

                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      )
    );
  }
}
