import 'package:final_project/page/login/loginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class startedPage extends StatefulWidget {
  const startedPage({Key? key}) : super(key: key);

  @override
  State<startedPage> createState() => _startedPageState();
}

class _startedPageState extends State<startedPage> {
  @override
  Widget build(BuildContext context) {
    var screenSize= MediaQuery.of(context);
    var screenHeight = screenSize.size.height;
    var screenWidth = screenSize.size.width;
    return Scaffold(
      backgroundColor: Color(0xFFFF4B3A),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          //icon "LOGO"
          Padding(
            padding:  EdgeInsets.only(left: 46,top: 56),
            child: Container(
              padding:  EdgeInsets.only(left: 46,top: 56),
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(50)),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("images/logo.png")
                ),
              ),
            ),
          ),

          // text " FOOD FOR EVERYYONE"
          Padding(
            padding:  EdgeInsets.only(left: screenWidth/10),
            child: Text("Food for Everyone",
              style:TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: screenWidth/8,
                  color: Color(0xFFFFFFFF),
                  fontStyle:FontStyle.normal),
            ),
          ),


          //image / [button " GET STARTEED" ] / SHADOW
          Stack(
            children: [
              // IMAGES
              Container(
                width: screenWidth,
                height: screenHeight/1.81,
                child: Stack(
                  alignment: Alignment.topLeft,
                  children: [

                    //MAN IMAGE
                    Positioned(
                        left:screenWidth/1.9,
                        top: screenHeight/10,
                        child: RotationTransition(
                            turns: AlwaysStoppedAnimation(9/360),
                            child: Image.asset("images/man.png",width: screenWidth/1.8,height: screenHeight/2.3,))),

                    //WOMAN IMAGE
                    Image.asset("images/women.png",width: screenWidth/1.5,height: screenHeight/1.9,),

                  ],
                ),
              ),

              //BUTTON "GET STARTEED" //SHADOW
              Positioned(
                bottom: -50,
                left: screenWidth/300,
                child: Container(
                  width: screenHeight,
                  child: Stack(
                    children: [

                      //SHADOW
                      Container(
                        height: 170,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFFF460A),
                                blurRadius: 50,
                              )
                            ]
                        ),
                      ),

                      //BUTTON "GET STARTEED"
                      Positioned(
                        bottom: 60,
                        left: screenWidth/10,
                        child: ElevatedButton(
                          onPressed:  (){
                            Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context)=>loginpage()));
                            },
                          child: Padding(
                            padding:  EdgeInsets.only(top: screenWidth/16,bottom: screenWidth/16,left: screenWidth/4,right: screenWidth/4),
                            child: Text("Get Started",style: TextStyle(color: Color(0xFFFF460A),fontSize: 17,fontWeight: FontWeight.w600 ),),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color(0xFFFFFFFF)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
