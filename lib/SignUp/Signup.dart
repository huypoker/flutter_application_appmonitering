import 'package:flutter/material.dart';
import 'package:flutter_application_appmonitering/services/authenications_services/auth_services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


class Signup extends StatefulWidget {
  final Function toggleScreen;

  const Signup({Key key, this.toggleScreen}) : super(key: key);
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController _emailController;
  TextEditingController _passwordController;
  final _formkey = GlobalKey<FormState>();
  var confirmPass ;
  bool _passwordVisible;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordVisible = false;
    
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  

  Widget build(BuildContext context) {
     // ignore: unnecessary_statements
    final loginProvider = Provider.of<AuthServices>(context);
    Size size = MediaQuery.of(context).size;
    double contWidth = size.width * 0.90;
    return Scaffold(
      body: Form(
        child: Container(
          decoration: BoxDecoration(image: DecorationImage(         
            image: Image.asset(
              "assets/images/Background.jpg").image, 
              fit: BoxFit.fill),
              ),
          child: Center(
            child: Form(
              key: _formkey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: Text("Sign Up",style: GoogleFonts.montserrat(
                        color: Color(0xFF6B6B6B),  
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
                        validator: ( val) {
                              confirmPass = val;
                              if (val.isEmpty) {
                                return "Please Enter Password";
                              } else if (val.length < 8) {
                                return "Password must be atleast 8 characters long";
                              } else {
                                return null;
                              }
                            },
                        controller: _passwordController,
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock, color: Colors.indigo),
                          border: InputBorder.none,
                          hintText: "Mật khẩu",
                          hintStyle: GoogleFonts.montserrat(color: Colors.grey),
                          suffixIcon: IconButton(
                            icon:Icon(
                              _passwordVisible
                              ?Icons.visibility:Icons.visibility_off,
                              color:Theme.of(context).primaryColorLight
                            ),
                            onPressed:(){
                              setState((){
                                _passwordVisible = !_passwordVisible;
                              });
                            }
                          )
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
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Please Re-Enter Password";
                          } else if (val.length < 8) {
                            return "Password must be atleast 8 characters long";
                          } else if (val != confirmPass) {
                            return "Password must be same as above";
                          } else {
                            return null;
                          }
                        },
                        obscureText: true,
                          decoration: InputDecoration(
                            icon: Icon(Icons.lock, color: Colors.indigo),
                            border: InputBorder.none,
                            hintText: "Retype-password",
                            hintStyle: GoogleFonts.montserrat(color: Colors.grey),
                            suffixIcon: IconButton(
                            icon:Icon(
                              _passwordVisible
                              ?Icons.visibility:Icons.visibility_off,
                              color:Theme.of(context).primaryColorLight
                            ),
                            onPressed:(){
                              setState((){
                                _passwordVisible = !_passwordVisible;
                              });
                            }
                          )
                            ),
                      ),
                    ),
                    SizedBox(height: 10),
                    MaterialButton(
                      onPressed: () async {
                        if (_formkey.currentState.validate()){
                          print("Email: ${_emailController.text}");
                          print("Password: ${_passwordController.text}");
                          await loginProvider.register(
                            _emailController.text.trim(),
                            _passwordController.text.trim(),
                          );
                        }
                      },
                      child: Container(
                        width: loginProvider.isLoading ? null: 300,
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
                            ? CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>
                                (Colors.white),
                            ) 
                            : Text(
                              "Confirm", 
                              style: GoogleFonts.montserrat(
                                fontSize: 20, 
                                color: Colors.white, 
                                fontWeight: FontWeight.bold),
                                ),
                          ),
                      ),
                    ),
                    SizedBox(height:10),
                    GestureDetector(
                      onTap: () => widget.toggleScreen(),
                      child: Text(
                        "Have an account",
                      style: GoogleFonts.montserrat(
                        color: Colors.red[800] ,
                        fontWeight: FontWeight.bold
                        ),
                      ),
                    ), 
                    SizedBox(height: 5),
                    if (loginProvider.errorMessage != null)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal:10, vertical: 5),
                      color: Colors.amberAccent,
                      child: ListTile(
                        title: Text(loginProvider.errorMessage),
                        leading: Icon(Icons.error),
                        trailing: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () => loginProvider.setMessage(null),
                        )
                      )
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}