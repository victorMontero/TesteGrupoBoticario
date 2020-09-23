import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyRoundedButton extends StatelessWidget {
  final Function onTap;
  final String text;
  final Color textColor;
  final Color backgroundColor;

  MyRoundedButton(
      {@required this.onTap,
      this.text = "",
      this.textColor = Colors.white,
      this.backgroundColor = Colors.red});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      color: backgroundColor,
      elevation: 0,
      disabledElevation: 0,
      focusElevation: 0,
      highlightElevation: 0,
      hoverElevation: 0,
      child: Padding(
          padding: EdgeInsets.all(15),
          child: AutoSizeText(
            text,
            style: GoogleFonts.montserrat(
                color: Colors.white, fontWeight: FontWeight.bold),
            maxLines: 1,
            maxFontSize: 18,
            minFontSize: 14,
          )),
    );
  }
}
