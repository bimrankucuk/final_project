import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../home/homPage.dart';


Container buildTabBarLoginView(double screenWidth,double screenHeight,BuildContext context) {

  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //email & password & forgot passcode
        Padding(
          padding:  EdgeInsets.only(top: screenHeight/15,left:screenWidth/8,right: screenWidth/8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //email
              TextField(
                decoration: InputDecoration(
                  labelText: "Email address",
                ),
              ),
              SizedBox(height: screenHeight/40,),
              //password
              const TextField(
                cursorColor: Color(0xFFFA4A0C),

                decoration: InputDecoration(
                  labelText: "Password",
                    focusColor:Color(0xFFFA4A0C) ,

                ),
              ),
              SizedBox(height: screenHeight/40,),
              //forget pascode?
              Text("Forgot passcode?",style: TextStyle(color: Color(0xFFFA4A0C),fontSize: 16,fontWeight: FontWeight.w600),),

            ],
          ),
        ),
        SizedBox(height: screenHeight/40,),
        //login
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: ElevatedButton(
            onPressed:  (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>homPage()));
            },
            child: Padding(
              padding:  EdgeInsets.only(top: screenWidth/17,bottom: screenWidth/17,left: screenWidth/3.8,right: screenWidth/3.8),
              child: Text("Login",style: TextStyle(color:Color(0xFFFFFFFF) ,fontSize: 17,fontWeight: FontWeight.w600 ),),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(0xFFFF460A)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),),
            ),
          ),
        )

      ],
    ),
  );
}