import 'package:flutter/material.dart';
import 'package:flutter_application_appmonitering/services/Provider.dart';

class ProfileView extends StatefulWidget {

  @override
  State<ProfileView> createState() => _ProfileViewState();
}


class _ProfileViewState extends State<ProfileView> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: Provider.of(context).auth.getCurrentUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done){
                  return displayUserInformation(context, snapshot);
              } else {
                 return CircularProgressIndicator();
              }
            }
            )
          ],
        ),
      )
    );
  }

  Widget displayUserInformation (context, snapshot) {
    final user = snapshot.data;

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Name: ${user.displayName ?? 'Anonymous'}", style: TextStyle(fontSize:20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Email: ${user.email ?? 'Anonymous'}", style: TextStyle(fontSize:20),)
        ),
         Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Password: ${user.password ?? 'Anonymous'}", style: TextStyle(fontSize:20),)
        ),
        showSignOut(context,user.isAnonymous),
        RaisedButton(
          child: Text("Edit Infomation"),
          onPressed:() {
            _userEditBottomSheet(context);
          }
        )
      ]
    );
  }

  Widget showSignOut(context, bool isAnonymous) {
    if (isAnonymous == true) {
      return RaisedButton(
        child: Text("Sign in to save your data"),
        onPressed: (){
          Navigator.of(context).pushNamed('/convertUser');
        }
      );
    } else{
      return RaisedButton(
        child: Text("Sign out"),
        onPressed: () async {
          try{
            await Provider.of(context).auth.logout();
          } catch(e){
            print(e);
          }
        }
      );
    }
  }

  void _userEditBottomSheet (BuildContext context) {
    
  }
}