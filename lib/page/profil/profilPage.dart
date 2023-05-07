import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/page/login/loginPage.dart';
import 'package:final_project/page/started/startedPage.dart';
import 'package:final_project/services/firebaseServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../build/bottomNavigationBar.dart';

class profilPage extends StatefulWidget {
  const profilPage({Key? key}) : super(key: key);

  @override
  State<profilPage> createState() => _profilPageState();
}

class _profilPageState extends State<profilPage> {
  FirebaseServices _firebaseServices=FirebaseServices();
  final _firestore =FirebaseFirestore.instance;
   final _auth = FirebaseAuth.instance;
   
 
  @override
  Widget build(BuildContext context) {
    var uid = _auth.currentUser?.uid;
     CollectionReference _profilRef =  _firestore.collection("user");
     final _profilInfoRef=_profilRef.doc("$uid");
      var screenView = MediaQuery.of(context);
    var screenWidth = screenView.size.width;
    var screenHeight = screenView.size.height;
    TextEditingController _nameController = TextEditingController();
    TextEditingController _surnameController =TextEditingController();
    return Scaffold(
      body: Column(
      
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: StreamBuilder<DocumentSnapshot>(
                        stream: _profilInfoRef.snapshots(),
                        builder: (context,asyncSnapshot){
                          if(!asyncSnapshot.hasData){
                            return Center(child: CircularProgressIndicator());
                          }
                          var veri = asyncSnapshot.data;
                          return veri != null? Center(
                            child: Column(
                                children: [
                                Container(
                                  width: screenWidth/2,
                                  height: screenWidth/2,
                                  child: veri["url"] ==""?  Image.asset("images/man.png"):
                                  Container(
                                      width: screenWidth/4,
                                      height: screenWidth/4,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(screenWidth/2),
                                        border: Border.all(color: Colors.black,width: 3),
                                      
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(veri["url"]),
                                        )
                                      ),
                                 )) ,
                                Text("Adı: ${veri["name"]}"),
                                Text("Soyadı: ${veri["surname"]}"),
                                Text("E-mail: ${veri["email"]}"),
                              ],
                            ),
                          ): Text(" ");
                      }),
                    ),
                      ElevatedButton(onPressed: (){

                        _firebaseServices.SingOut();
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>startedPage()));
                      }, child: Text("EXIT"))
                    ],
                ),
    );
  }
}
