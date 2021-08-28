import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_appmonitering/Models/user.dart';
import 'package:flutter_application_appmonitering/main.dart';
import 'package:flutter_application_appmonitering/services/authenications_services/firestore_service.dart';
import 'package:provider/provider.dart';

class InforUserList extends StatefulWidget {
  @override
  _InforUserListState createState() => _InforUserListState();
}

class _InforUserListState extends State<InforUserList> {

  final _formKey = GlobalKey<FormState>();

  // form values
  String _currentName;

  @override
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: FirestoreService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData userData = snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Update your profile.',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20.0),
                Container(
                  width: 400,
                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white70
                    ),
                  child: TextFormField(
                    initialValue: userData.displayName,
                    validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                ),
                SizedBox(height: 10.0),
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      await FirestoreService(uid: user.uid).updateUserData(
                  
                        _currentName ?? snapshot.data.displayName, 
                      
                      );
                      Navigator.pop(context);
                    }
                  }
                ),
              ],
            ),
          );
        } else {
          return Loading();
        }
      }
    );
  }
}