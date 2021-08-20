import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_appmonitering/Homepage/Homescreen.dart';

class VerifyScreen extends StatefulWidget {

  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}
class _VerifyScreenState extends State<VerifyScreen> {

  final auth = FirebaseAuth.instance;
  User user;
  Timer timer;

  @override
  void initState(){
    user = auth.currentUser;
    user.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 5), (timer){
      checkEmailVerification();
    });
    super.initState();
  }
  @override
  void dispose(){
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: auth != null 
      ? Center (
        child: Container(
          alignment: Alignment.center,
          child: Text(user.emailVerified
            ? "Email verified" 
            : "Email not verified"), 
        ),
      )
      : Text
    );
  }

  Future<void> checkEmailVerification() async{
    user = auth.currentUser;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }
}