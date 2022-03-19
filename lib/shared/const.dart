import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showMsg({
  required String? msg,
  required colorMsg? color
})=>Fluttertoast.showToast(
    msg: msg!,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: chose(color!),
    textColor:Colors.white,
    fontSize: 16.0
);
enum colorMsg{error ,success ,inCorrect}

Color chose( colorMsg  msg){
  Color color=Colors.green;
  switch(msg)
  {
    case colorMsg.error:
      color=Colors.red;
      break;
    case colorMsg.success:
      color=Colors.green;
      break;
    case colorMsg.inCorrect:
      color=Colors.yellow;
      break;
  }
  return color;
}
