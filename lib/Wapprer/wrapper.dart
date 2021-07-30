import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_appmonitering/Authentication/authentication.dart';
import 'package:flutter_application_appmonitering/VerifyEmail/verifyemail.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user != null) {
      return VerifyScreen();
    }else{
      return Authentication();
    }
  }
}