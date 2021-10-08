import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_appmonitering/NavDrawer/Drawer.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>  with SingleTickerProviderStateMixin {
  final dbref = FirebaseDatabase.instance.reference();
  bool value = false;
  String _timeString;
 
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
  }

  void _getTime() {
    final String formattedDateTime =
        DateFormat('yyyy-MM-dd \n kk:mm:ss').format(DateTime.now()).toString();
    setState(() {
      _timeString = formattedDateTime;
    });
  }
  onUpdate() {
    setState(() {
      value = !value;
    });
  }
  static final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) { 
    return Scaffold(
        drawer : NavigationDrawer(),
        extendBodyBehindAppBar: true,
        appBar : AppBar(
          title: Text('Home Page',
            style: GoogleFonts.montserrat()
            ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
        
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(image: DecorationImage(         
                image: Image.asset(
                  "assets/images/Background.jpg").image, 
                  fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 100,),
                              Text(
                                'Station 1',
                                style: GoogleFonts.lato(
                                  fontSize: 35,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                )
                              ),
                              SizedBox(height: 1,),
                              Text(
                                _timeString.toString(),
                                style: GoogleFonts.lato(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                )
                              ),
                            ],
                          ),
                          StreamBuilder(
                            stream: dbref.child("ESP8266").onValue,
                            builder: (context, snapshot) {
                            if (snapshot.hasData &&
                            !snapshot.hasError &&
                            // ignore: unrelated_type_equality_checks
                            snapshot.data.snapshot.value["Temperature"]["data"].toString() != null) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data.snapshot.value["Temperature"]["data"] < 30 ? "not good" : "good",
                                    style: GoogleFonts.lato(
                                      fontSize: 45,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green.shade700,
                                    )
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/Giotnuoc.svg',
                                         width: 30, 
                                         height: 30
                                        ),
                                      SizedBox(width: 10,),
                                      Text(
                                        'Quaility water',
                                        style: GoogleFonts.lato(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black,
                                        )
                                      ),
                                    ],
                                  ),
                                ]
                              );
                             } else {}
                               return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ' Good',
                                    style: GoogleFonts.lato(
                                      fontSize: 45,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green.shade700,
                                    )
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/Giotnuoc.svg',
                                         width: 30, 
                                         height: 30
                                        ),
                                      SizedBox(width: 10,),
                                      Text(
                                        'Quaility water',
                                        style: GoogleFonts.lato(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black,
                                        )
                                      ),
                                    ],
                                  ),
                                ]
                              );
                            }
                          ),
                        ],
                      ),
                    ),
                    StreamBuilder(
                      stream: dbref.child("ESP8266").onValue,
                      builder: (context, snapshot) {
                          if (snapshot.hasData &&
                          !snapshot.hasError &&
                          snapshot.data.snapshot.value != null) {
                            return Column(
                            children: <Widget> [
                              Container(
                                margin:EdgeInsets.symmetric(vertical: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  )
                                )
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget> [
                                    Column(
                                      children:[
                                        Text(
                                        'Temp',
                                        style: GoogleFonts.lato(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          )
                                        ),
                                        SizedBox(width: 10,),
                                        Text(
                                          snapshot.data.snapshot.value["Temperature"]["data"].toString(),
                                          style: GoogleFonts.lato(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          )
                                        ),
                                        Text(
                                          '\u2103',
                                          style: GoogleFonts.lato(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          )
                                        ),
                                        Stack(
                                          children: [
                                            Container(
                                              height: 3,
                                              width: 50,
                                              color: Colors.white38,
                                            ),
                                            Container(
                                              height: 3,
                                              width: 50,
                                              color: Colors.greenAccent,
                                            ),
                                          ],
                                        ),
                                      ]
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                        'Warter speed',
                                        style: GoogleFonts.lato(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          )
                                        ),
                                        SizedBox(width: 10,),
                                        Text(
                                          snapshot.data.snapshot.value["Speed"]["data 4"].toString(),
                                          style: GoogleFonts.lato(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          )
                                        ),
                                        Text(
                                          'km/h',
                                          style: GoogleFonts.lato(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          )
                                        ),
                                        Stack(
                                          children: [
                                            Container(
                                              height: 3,
                                              width: 50,
                                              color: Colors.white38,
                                            ),
                                            Container(
                                              height: 3,
                                              width: 50,
                                              color: Colors.greenAccent,
                                            ),
                                          ],
                                        ),
                                      ]
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                        'pH',
                                        style: GoogleFonts.lato(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          )
                                        ),
                                        SizedBox(width: 10,),
                                        Text(
                                          snapshot.data.snapshot.value["pH"]["data 2"].toString(),
                                          style: GoogleFonts.lato(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          )
                                        ),
                                        Text(
                                          '',
                                          style: GoogleFonts.lato(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          )
                                        ),
                                        Stack(
                                          children: [
                                            Container(
                                              height: 3,
                                              width: 50,
                                              color: Colors.white38,
                                            ),
                                            Container(
                                              height: 3,
                                              width: 50,
                                              color: Colors.greenAccent,
                                            ),
                                          ],
                                        ),
                                      ]
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                        'Flow',
                                        style: GoogleFonts.lato(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          )
                                        ),
                                        SizedBox(width: 10,),
                                        Text(
                                          snapshot.data.snapshot.value["Flow"]["data 5"].toString(),
                                          style: GoogleFonts.lato(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          )
                                        ),
                                        Text(
                                          'm3/h',
                                          style: GoogleFonts.lato(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          )
                                        ),
                                        Stack(
                                          children: [
                                            Container(
                                              height: 3,
                                              width: 50,
                                              color: Colors.white38,
                                            ),
                                            Container(
                                              height: 3,
                                              width: 50,
                                              color: Colors.greenAccent,
                                            ),
                                          ],
                                        ),
                                      ]
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                        'TDS',
                                        style: GoogleFonts.lato(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          )
                                        ),
                                        SizedBox(width: 10,),
                                        Text(
                                          snapshot.data.snapshot.value["TDS"]["data 3"].toString(),
                                          style: GoogleFonts.lato(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          )
                                        ),
                                        Text(
                                          'mg/l',
                                          style: GoogleFonts.lato(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          )
                                        ),
                                        Stack(
                                          children: [
                                            Container(
                                              height: 3,
                                              width: 50,
                                              color: Colors.white38,
                                            ),
                                            Container(
                                              height: 3,
                                              width: 50,
                                              color: Colors.greenAccent,
                                            ),
                                          ],
                                        ),
                                      ]
                                    ),
                                  ]
                                ),
                              ),
                            ]
                          );
                        } else {}
                        return Container();
                      }
                    ),
                  ],
                )
              ),
            ]
          ),
        ),   
    );
  }
  Future<void> readData() async {
    dbref.child("ESP8266").once().then((DataSnapshot snapshot) {
      print(snapshot.value);
    });
  }
}