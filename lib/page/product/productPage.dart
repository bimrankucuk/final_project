import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../build/bottomNavigationBar.dart';

class productPage extends StatefulWidget {
  late String id;
 


  productPage(this.id);

  @override
  State<productPage> createState() => _productPageState();
}





class _productPageState extends State<productPage> {

  final _firestore =FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  var kategori="kahvaltı";
  @override
  Widget build(BuildContext context) {
    String id = "${widget.id}";
    
    var uid = _auth.currentUser?.uid;
    CollectionReference sehirlerRef= _firestore.collection("sehirler");
    var kategoriRef=sehirlerRef.doc("karaman").collection("kafeler").doc(id).collection("$kategori");
    var karamanKafeler1MenuRef=sehirlerRef.doc("karaman").collection("kafeler").doc(id).collection("menu");
    var karamanKafelerRef=sehirlerRef.doc("karaman").collection("kafeler").doc(id);
    var screenView = MediaQuery.of(context);
    var screenWidth = screenView.size.width;
    var screenHeight = screenView.size.height;
    return Scaffold(
      backgroundColor:Color(0xFF1D1E25) ,
      body: Stack(
        children: [
          Column(

            children: [
              //kaffe info
              Padding(
                padding:  EdgeInsets.only(top: screenWidth/8,left: screenWidth/20),
                child: Container(
                  child: StreamBuilder<DocumentSnapshot>(
                    stream: karamanKafelerRef.snapshots(),
                    builder: (BuildContext context,AsyncSnapshot asyncSnapshot){
                      if(!asyncSnapshot.hasData){
                          return Center(child: CircularProgressIndicator());
                        }
                      var veri=asyncSnapshot.data.data();
                      return Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(40)),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage("${veri["url"]}"),
                              ),
                            ),
                          ),
                          Spacer(flex: 3,),
                          Text("${veri["name"]}",style: TextStyle(color:Colors.white,fontSize: 20,fontStyle:FontStyle.italic),),
                          Spacer(flex: 7,),

                        ],
                      );
                    },
                  ),
                ),
              ),
              //kategori info
              Padding(
                padding:  EdgeInsets.all(screenWidth/20),
                child: Container(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: karamanKafeler1MenuRef.snapshots(),
                    builder: (BuildContext context,AsyncSnapshot asyncSnapshot){
                      if(!asyncSnapshot.hasData){
                          return Center(child: CircularProgressIndicator());
                        }
                      var kafelerRef=asyncSnapshot.data.docs;
                      return Container(
                        height: 50,
                        width: screenWidth,
                        child: ListView.builder(
                          itemCount:kafelerRef.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context,index){
                            var veri = kafelerRef[index].data();
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    kategori= veri["id"];
                                    print(kategori);
                                  });
                                },
                                child: Container(

                                    alignment: Alignment.center,
                                    child: Text("${veri["name"]}",style: TextStyle(fontSize: 25,color: Color(0xFFE38035)),)),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),

              //product info
              Expanded(
                child: Padding(
                  padding:const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: kategoriRef.snapshots(),
                      builder: (BuildContext context,AsyncSnapshot asyncSnapshot){
                        if(!asyncSnapshot.hasData){
                          return Center(child: CircularProgressIndicator());
                        }
                        var menu=asyncSnapshot.data.docs;
                        return GridView.builder(
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 300,
                              childAspectRatio: 0.8
                          ),
                          itemCount:menu.length,
                          itemBuilder: (context,index){
                            var veri = menu[index].data();
                            int piece = veri["piece"];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: [
                                  Container(
                                    width:screenWidth/2.7,
                                    height: screenHeight/4,
                                  ),
                                  //product name & price $ icon
                                  Positioned(
                                    top:67,
                                    child: Container(
                                      width: screenWidth/3,
                                      height: screenWidth/3.1,
                                      decoration: BoxDecoration(
                                        color:Color(0xFF363841),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                          bottomLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(50)
                                        )
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8,right: 8,top: 30),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("${veri["name"]}",style: TextStyle(color:Colors.white ),),
                                          SizedBox(height: 10,),
                                            Text("${veri["price"]} TL",style: TextStyle(color: Colors.white),),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  //product img
                                  Positioned(
                                    left:19,
                                    child:Container(
                                      width: 90,
                                      height: 90,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(45)),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage("${veri["url"]}"),
                                        ),
                                      ),
                                    ),
                                  ),

                                  //icon
                                  Positioned(
                                    top: 150,
                                    left: 90,
                                    child: GestureDetector(
                                        onTap: (){
                                          
                                        _firestore.collection("user").doc("$uid").collection("favorite").doc("${veri["name"]}${id}").set({
                                          
                                          "name":veri["name"],
                                          "url":veri["url"],
                                          "price":veri["price"]*piece,
                                          "kafe":id,
                                          "piece":piece++
                                
                                        });
                                     
                                      },
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF000000),
                                          borderRadius: BorderRadius.all(Radius.circular(25)),
                                        ),
                                        child: Icon(FontAwesomeIcons.basketShopping,color: Colors.white,),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar("home", context)
        ],
      ),


    );

  }
}
