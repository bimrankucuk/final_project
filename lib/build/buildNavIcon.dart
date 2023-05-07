import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildnavicon({
  required bool active,
  required IconData icon,

}){
  return Icon(icon,size: 18,color: Color(active ? 0xFFFA4A0C : 0xFFFFFFFF));

}
