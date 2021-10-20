import 'dart:async';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_appmonitering/NavDrawer/Drawer.dart';
import 'package:flutter_application_appmonitering/Notifications/notification.dart';
import 'package:flutter_application_appmonitering/services/authenications_services/firestore_service.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_appmonitering/Models/AlertNotification.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>  with SingleTickerProviderStateMixin {
  final dbref = FirebaseDatabase.instance.reference();
  final db = FirestoreService();
  bool value = false;
  String status = 'No data';
  int currentTimestamp = 0;
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

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_statements
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
          actions: [
            StreamBuilder<List<AlertNotification>>(
              stream: FirestoreService().alertNotifications,
              builder: (context, snapshot) {

                if (snapshot.hasData) {
                  return Badge(
                    badgeContent: Text(snapshot.data.length.toString()),
                    padding: EdgeInsets.all(10),
                    child: IconButton(
                      icon: Icon(Icons.notification_important),
                      onPressed:() => {
                        Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Notifications())),
                      }
                    ),
                  );
                }

                  return Badge(
                    padding: EdgeInsets.all(10),
                    child: IconButton(
                      icon: Icon(Icons.notification_important),
                      onPressed:() => {
                        Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Notifications())),
                      }
                    ),
                  );
              }
            ),
          ],
        ),
        body: StreamBuilder(
          stream: dbref.child("ESP8266").onValue,
          builder: (context, snapshot) {
            if (snapshot.hasData && !snapshot.hasError && snapshot.data.snapshot.value != null) {
              var timestamp = snapshot.data.snapshot.value["currentTimestamp"] ?? 0;

              if (currentTimestamp < timestamp) {
                Data data = new Data(
                  temperature: snapshot.data.snapshot.value["Temperature"][timestamp.toString()],
                  ph: snapshot.data.snapshot.value["pH"][timestamp.toString()],
                  tds: snapshot.data.snapshot.value["TDS"][timestamp.toString()],
                );
  
                if (data.isNotNull()) {
                  if (data.temperature < 40 && data.ph >= 5.5 && data.ph <= 9 && data.tds < 500)
                    status = 'Good';
                  else {
                    final datetime = DateTime.now();
                    db.addNewNotification(AlertNotification(
                      title: 'Cảnh báo tại trạm 1',
                      subtitle: '${datetime.day}/${datetime.month}/${datetime.year} ${datetime.hour}:${datetime.minute} - nước thải tại trạm 1 không đạt chuẩn'
                    ));
                    status = 'Not good';
                  }
                  currentTimestamp = timestamp;
                }
              }
            }

            return Container(
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
                                    'Hang River',
                                    style: GoogleFonts.lato(
                                      fontSize: 35,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    )
                                  ),
                                  Text(
                                    'An Hai Bac, Son Tra District, Da Nang City',
                                    style: GoogleFonts.lato(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    )
                                  ),
                                  SizedBox(height: 1,),
                                  Text(
                                  _timeString.toString(),
                                  style: GoogleFonts.lato(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                )
                              ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    status,
                                    style: GoogleFonts.lato(
                                      fontSize: 45,
                                      fontWeight: FontWeight.bold,
                                      color: status == 'Good' ? Colors.green.shade700 : Colors.red,
                                    )
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/water_drop_black_24dp.svg',
                                         width: 30, 
                                         height: 30
                                        ),
                                      SizedBox(width: 10,),
                                      Text(
                                        'Quaility wastewater',
                                        style: GoogleFonts.lato(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        )
                                      ),
                                    ],
                                  ),
                                ]
                              ),
                            ],
                          ),
                        ),
                        Column(
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
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                              child: Column(
                                children: [
                                  Row(
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
                                            snapshot.data.snapshot.value == null ? 'No data' :
                                            snapshot.data.snapshot.value["Temperature"][currentTimestamp.toString()].toString() ?? 'No data',
                                            style: GoogleFonts.lato(
                                              fontSize: status == 'No data' ? 16 : 25,
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
                                          'pH',
                                          style: GoogleFonts.lato(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            )
                                          ),
                                          SizedBox(width: 10,),
                                          Text(
                                            snapshot.data.snapshot.value == null ? 'No data' :
                                            snapshot.data.snapshot.value["pH"][currentTimestamp.toString()].toString() ?? 'No data',
                                            style: GoogleFonts.lato(
                                              fontSize: status == 'No data' ? 16 : 25,
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
                                      SizedBox(
                                        child: Column(
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
                                              snapshot.data.snapshot.value == null ? 'No data' :
                                              snapshot.data.snapshot.value["TDS"][currentTimestamp.toString()].toString() ?? 'No data',
                                              style: GoogleFonts.lato(
                                                fontSize: status == 'No data' ? 16 : 25,
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
                                      ),
                                    ]  
                                  ),
                                  SizedBox(height: 15,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget> [
                                      
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
                                            snapshot.data.snapshot.value == null ? 'No data' :
                                            snapshot.data.snapshot.value["Speed"][currentTimestamp.toString()].toString() ?? 'No data',
                                            style: GoogleFonts.lato(
                                              fontSize: status == 'No data' ? 16 : 25,
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
                                          'Flow',
                                          style: GoogleFonts.lato(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            )
                                          ),
                                          SizedBox(width: 10,),
                                          Text(
                                            snapshot.data.snapshot.value == null ? 'No data' :
                                            snapshot.data.snapshot.value["Flow"][currentTimestamp.toString()].toString() ?? 'No data',
                                            style: GoogleFonts.lato(
                                              fontSize: status == 'No data' ? 16 : 25,
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
                                      
                                    ]
                                  ),
                                ],
                              ),
                            ),
                          ]
                        )
                      ],
                    )
                  ),
                ]
              ),
            );
          }
        ),   
    );
  }
  Future<void> readData() async {
    dbref.child("Data").once().then((DataSnapshot snapshot) {
      print(snapshot.value);
    });
  }
}

class Data {
  final int temperature;
  final int ph;
  final int tds;

  Data({
    this.temperature, 
    this.ph,
    this.tds,
  });

  bool isNotNull() => 
    this.temperature != null && 
    this.tds != null &&
    this.ph != null ? 
    true : false;
}