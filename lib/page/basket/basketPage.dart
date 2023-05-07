import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../build/bottomNavigationBar.dart';

class basketPage extends StatefulWidget {
  const basketPage({Key? key}) : super(key: key);

  @override
  State<basketPage> createState() => _basketPageState();
}
class _basketPageState extends State<basketPage> {

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    var screenView = MediaQuery.of(context);
    var screenWidth = screenView.size.width;
    var screenHeight = screenView.size.height;
    var uid = _auth.currentUser?.uid;
  
    CollectionReference userFavoriteRef = _firestore.collection("user").doc("$uid").collection("favorite");
    return Scaffold(
      
      backgroundColor:Color(0xFF1D1E25) ,
      body: Column(
        children: [
            Container(
            width: screenWidth,
            height: screenHeight/1.1,
            child: Stack(
              children: [
                
                Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 40),
                        child:StreamBuilder<QuerySnapshot?>(
                          stream: userFavoriteRef.snapshots(),
                          builder: (BuildContext context,AsyncSnapshot asyncSnapshot){
                            if(!asyncSnapshot.hasData){
                                    return Center(child: CircularProgressIndicator());
                                  }
                            var kafelerRef=asyncSnapshot.data.docs;
                            return GridView.builder(
                              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 300,
                                childAspectRatio: 0.8
                              ),
                              itemCount:kafelerRef.length,
                              itemBuilder: (context,index){
                                var veri = kafelerRef[index].data();
                               
                                  
                            
                                return 
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child:  Stack(
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
                                                  Text("${veri["kafe"]} ",style: TextStyle(color: Colors.white),),
                                                  Text("${veri["piece"]} adet",style: TextStyle(color: Colors.white),),
          
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
                                        Positioned(
                                          top: 150,
                                          left: 90,
                                          child: GestureDetector(
                                            onTap: () async {

                                             if(veri["piece"]==1){
                                              await kafelerRef[index].reference.delete();
                                             }

                                             await kafelerRef[index].reference.delete();
                                             setState(() {
                                               
                                             });
                                
                                            },
                                            child: Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: Color(0xFF000000),
                                                borderRadius: BorderRadius.all(Radius.circular(25)),
                                              ),
                                              child: Icon(FontAwesomeIcons.basketShopping,color: Colors.red,),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                ;
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
               Align(
                alignment: Alignment.bottomCenter,
                 child: Padding(
                             padding: const EdgeInsets.only(top:50),
                             child: Container(
                             child: StreamBuilder<QuerySnapshot>(
                  stream: userFavoriteRef.snapshots(),
                  
                  builder:(BuildContext context,AsyncSnapshot asyncSnapshot){
                    if(!asyncSnapshot.hasData){
                            return Center(child: CircularProgressIndicator());
                          }
                   var veri = asyncSnapshot.data.docs;
                    int topplam =0;
                   for (var i =0;i<veri.length;i++)
                   {
                              
                               topplam=veri[i]["price"]+topplam;
                              
                   }
                             return Container(
                  color: Colors.white,
                  child: Container(
                    padding: EdgeInsets.only(left: 10,right: 10),
                    width: screenWidth,
                    height: screenWidth/8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50)
                      )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Toplam : ${topplam}  TL",style: TextStyle(color: Colors.black),),
                        ElevatedButton(
                          
                          onPressed:(){},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFA4A0C),
                          ),
                        
                         child: Text("Sepeti Onayla")),
                      ],
                    )),);
                    }
                   ),
                        ),
                           ),
               ),
         
               
                
              ],
            ),
          ),
           bottomNavigationBar("basket", context),
        ],
      ),
    );
  }
}
