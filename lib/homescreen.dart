import 'package:companyattendence/showallemployee.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'addemployee.dart';

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
          margin: EdgeInsets.only(top: 30),
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Text("Dashboard",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                textAlign: TextAlign.start),
            SizedBox(
              height: 30,
            ),
            Container(

              child: Flexible(
                child: GridView.count(
                  mainAxisSpacing: 10,
                  primary: false,
                  crossAxisCount: 2,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(showallemployee());
                      },
                      child: Card(
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                              'assets/division.png',
                              fit: BoxFit.fill,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Employee",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    //approval screen
                    GestureDetector(
                      onTap: () {
                        //  Get.to(attendencepage());
                      },
                      child: Card(
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                              'assets/approval.png',
                              fit: BoxFit.fill,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Attendence",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
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
