import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teste_gb/screens/auth_screen.dart';
import 'package:teste_gb/screens/login_screen.dart';
import 'package:teste_gb/style/theme.dart' as Style;
import 'package:teste_gb/util/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final Duration _duration = Duration(seconds: 5);
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
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        top: true,
        bottom: false,
        child: Container(
          height: _deviceSize.height,
          width: _deviceSize.width,
          padding: EdgeInsets.all(22),
          color: Style.MyColors.mainColor,
          child: _buildMyInfo()
        ),
      ),
    );
  }

  Widget _buildMyInfo() {
    return Center(
      child: Column(
        children: [
          Expanded(
            child: Container(padding: EdgeInsets.only(bottom: 24, top: 24),
              alignment: Alignment.topLeft,
              child: ClipRRect(
                child: Image.asset(Constants.MY_PICTURE),
              ),
              height: 400,
              width: 250,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  Constants.MY_FULL_NAME,
                  style: GoogleFonts.roboto(
                    color: Colors.black87,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  Constants.MY_EMAIL,
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
      ),
    );

  }

  void splashDone(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
