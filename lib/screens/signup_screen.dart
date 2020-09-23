import 'package:flutter/material.dart';
import 'package:teste_gb/bloc/login_bloc.dart';
import 'package:teste_gb/bloc/signup_bloc.dart';
import 'package:teste_gb/components/rounded_button.dart';
import 'package:teste_gb/screens/home_screen.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  LoginBloc bloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("signup"),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          children: [
            nameField(),
            emailField(bloc),
            passwordField(bloc),
            Container(margin: EdgeInsets.only(top: 25.0)),
            loadingIndicator(bloc),
            submitButton(bloc),

          ],
        ),
      ),
    );
  }
}

Widget loadingIndicator(LoginBloc bloc) => StreamBuilder<bool>(
  stream: bloc.loading,
  builder: (context, snap) {
    return Container(
      child: (snap.hasData && snap.data)
          ? CircularProgressIndicator()
          : null,
    );
  },
);

Widget emailField(LoginBloc bloc) => StreamBuilder<String>(
  stream: bloc.email,
  builder: (context, snap) {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      onChanged: bloc.changeEmail,
      decoration: InputDecoration(
          labelText: "Email address",
          hintText: "you@example.com",
          errorText: snap.error
      ),
    );
  },
);

Widget nameField(){
    return TextField(
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
          labelText: "name",
          hintText: "jose",
      ),
    );
  }


Widget passwordField(LoginBloc bloc) => StreamBuilder<String>(
    stream: bloc.password,
    builder:(context, snap) {
      return TextField(
        obscureText: true,
        onChanged: bloc.changePassword,
        decoration: InputDecoration(
            labelText: "Password",
            hintText: "Password",
            errorText: snap.error
        ),
      );
    }
);

Widget submitButton(LoginBloc bloc) => StreamBuilder<bool>(
  stream: bloc.submitValid,
  builder: (context, snap) {
    return RaisedButton(
      onPressed: () => Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => HomeScreen()), (Route<dynamic> route) => false),
      child: Text("Login", style: TextStyle(color: Colors.white),),
      color: Colors.blue,
    );
  },
);