import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:companyattendence/resuable/roundedbutton.dart';
import 'package:companyattendence/resuable/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'attendencehistory/ShowAllEmplyeeAttendencehistory.dart';
import 'addemployee.dart';
import 'attendencehistory/employeeattendencehistory.dart';

class showallemployee extends StatefulWidget {
  const showallemployee({Key? key}) : super(key: key);

  @override
  State<showallemployee> createState() => _showallemployeeState();
}

class _showallemployeeState extends State<showallemployee> {
  @override
  Widget build(BuildContext context) {

    TextStyle textstyling = TextStyle(
        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(addingnewemployee());
          },
          child: Icon(
            Icons.add,
            size: 30,
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(top: 60.h),
          child: Column(children: [
            Center(child: Text("Attendence Screen")),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Employee")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    Utils().toastMessage("Data is not prasent in database");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: Colors.white,
                    ));
                  }
                  var doc = snapshot.data!.docs;
                  return ListView.builder(

                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, index) {
                      return Container(
                        margin: EdgeInsets.only(left: 20, right: 20,bottom: 20),
                        height: 260.h,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Column(

                            // mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  'Name = ' + snapshot.data!.docs[index]['name'],
                                  style: textstyling,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Center(
                                  child: Text(
                                'Id = ' + snapshot.data!.docs[index]['id'],
                                style: textstyling,
                              )),
                              SizedBox(
                                height: 5,
                              ),

                              Center(
                                  child: Text(
                                'City = ' + snapshot.data!.docs[index]['city'],
                                style: textstyling,
                              )),
                              SizedBox(
                                height: 5,
                              ),
                              Center(
                                  child: Text(
                                'password = ' +
                                    snapshot.data!.docs[index]['password'],
                                style: textstyling,
                              )),
                              SizedBox(
                                height: 5,
                              ),
                              Center(
                                  child: Text(
                                'phoneno = ' +
                                    snapshot.data!.docs[index]['phoneno'],
                                style: textstyling,
                              )),
                              SizedBox(
                                height: 5,
                              ),
                              Center(
                                  child: Text(
                                'cnic = ' + snapshot.data!.docs[index]['cnic'],
                                style: textstyling,
                              )),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 50.h,
                                width: 190.w,


                                child: RoundButton(
                                  title: 'Attendence History',
                                  onTap: () {
                                   print( doc[index].id);
                                    Get.to(showallemployeeattendence(doc[index].id));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        /*    ListTile(
                    title: Text(snapshot.data!.docs[index]['name']),
                    subtitle: Text(snapshot.data!.docs[index]['city']),
                  )*/
                      );
                    },
                  );
                },
              ),
            ),
          ]),
        ));
  }
}
