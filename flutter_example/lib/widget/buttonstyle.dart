import 'package:flutter/material.dart';

Container MainButton(BuildContext context, String title, Color textColor, Color buttonColor) {
  return Container(
    alignment: Alignment.center,
    width: MediaQuery.of(context).size.width,
    height: 50,
    decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(50)
    ),
    child: Text(title, style: TextStyle(color: textColor, fontSize: 15),),
  );
}