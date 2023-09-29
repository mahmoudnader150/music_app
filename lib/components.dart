import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
void navigateTo(context,widget)=> Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) =>widget
    )
);

void showToast({
  required String text,
})=>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor:  defaultColor,
        textColor: Colors.white,
        fontSize: 16.0
    );
