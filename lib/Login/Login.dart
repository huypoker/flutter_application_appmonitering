import 'package:flutter/material.dart';
import 'package:flutter_application_appmonitering/ResetPassword/reset.dart';
import 'package:flutter_application_appmonitering/services/authenications_services/auth_services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'FrostedGlassBox.dart';

class Login extends StatefulWidget {
  final Function toggleScreen;

  const Login({Key key, this.toggleScreen}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController;
  TextEditingController _passwordController;
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthServices>(context);
    Size size = MediaQuery.of(context).size;
    double contWidth = size.width * 0.90;
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
                        child: Text("Đăng nhập",style: GoogleFonts.montserrat(
                          color: Color(0xFF6b8ae7), 
                          fontSize: 35, 
                          fontWeight: FontWeight.bold),
                          ),
                      ),
                        SizedBox(height: 5),
                        Container(
                          width: 300,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white70
                              ),
                          child: TextFormField(
                            controller: _emailController,
                            validator: (val) => 
                              val.isNotEmpty ? null : "Please enter email address",
                            decoration: InputDecoration(
                              icon: Icon(Icons.email, color: Colors.indigo) ,
                              border: InputBorder.none,
                              hintText: "Email",
                              hintStyle: GoogleFonts.montserrat(color: Colors.grey)
                              ),
                            ),    
                        ),
                        SizedBox(height: 10),
                          Container(  
                            width: 300,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white70),
                            child: TextFormField(
                              validator: (val) => 
                                val.length < 6 ? "Enter more than 6 char" : null,
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                icon: Icon(Icons.lock, color: Colors.indigo),
                                border: InputBorder.none,
                                hintText: "Mật khẩu",
                                hintStyle: GoogleFonts.montserrat(color: Colors.grey)
                                ),
                              ),  
                          ),
                        SizedBox(height: 10),
                        MaterialButton(
                          onPressed: () async{
                            if (_formkey.currentState.validate()) {
                              print("Email: ${_emailController.text}");
                              print("Password: ${_passwordController.text}");
                              await loginProvider.login(
                                _emailController.text.trim(),
                                _passwordController.text.trim()
                              );
                            }
                          },
                          child: Container(
                            width: loginProvider.isLoading ? null :  300,
                            height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                  gradient: new  LinearGradient(
                                colors: [Colors.purpleAccent, Colors.purpleAccent[400]]),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4,
                                  color: Colors.purpleAccent[400],
                                  offset: Offset(2,2)
                                )
                              ]  
                              ),
                            child: Center(
                              child: loginProvider.isLoading 
                                ? CircularProgressIndicator() 
                                : Text(
                                  "Login", 
                                  style: GoogleFonts.montserrat(
                                    fontSize: 20,
                                    color: Colors.white, 
                                    fontWeight: FontWeight.bold),
                                    ),
                              ),
                      ),
                        ),
                      SizedBox(height: 1),
                      Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         TextButton(onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ResetScreen())),
                          child: Text('Forgot Password?'))
                       ]
                      ), 
                      SizedBox(height:1),
                      GestureDetector(
                        onTap: () => widget.toggleScreen(),
                        child: Text(
                          "Tạo tài khoản mới",  
                        style: GoogleFonts.montserrat(
                          color: Colors.red[800] ,
                          fontWeight: FontWeight.bold
                          ),
                        ),
                      ), 
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