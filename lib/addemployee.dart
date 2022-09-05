import 'dart:io';

import 'package:companyattendence/resuabletextfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class addingnewemployee extends StatefulWidget {
  const addingnewemployee({Key? key}) : super(key: key);

  @override
  State<addingnewemployee> createState() => _addingnewemployeeState();
}

String? profilepic;
final TextEditingController UserNameController = TextEditingController();
final TextEditingController Emailcontroller = TextEditingController();
final TextEditingController PasswordController = TextEditingController();
final TextEditingController ConformPasswordController = TextEditingController();

class _addingnewemployeeState extends State<addingnewemployee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),*/
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 40),
          padding: EdgeInsets.symmetric(horizontal: 40),
         // height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              imageProfile(),
              SizedBox(height: 20,),
              Text(
                "Add an Employee ",
                style: TextStyle(fontSize: 30, color: Colors.grey[700]),
              ),
              SizedBox(height: 20,),
                  textfield(
                    label: "Name",
                    controller: UserNameController,
                    obscureText: false,
                  ),
              SizedBox(height: 10,),
                  textfield(
                    label: "Email ",
                    controller: Emailcontroller,
                    obscureText: false,
                  ),
              textfield(
                label: "Password ",
                controller: Emailcontroller,
                obscureText: true,
              ),
              SizedBox(height: 10,),
                  textfield(
                      label: "Phone No",
                      obscureText: false,
                      controller: PasswordController),
              SizedBox(height: 10,),
                  textfield(
                      label: "Cnic ",
                      obscureText: false,
                      controller: ConformPasswordController),
              SizedBox(height: 10,),

              textfield(
                  label: "City ",
                  obscureText: false,
                  controller: ConformPasswordController),

              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  onPrimary: Colors.white,
                  shadowColor: Colors.greenAccent,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  minimumSize: Size(320, 60), //////// HERE
                ),
                child: Text("Submit"),
              )
                  //inputFile(label: "Designation"),
                ],
              ),

          ),
        ),

    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: 80.0,
          backgroundImage: profilepic == null
              ? AssetImage("assets/profile.jpeg")
              : FileImage(File(profilepic!)) as ImageProvider,
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () async {
              final XFile? pickImage = await ImagePicker()
                  .pickImage(source: ImageSource.gallery, imageQuality: 50);
              if (pickImage != null) {
                setState(() {
                  profilepic = pickImage.path;
                });
              }
            },
            child: Icon(
              Icons.camera_alt,
              color: Colors.teal,
              size: 28.0,
            ),
          ),
        ),
      ]),
    );
  }
}
