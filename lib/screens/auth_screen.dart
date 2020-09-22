import 'package:flutter/material.dart';
import 'package:teste_gb/bloc/authorization_bloc.dart';
import 'package:teste_gb/bloc/login_bloc.dart';
import 'package:teste_gb/screens/login_screen.dart';
import 'package:teste_gb/screens/home_screen.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  @override
  Widget build(BuildContext context) {

    authBloc.restoreSession();

    return buildLoginScreen();
  }

  Widget buildLoginScreen() {
    return StreamBuilder<bool>(
      stream: authBloc.isSessionValid,
      builder: (context, AsyncSnapshot<bool> snapshot){
        if (snapshot.hasData && snapshot.data){
          return HomeScreen();
        }
        return LoginScreen();
      },

    );
  }
}

