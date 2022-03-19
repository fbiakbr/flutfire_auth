import 'package:flutter/material.dart';
import 'package:flutter_firebase/home.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                'images/welcome.svg',
                height: 150,
              ),
              // make sign out button
              Container(
                margin: EdgeInsets.only(top: 20),
                child: RaisedButton(
                  color: Colors.indigo,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () async {
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
                                  'Signing out...',
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
                    await Future.delayed(Duration(seconds: 1));
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ),
                    );
                    FirebaseAuth.instance.signOut();
                  },
                  child: Text('Sign Out', style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
