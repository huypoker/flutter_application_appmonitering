import 'package:flutter/material.dart';
import 'package:flutter_application_appmonitering/Homepage/Homescreen.dart';
import 'package:flutter_application_appmonitering/Models/AlertNotification.dart';
import 'package:flutter_application_appmonitering/services/authenications_services/firestore_service.dart';
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
      body: StreamBuilder<List<AlertNotification>>(
        stream: FirestoreService().alertNotifications,
        builder: (context, snapshot) {

          if (snapshot.hasData) {

            final list = snapshot.data;

            return ListView.builder(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              itemCount: list.length,
              itemBuilder: (context, index) => 
              Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    ListTile(
                      title: Text(list[index].title),
                      subtitle: Text(list[index].subtitle),
                    )
                  ],
                ),
              ),
            );
          }

          return Container(
            child: Center(child: Text('No alerts')),
          );
        }
      ),
    );
  }
}