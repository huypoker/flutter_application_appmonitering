import 'package:flutter/material.dart';
import 'authenications_services/auth_services.dart';

class Provider extends InheritedWidget {
  final AuthServices auth;
  final db;

  Provider({Key key, Widget child, this.auth, this.db}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static Provider of(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<Provider>());
}