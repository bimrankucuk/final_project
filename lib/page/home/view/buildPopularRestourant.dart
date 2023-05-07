import 'package:flutter/cupertino.dart';

Padding buildPopularRestourant(double screenWidth) {
  return Padding(
    padding:  EdgeInsets.only(top:screenWidth/15,bottom: 10,left: 10),
    child: Row(

      children: [
        
        Text("Popular Restaurants",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 25),)
      ],
    ),
  );
}