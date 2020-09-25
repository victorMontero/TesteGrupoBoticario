import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:teste_gb/screens/login_screen.dart';
import 'package:teste_gb/style/theme.dart' as Style;
import 'package:teste_gb/util/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final Duration _duration = Duration(seconds: 7);
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
          padding: EdgeInsets.only(left: 22, right: 22, top: 22),
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
            child: Container(padding: EdgeInsets.only(bottom: 0, top: 0),
              alignment: Alignment.topLeft,
              child: ClipRRect(
                child: Image.asset(Constants.MY_SPLASH),
              ),
              height: _deviceSize.height,
              width: _deviceSize.width,
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
