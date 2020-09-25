import 'package:teste_gb/style/theme.dart' as Style;
import 'package:flutter/material.dart';

Widget buildLoadingWidget(){
  return Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Style.MyColors.greenColor),
    ),
  );
}