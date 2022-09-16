import 'package:shared_preferences/shared_preferences.dart';

class Myprefferences{
  static  SharedPreferences? preference;
  static const stringkey="stringkey";
  static const stringemailkey="stringemailkey";

  static init()async {
    preference=await SharedPreferences.getInstance();
    return preference;
  }
  static saveString(String  n){

    return  preference?.setString("stringkey", n);

  }
  static String? fetchstring(){

    return preference!.getString("intkey");
  }
  static saveemailString(String  n){

    return  preference?.setString("stringemailkey", n);

  }
  static String? fetchemailstring(){

    return preference!.getString("stringemailkey");
  }



}