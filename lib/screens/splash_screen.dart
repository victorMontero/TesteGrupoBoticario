import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teste_gb/screens/auth_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final Duration _duration = Duration(seconds: 55);
  Size _deviceSize;

  @override
  void initState(){
    Future.delayed(_duration, () => splashDone());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: false,
        child: Container(
          height: _deviceSize.height,
          width: _deviceSize.width,
          padding: EdgeInsets.all(22),
          color: Colors.green,
          child: _buildMyInfo()
        ),
      ),
    );
  }

  Widget _buildMyInfo() {
    return Column(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.topLeft,
            child: ClipRRect(
              child: Image.asset("assets/img/img_profile.png"),
            ),
            height: 400,
            width: 150,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Victor Montero',
                style: GoogleFonts.roboto(
                  color: Colors.black87,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                'victor.hfmontero@gmail.com',
                style: GoogleFonts.roboto(
                    color: Colors.black87,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        ),
      ],
    );

  }

  void splashDone(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AuthScreen()));
  }
}
