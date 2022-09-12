import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:companyattendence/resuable/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'addemployee.dart';

class showallemployee extends StatefulWidget {
  const showallemployee({Key? key}) : super(key: key);

  @override
  State<showallemployee> createState() => _showallemployeeState();
}

class _showallemployeeState extends State<showallemployee> {
  @override
  Widget build(BuildContext context) {
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
        child:
        Column(
        children:[
Center(child: Text("Attendence Screen")),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(

            stream: FirebaseFirestore.instance.collection("Employee").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                Utils().toastMessage("Data is not prasent in database");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.white,
                ));
              }

              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, index) {
                  return Card(
                    elevation: 2,
                      color: Colors.white54,
                      child: ListTile(
                    title: Text(snapshot.data!.docs[index]['name']),
                    subtitle: Text(snapshot.data!.docs[index]['city']),
                  ));
                },
              );
            },
          ),
        ),
     ] ),
    )
    );
  }
}
