import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_appmonitering/Homepage/Homescreen.dart';
import 'package:flutter_application_appmonitering/Profile/profile_view.dart';
import 'package:flutter_application_appmonitering/Settings/setting.dart';



class NavigationDrawer extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  var currentUser = FirebaseAuth.instance.currentUser;
 

  @override
  Widget build(BuildContext context) {   
    final email = currentUser.email;
    return Drawer(
      child: Material(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            buildHeader(
              email : email,
              onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Container(
                )
              ))
            ),
            Container(
              padding: padding,
              child: Column(
                children:  [
                  const SizedBox(height:16),
                  buildMenuItem(
                    text: 'Homepage',
                    icon: Icons.home_outlined,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  const SizedBox(height:16),
                  buildMenuItem(
                    text: 'My account',
                    icon: Icons.people,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  const SizedBox(height:16),
                  buildMenuItem(
                    text: 'History',
                    icon: Icons.timelapse_outlined,
                    onClicked: () => selectedItem(context, 3),
                  ),
                  const SizedBox(height:16),
                  buildMenuItem(
                    text: 'Item4',
                    icon: Icons.people,
                    onClicked: () => selectedItem(context, 4),
                  ),
                  const SizedBox(height:24),
                  Divider(color: Colors.grey[600]),
                  const SizedBox(height:16),
                  buildMenuItem(
                    text: 'Settings',
                    icon: Icons.settings,
                    onClicked: () => selectedItem(context, 5),
                  ),
                  const SizedBox(height:16),
                  buildMenuItem(
                    text: 'Notifications',
                    icon: Icons.notification_important_outlined,
                    onClicked: () => selectedItem(context, 6),
                  ),
                  const SizedBox(height:16),
                  buildMenuItem(
                    text: 'FAQ',
                    icon: Icons.format_quote_outlined,
                    onClicked: () => selectedItem(context, 7),
                  ),
                  const SizedBox(height:16),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }


  Widget buildHeader({
    @required String email,
    @required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
    
                  const SizedBox(height:4),
                  Text(
                    email,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ],
              )
            ],
          ),
        ),
      );


 Widget buildMenuItem({
   @required String text, 
   @required IconData icon,
   VoidCallback onClicked,
   }) {
     final color = Colors.grey;
     final hoverColor = Colors.purple[300];

     return ListTile(
       leading: Icon(icon, color: color),
       title: Text(text, style: TextStyle(color: color)),
       hoverColor:hoverColor,
       onTap: onClicked,
     );
   }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ));
      break;
      case 1:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ProfileView(),
      ));
      break;
      case 2:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Container(),
      ));
      break;
      case 5:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Settings()
        ));
      break;
      case 7:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Container()
        ));
      break;
      
      
    }
  }

}
