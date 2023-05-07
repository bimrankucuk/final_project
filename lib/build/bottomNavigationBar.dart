
import 'package:final_project/page/basket/basketPage.dart';
import 'package:final_project/page/home/homPage.dart';
import 'package:final_project/page/profil/profilPage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'buildNavIcon.dart';


Widget bottomNavigationBar(
    String page,
    BuildContext context
    ){
  return Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      height: 60,
      decoration: BoxDecoration(
        color:Color(0xFF363841),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(50),
          topLeft: Radius.circular(50),
        ),
        boxShadow: [BoxShadow(
          offset: Offset(0,-3),
          color: Colors.black.withOpacity(0.25),
          blurRadius: 10,
        ),
        ],
      ),
      padding: EdgeInsets.only(top: 20,bottom: 20,),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>homPage()));
            },
              child: buildnavicon(active: page=="home", icon: FontAwesomeIcons.house, )),
          GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>basketPage()));
              },
              child: buildnavicon(active: page=="basket", icon: FontAwesomeIcons.basketShopping)),

          GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>profilPage()));
              },
              child: buildnavicon(active: page=="profile", icon: FontAwesomeIcons.person)),
        ],
      ),
    ),
  );
}
