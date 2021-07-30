

import 'package:flutter/material.dart';
import 'package:flutter_application_appmonitering/Homepage/Homescreen.dart';



class NavigationDrawer extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    final name = 'Sarah Abs';
    final email = 'sarah@abs.com';
    final urlImage = 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fbbbootstrap.com%2Fsnippets%2Fbootstrap-5-myprofile-90806631&psig=AOvVaw3vMKfUYZRsf8LEq43Nq261&ust=1624411401713000&source=images&cd=vfe&ved=0CAoQjRxqFwoTCPjWmpeKqvECFQAAAAAdAAAAABAD';
    return Drawer(
      child: Material(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            buildHeader(
              urlImage : urlImage,
              name : name,
              email : email,
              onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Container(
                )
              ))
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height:16),
                  buildMenuItem(
                    text: 'Homepage',
                    icon: Icons.home_outlined,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  const SizedBox(height:16),
                  buildMenuItem(
                    text: 'Item2',
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
    @required String urlImage,
    @required String name,
    @required String email,
    @required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
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
      case 5:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Container()
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
