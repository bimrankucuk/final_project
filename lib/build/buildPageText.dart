import 'package:flutter/cupertino.dart';

Padding buildPageText(double screenWidth,  String? pagename) {

  return Padding(
    padding: EdgeInsets.only(left: 55, top: 50),
    child: Container(
        width: screenWidth / 2,
        child: Text(pagename!, style: TextStyle(
            fontSize: 34, fontWeight: FontWeight.w700),)),
  );
}