import 'package:flutter/material.dart';
import 'package:teste_gb/bloc/bloc_provider.dart';
import 'package:teste_gb/bloc/feed_bloc.dart';
import 'package:teste_gb/screens/auth_screen.dart';
import 'package:teste_gb/screens/feed_screen.dart';
import 'package:teste_gb/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return BlocProvider<FeedBloc>(
      bloc: FeedBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen(),
      ),
    );
  }


}
