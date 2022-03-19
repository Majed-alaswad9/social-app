import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void navigatorTo({required context,required Widget widget}){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>widget));
}

void navigatorAndRemove({required context,required Widget widget}){
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>widget), (route) => false);
}