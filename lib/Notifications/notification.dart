import 'package:flutter/material.dart';
import 'package:flutter_application_appmonitering/Homepage/Homescreen.dart';
import 'package:google_fonts/google_fonts.dart';

class Notifications extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications',style: GoogleFonts.montserrat()),
        centerTitle: true,
        automaticallyImplyLeading: false,     
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
      body: ListView(
        children: <Widget>[
          Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  title: const Text('Canh bao tai tram 1'),
                  subtitle: Text('Ngay xx/yy/zz nuoc thai tai tram 1 ko dat chuan'),
                )
              ],
            ),
          ),
          SizedBox(height:3),
          Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  title: const Text('Canh bao tai tram 1'),
                  subtitle: Text('Ngay xx/yy/zz nuoc thai tai tram 1 ko dat chuan'),
                )
              ],
            ),
          ),
          Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  title: const Text('Canh bao tai tram 1'),
                  subtitle: Text('Ngay xx/yy/zz nuoc thai tai tram 1 ko dat chuan'),
                )
              ],
            ),
          ),
        ]
      ),
    );
  }
}