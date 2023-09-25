import 'package:flutter/material.dart';
import 'package:music_app/constants.dart';

Widget defaultTextButton({
  required VoidCallback? function,
  required String text
})=>TextButton(onPressed: function, child: Text(text.toUpperCase(),style: TextStyle(color: defaultColor),),);


void navigateAndFinish(context,widget)=> Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
      builder: (context) =>widget
  ),
      (route)=>false,
);