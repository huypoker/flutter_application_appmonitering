import 'package:flutter/material.dart';
import 'package:flutter_application_appmonitering/Login/Login.dart';
import 'package:flutter_application_appmonitering/SignUp/Signup.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool isToggle = false;
  void toggleScreen(){
    setState(() {
      isToggle = !isToggle;

    });
  }
  @override
  Widget build(BuildContext context) {
    if (isToggle){
      return Signup(toggleScreen: toggleScreen);
    }else {
      return Login(toggleScreen:toggleScreen);
    }
  }
}