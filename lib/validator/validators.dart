import 'dart:async';

import 'package:teste_gb/util/constants.dart';


class Validators {
  final validateEmail = StreamTransformer<String, String>.fromHandlers(
      handleData: (String email, EventSink<String> sink) {
        //A standard email check regex
        Pattern pattern =
            r"^(([^<>()[\]\\.,;:\s@\”]+(\.[^<>()[\]\\.,;:\s@\”]+)*)|(\”.+\”))@((\[[0–9]{1,3}\.[0–9]{1,3}\.[0–9]{1,3}\.[0–9]{1,3}\])|(([a-zA-Z\-0–9]+\.)+[a-zA-Z]{2,}))$";
        RegExp regex = new RegExp(pattern);
        if (regex.hasMatch(email))
        sink.add(email);
        else
        sink.addError(Constants.EMAIL_VALIDATOR);
      }
  );

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (String password, EventSink<String> sink) {
        if (password.length > 7) {
          sink.add(password);
        } else {
          sink.addError(Constants.PASS_VALIDATOR);
        }
      }
  );

  final validateName = StreamTransformer<String, String>.fromHandlers(
    handleData: (String password, EventSink<String> sink){
      if (password.isNotEmpty){
        sink.add(password);
      } else {
        sink.addError(Constants.NAME_VALIDATOR);
      }
    }
  );
}