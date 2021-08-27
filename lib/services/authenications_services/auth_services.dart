import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class AuthServices with ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  

  //GetUID
  
  //Get Current User
  

  //GET SIGN UP
  Future register (String email, String password) async {
    setLoading(true);
    try {
      UserCredential authResult = await firebaseAuth. 
      createUserWithEmailAndPassword(email: email, password: password);
      User user = authResult.user;
      setLoading(false);
      return user;
    } on SocketException{
      setMessage ("No internet, please connect to internet");
    }catch (e) {
      setLoading(false);
      setMessage(e.message);
    }
    notifyListeners();
  }

  //GET SIGN IN
  Future login (String email, String password) async {
    setLoading(true);
    try {
      UserCredential authResult = await firebaseAuth
      .signInWithEmailAndPassword(email: email, password: password);
      User user = authResult.user;
      setLoading(false);
      return user;
    } on SocketException{
      setMessage ("No internet, please connect to internet");
    }catch (e) {
      setLoading(false);
      setMessage(e.message);
    }
    notifyListeners();

    
  }

  Future logout() async {
    await FirebaseAuth.instance.signOut();
  }

  void setLoading(val){
    _isLoading = val;
    notifyListeners();
  }
  void setMessage(message){
    _errorMessage = message;
    notifyListeners();
  }


  Stream<User> get user => 
    firebaseAuth.authStateChanges().map((event) => event);

}

