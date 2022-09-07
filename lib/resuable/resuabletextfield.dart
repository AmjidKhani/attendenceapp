import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class textfield extends StatelessWidget {
  String? label;
 TextEditingController? controller;
 bool? obscureText;

  textfield(
      {
      this. label, this. obscureText=false ,  this .controller
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
                    fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                obscureText: obscureText??false,
                controller: controller,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
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
                height: 10,
              ),
            ],


  );
    }
  }

