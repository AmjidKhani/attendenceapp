import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class RoundButton extends StatelessWidget {
  final String title ;
  final VoidCallback onTap ;
  final bool loading ;
  const RoundButton({Key? key ,
    required this.title,
    required this.onTap,
    this.loading = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(

        height: 60.h,
       // width: 400,
        decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(32.0.r)
        ),
        child: Center(child:
        loading ? CircularProgressIndicator(strokeWidth: 3.w,color: Colors.white,) :
        Text(title, style: TextStyle(color: Colors.white),),),
      ),
    );
  }
}