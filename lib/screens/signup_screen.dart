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
  SignupBloc bloc = SignupBloc();

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
            nameField(bloc),
            emailField(bloc),
            passwordField(bloc),
            Container(margin: EdgeInsets.only(top: 25.0)),
            loadingIndicator(bloc),
            MyRoundedButton(
              text: 'entrar',
                textColor: Colors.white,
                onTap: () => Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) => HomeScreen()), (Route<dynamic> route) => false))
          ],
        ),
      ),
    );
  }
}

Widget loadingIndicator(SignupBloc bloc) => StreamBuilder<bool>(
  stream: bloc.loading,
  builder: (context, snap) {
    return Container(
      child: (snap.hasData && snap.data)
          ? CircularProgressIndicator()
          : null,
    );
  },
);

Widget emailField(SignupBloc bloc) => StreamBuilder<String>(
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

Widget nameField(SignupBloc bloc) => StreamBuilder<String>(
  stream: bloc.name,
  builder: (context, snap) {
    return TextField(
      keyboardType: TextInputType.name,
      onChanged: bloc.changeName,
      decoration: InputDecoration(
          labelText: "name",
          hintText: "jose",
          errorText: snap.error
      ),
    );
  },
);

Widget passwordField(SignupBloc bloc) => StreamBuilder<String>(
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
