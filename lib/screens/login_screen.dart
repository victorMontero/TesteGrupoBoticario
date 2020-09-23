import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teste_gb/bloc/login_bloc.dart';
import 'package:teste_gb/screens/home_screen.dart';
import 'package:teste_gb/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  LoginBloc bloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("login"),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          children: [
            emailField(bloc),
            passwordField(bloc),
            Container(margin: EdgeInsets.only(top: 25.0)),
            submitButton(bloc),
            loadingIndicator(bloc),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen())),
                child: Text("registre-se", style: GoogleFonts.roboto(color: Colors.black87, fontSize: 16),),
              ),
            )
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
