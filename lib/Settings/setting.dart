import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_appmonitering/Homepage/Homescreen.dart';
import 'package:flutter_application_appmonitering/Login/Login.dart';
import 'package:google_fonts/google_fonts.dart';

class Settings extends StatefulWidget {

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool valNotify1 = true;
  bool valNotify2 = false;
  bool valNotify3 = false;

  onChangeFunction1 (bool newValue1) {
    setState((){
      valNotify1 = newValue1;
    });
  }

  onChangeFunction2 (bool newValue2) {
    setState((){
      valNotify2 = newValue2;
    });
  }

  onChangeFunction3 (bool newValue3) {
    setState((){
      valNotify3 = newValue3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings", style:  GoogleFonts.montserrat(
          fontSize:22)
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder:(context) => HomeScreen()));
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          )
        )
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            SizedBox(height:40),
            Row(
              children: [
                Icon(
                  Icons.notifications,
                  color: Colors. blue,
                ),
                SizedBox(width: 10),
                Text("Notifications", style: GoogleFonts.montserrat(
                  fontSize: 22, 
                  fontWeight: FontWeight.bold))
              ]
            ),
            Divider(height: 20, thickness: 1),
            SizedBox(height:10),
            buildNotificationOption("Pop up noti", valNotify1, onChangeFunction1),
            buildNotificationOption("Setting 2", valNotify2, onChangeFunction2),
            buildNotificationOption("Setting 3", valNotify3, onChangeFunction3),
            SizedBox(height: 50),
            Center(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  )
                ),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(context, MaterialPageRoute(builder:(context) => Login()));
                },
                child: Text("SIGN OUT", style: GoogleFonts.montserrat(
                  fontSize: 16,
                  letterSpacing: 2.2,
                  color: Colors.black
                )),
              )
            )
          ],
        )
      )
    );
  }

  Padding buildNotificationOption (String title,bool value, Function onChangeMethod){
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600]
            )),
            Transform.scale(
              scale: 0.7,
              child: CupertinoSwitch(
                activeColor: Colors.blue,
                trackColor: Colors.grey,
                value: value,
                onChanged: (bool newValue){
                  onChangeMethod(newValue);
                }
              )
            )
          ],
        )
    );
  }
}