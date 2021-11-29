import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_appmonitering/Login/FrostedGlassBox.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetScreen extends StatefulWidget {

  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  final _formkey = GlobalKey<FormState>();
  String _email;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double contWidth = size.width * 0.5;
    return Scaffold(
    body: SafeArea(
        child: Container(
          decoration: BoxDecoration(image: DecorationImage(         
            image: Image.asset(
              "assets/images/Background.jpg").image, 
              fit: BoxFit.fill),
              ),
          child: Center(
            child: FrostedGlassBox(
              width: contWidth,
              height: contWidth,
              child: Center(
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text("Reset Password",style: GoogleFonts.lato(
                          color: Color(0xFF6b8ae7), 
                          fontSize: 35, 
                          fontWeight: FontWeight.bold),
                          ),
                      ),
                        SizedBox(height: 15),
                        Container(
                          width: 300,
                         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white70
                            ),
                          child: TextFormField(
                            validator: (val) => 
                              val.isNotEmpty ? null : "Please enter email address",
                            decoration: InputDecoration(
                              icon: Icon(Icons.email, color: Colors.indigo),
                              border: InputBorder.none,
                              hintText: "Email",
                              hintStyle: GoogleFonts.lato(color: Colors.grey)
                              ),
                              onChanged: (value){
                                setState(() {
                                  _email = value;
                                }
                                );
                              },
                            ),    
                        ),
                        SizedBox(height: 10),
                        Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           MaterialButton(
                             child: Text('Send Request'),
                             onPressed: (){
                               auth.sendPasswordResetEmail(email: _email);
                               Navigator.of(context).pop();

                             },
                             color: Colors.redAccent,
                           )
                         ]
                        ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}