import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class textfield extends StatelessWidget {
  String? label;
 TextEditingController? controller;
 bool? obscureText;
 var textInputType;



  textfield(
      {
      this. label, this. obscureText=false ,  this .controller,required this.textInputType
      }

      );
@override
  Widget build(BuildContext context) {
    return
   Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                label.toString(),
                style: TextStyle(
                    fontSize: 15.sp, fontWeight: FontWeight.w400, color: Colors.black87),
              ),
              SizedBox(
                height: 5.h,
              ),
              TextField(
                obscureText: obscureText??false,
                controller: controller,
               keyboardType:textInputType,

                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 10.w),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: (Colors.grey[400]!)),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: (Colors.grey[400]!),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
            ],


  );
    }
  }

