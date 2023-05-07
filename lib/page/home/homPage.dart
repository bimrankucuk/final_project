


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/build/bottomNavigationBar.dart';
import 'package:final_project/page/basket/basketPage.dart';
import 'package:final_project/page/home/view/buildPopularRestourant.dart';
import 'package:final_project/page/product/productPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../build/buildPageBar.dart';
import '../../build/buildPageText.dart';
import 'view/buildSearch.dart';



class homPage extends StatefulWidget {
  const homPage({Key? key}) : super(key: key);
  @override
  State<homPage> createState() => _homPageState();

}

class _homPageState extends State<homPage> {
  final _firestore =FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
   CollectionReference sehirlerRef= _firestore.collection("sehirler");
   var karamanKafelerRef=sehirlerRef.doc("karaman").collection("kafeler");


    var screenView = MediaQuery.of(context);
    var screenWidth = screenView.size.width;
    var screenHeight = screenView.size.height;
    return Scaffold(
    backgroundColor: Color(0xFFF9F9F9),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //page icon & page name
              buildPageBar(""),
              //page text

              buildPageText(screenWidth,"Delicious food for you"),
              //search
              buildSearch(),
              //categorie00s
              buildPopularRestourant(screenWidth),
              Padding(
                padding:  EdgeInsets.only(top:screenWidth/40,left: screenWidth/40),
                child: Column(
                  children: [
                    StreamBuilder<QuerySnapshot?>(
                      stream: karamanKafelerRef.snapshots(),
                      builder: (BuildContext context,AsyncSnapshot asyncSnapshot){
                        if(!asyncSnapshot.hasData){
                          return Center(child: CircularProgressIndicator());
                        }
                        var kafelerRef=asyncSnapshot.data.docs;
                        return Container(
                          height: screenHeight/3,
                          child: ListView.builder(
                            itemCount:kafelerRef.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context,index){
                              var veri = kafelerRef[index].data();
                              return   Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: screenWidth/2,
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>productPage(veri["id"])));

                                    },
                                    child: Card(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image(image: NetworkImage("${veri["url"]}")),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Icon(FontAwesomeIcons.houseChimney,),
                                                Padding(
                                                  padding:  EdgeInsets.only(left: 20),
                                                  child: Text("${veri["name"]}"),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              //ıconbar
            ],
          ),
          bottomNavigationBar("home", context),
        ],
      ),
    );
  }











}

