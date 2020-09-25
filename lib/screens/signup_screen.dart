import 'package:flutter/material.dart';
import 'package:teste_gb/bloc/login_bloc.dart';
import 'package:teste_gb/bloc/signup_bloc.dart';
import 'package:teste_gb/components/rounded_button.dart';
import 'package:teste_gb/elements/loader_element.dart';
import 'package:teste_gb/screens/home_screen.dart';
import 'package:teste_gb/util/constants.dart';
import 'package:teste_gb/style/theme.dart' as Style;

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  LoginBloc bloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(backgroundColor: Style.MyColors.mainColor,
        title: Text(Constants.REGISTER_TEXT),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
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
      ),
    );
  }
}

Widget loadingIndicator(LoginBloc bloc) => StreamBuilder<bool>(
  stream: bloc.loading,
  builder: (context, snap) {
    return Container(
      child: (snap.hasData && snap.data)
          ? buildLoadingWidget()
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
          labelText: Constants.EMAIL_TEXT,
          hintText: Constants.EMAIL_EXAMPLE_TEXT,
          errorText: snap.error
      ),
    );
  },
);

Widget nameField(){
    return TextField(
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
          labelText: Constants.NAME_TEXT,
          hintText: Constants.NAME_EXAMPLE_TEXT,
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
            labelText: Constants.PASS_TEXT,
            hintText:Constants.PASS_TEXT,
            errorText: snap.error
        ),
      );
    }
);

Widget submitButton(LoginBloc bloc) => StreamBuilder<bool>(
  stream: bloc.submitValid,
  builder: (context, snap) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.62,
        child: MyRoundedButton(text: Constants.LOGIN_TEXT,
          onTap: () => Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) => HomeScreen()), (Route<dynamic> route) => false),

        ),
      ),
    );
  },
);