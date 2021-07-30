import 'package:flutter/material.dart';
import 'package:flutter_application_appmonitering/NavDrawer/Drawer.dart';
import 'package:flutter_application_appmonitering/services/authenications_services/auth_services.dart';



import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthServices>(context);
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
            IconButton(
              icon: Icon(Icons.logout_outlined),
              onPressed: () async => await loginProvider.logout(),
            )
          ],
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
                                '07: 50 AM - Friday, 10 Feb 2021',
                                style: GoogleFonts.lato(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                )
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Very good',
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
                                    '10',
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
                                    '15',
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
                                    '~ 5',
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
                                  'pH',
                                  style: GoogleFonts.lato(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    )
                                  ),
                                  SizedBox(width: 10,),
                                  Text(
                                    '~ 5',
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
                                  'pH',
                                  style: GoogleFonts.lato(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    )
                                  ),
                                  SizedBox(width: 10,),
                                  Text(
                                    '~ 5',
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
                            ]
                          ),
                        ),
                      ]
                    ),
                  ],
                )
              ),
            ]
          ),
        ),
         bottomNavigationBar: BottomNavigationBar(
          items: [ 
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
              backgroundColor: Colors.red
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
              backgroundColor: Colors.red
            ),
           ],
        ),
    );
  }

}