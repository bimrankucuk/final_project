import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Padding buildSearch() {
  return Padding(
    padding: EdgeInsets.only(left: 50, right: 50, top: 70),
    child: TextField(

      decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFFEFEEEE),
          prefixIcon: Icon(FontAwesomeIcons.magnifyingGlass, size: 18,
            color: Colors.black,),
          labelText: "Search",
          labelStyle: TextStyle(
            color: Color(0xFF000000),
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Colors.black,
              )
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide.none,
          )
      ),
    ),
  );
}