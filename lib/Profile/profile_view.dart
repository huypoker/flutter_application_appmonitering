import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_appmonitering/services/authenications_services/auth_services.dart';
import 'package:flutter_application_appmonitering/services/authenications_services/firestore_service.dart';
import 'package:provider/provider.dart';

import 'inforuser_list.dart';


class ProfileView extends StatefulWidget {

  @override
  State<ProfileView> createState() => _ProfileViewState();
}


class _ProfileViewState extends State<ProfileView> {
  final AuthServices _auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: FirestoreService().ManagerInforUser,
      initialData: null,
      child: Scaffold(
       backgroundColor: Colors.white,
       appBar: AppBar(
         title: Text('Profile'),
         centerTitle: true,
         backgroundColor: Colors.blue,
         elevation: 0.0,
       ),
       body: InforUserList(),
      ),
    );
  }
}