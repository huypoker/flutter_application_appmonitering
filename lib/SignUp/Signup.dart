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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:<Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(         
            image: Image.asset(
              "assets/images/Background.jpg").image, 
              fit: BoxFit.cover),
              ),
          child: Center(
            child: Center(
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 70),
                      child: Text("Sign Up",style: GoogleFonts.montserrat(
                        color: Color(0xFF315cde), 
                        fontSize: 35, 
                        fontWeight: FontWeight.bold),
                        ),
                    ),
                      SizedBox(height: 20),
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
                        onPressed: () async {
                          if (_formkey.currentState.validate()){
                            print("Email: ${_emailController.text}");
                            print("Password: ${_passwordController.text}");
                            await loginProvider.register(
                              _emailController.text.trim(),
                              _passwordController.text.trim()
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
                                "Xac nhan", 
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
        ],
      ),
    );
  }
}