import 'package:final_project/page/home/homPage.dart';
import 'package:final_project/page/login/view/buildTabBar.dart';
import 'package:final_project/page/login/view/buildTabBarLoginView.dart';
import 'package:final_project/services/firebaseServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);

  @override
  State<loginpage> createState() => _loginpageState();
}
class _loginpageState extends State<loginpage> {
  bool circularProgressIndicator=false;
  @override
  Widget build(BuildContext context) {
    FirebaseServices _firebaseServices=FirebaseServices();

    final TextEditingController _emailControlor=TextEditingController();
    final TextEditingController _passwordControlor=TextEditingController();
    final TextEditingController _nameControler = TextEditingController();
    final TextEditingController _surnameControler = TextEditingController();
    final TextEditingController _emailControler = TextEditingController();

    var screenView=MediaQuery.of(context);
    var screenHeight=screenView.size.height;
    var screenWidth=screenView.size.width;



    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child:  Scaffold(
          //logo & TabBar
          appBar: AppBar(
            //logo
            title: Image.asset("images/logo.png"),
            centerTitle: true,
            toolbarHeight: screenWidth/1.5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
            ),
            backgroundColor: Color(0xFFFFFFFF),
            //TabBar
            bottom: buildTabBar(),
          ),
          backgroundColor: Color(0xFFF2F2F2),
          //loginview & sign-upview
          body: Container(
            //loginview & sign-upview
            child: SingleChildScrollView(
              //loginview & sign-upview
              child: Container(
                width: screenWidth,
                height:screenHeight/1.7,
                //loginview & sign-upview
                 child: circularProgressIndicator==false ? TabBarView(
                  children: [
                    //login view
               Container(
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
                controller: _emailControler,
                decoration: InputDecoration(
                  labelText: "Email address",
                ),
              ),
              SizedBox(height: screenHeight/40,),
              //password
              TextField(
                 controller:_passwordControlor ,
                
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
              _firebaseServices.firebaseLogin(_emailControler.text,_passwordControlor.text).then((value){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>homPage()));
              });
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
  ),
                    //sing-up view
                buildTabBarSignUpView(screenHeight, screenWidth, _nameControler, _surnameControler, _emailControler, _passwordControlor, _firebaseServices)
                  ],
                ) : CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container buildTabBarSignUpView(double screenHeight, double screenWidth, TextEditingController _nameControler, TextEditingController _surnameControler, TextEditingController _emailControler, TextEditingController _passwordControlor, FirebaseServices _firebaseServices) {
    return Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Name & Surname & Email & Password
                    Padding(
                      padding: EdgeInsets.only(top: screenHeight/40,left:screenWidth/8,right: screenWidth/8),
                      child: Column(
                        children: [
                          //Name
                          TextField(
                            controller: _nameControler,
                            decoration: InputDecoration(
                              labelText: "Name",
                            ),
                          ),
                          SizedBox(height: screenHeight/40,),
                          //surname
                          TextField(
                            controller: _surnameControler,
                            decoration: InputDecoration(
                              labelText: "Surname",
                            ),
                          ),
                          SizedBox(height: screenHeight/40,),
                          //email
                          TextField(
                            controller: _emailControler,
                            decoration: InputDecoration(
                              labelText: "Email",
                            ),
                          ),
                          SizedBox(height: screenHeight/40,),
                          //password
                          TextField(
                            controller: _passwordControlor,
                            decoration: InputDecoration(
                              labelText: "Password",
                            ),
                          ),


                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight/40,),
                    //sign-um
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: ElevatedButton(
                        onPressed:  (){
                          setState(() {
                            circularProgressIndicator=true;
                          });
                          _firebaseServices.creatPerson(_nameControler.text, _surnameControler.text, _emailControler.text,_passwordControlor.text).then((value) {
                            setState(() {
                              circularProgressIndicator=false;
                            });
                          }
                          );

                        },
                        child: Padding(
                          padding:  EdgeInsets.only(top: screenWidth/17,bottom: screenWidth/17,left: screenWidth/3.8,right: screenWidth/3.8),
                          child: Text("Sign-Up",style: TextStyle(color:Color(0xFFFFFFFF) ,fontSize: 17,fontWeight: FontWeight.w600 ),),
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






}