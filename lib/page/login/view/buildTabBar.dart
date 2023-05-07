import 'package:flutter/material.dart';

TabBar buildTabBar() {
  return TabBar(
    indicatorSize: TabBarIndicatorSize.label,
    labelColor: Color(0xFF000000),
    indicatorColor:Color(0xFFFA4A0C) ,
    tabs: [
      Tab(text: "Login",),
      Tab(text: "Sign-Up",)
    ],
  );
}