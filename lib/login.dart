import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_firebase/welcome.dart';
import 'package:flutter_firebase/home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  static Future<User?> loginemailpass({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _email = TextEditingController();
    TextEditingController _password = TextEditingController();

    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 80),
            SvgPicture.asset(
              'images/1.svg',
              height: 150,
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                'Welcome Back!',
                style: GoogleFonts.poppins(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                    color: Colors.indigo),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                'Sign in to continue',
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.indigo),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40),
              width: 280,
              child: TextField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: 'Email',
                  suffixIcon: Icon(FontAwesomeIcons.envelope, size: 18),
                  labelStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.indigo),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              width: 280,
              child: TextField(
                controller: _password,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: 'Password',
                  suffixIcon: Icon(FontAwesomeIcons.key, size: 18),
                  labelStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.indigo),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              width: 280,
              height: 50,
              child: RaisedButton(
                color: Colors.indigo,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text('Sign In',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    )),
                onPressed: () async {
                  User? user = await loginemailpass(
                    email: _email.text,
                    password: _password.text,
                    context: context,
                  );
                  print(user);
                  if (user != null) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Row(
                            children: <Widget>[
                              CircularProgressIndicator(),
                              Container(
                                margin: EdgeInsets.only(left: 20),
                                child: Text(
                                  'Logging in...',
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.indigo),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                    await Future.delayed(Duration(seconds: 2));
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Welcome(),
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Row(
                            children: <Widget>[
                              CircularProgressIndicator(),
                              Container(
                                margin: EdgeInsets.only(left: 20),
                                child: Text(
                                  'Logging in...',
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.indigo),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                    await Future.delayed(Duration(seconds: 2));
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text(
                            'Login failed. Please try again.',
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.indigo),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('OK',
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.indigo)),
                              onPressed: () {
                                Navigator.pushReplacement(context, MaterialPageRoute(
                                  builder: (context) => Home(),
                                ));
                              }, 
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: FlatButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot Password?',
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.indigo),
                      ),
                    ),
                  ),
                  Container(
                    child: FlatButton(
                      onPressed: () {},
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.indigo),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
