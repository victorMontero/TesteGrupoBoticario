import 'package:flutter/material.dart';
import 'package:teste_gb/bloc/bloc_provider.dart';
import 'package:teste_gb/bloc/feed_bloc.dart';
import 'package:teste_gb/screens/splash_screen.dart';
import 'package:teste_gb/util/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocProvider<FeedBloc>(
      bloc: FeedBloc(),
      child: MaterialApp(
        title: Constants.APP_NAME,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen(),
      ),
    );
  }


}
