import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {


  final FirebaseAuth _auth= FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;


  //firebase login
  Future<User?> firebaseLogin(String email , String password)async{

    var user = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return user.user;
  }


Future<void> SingOut() async {
    await _auth.signOut();
}

//create person
Future<User?> creatPerson (String name , String surname , String email ,String password)async{

    var user = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    
    await _firebaseFirestore.collection("user").doc(user.user?.uid).set({
      "name":name,
      "surname":surname,
      "email":email,
      "password":password,
      "url":""

    });
    return user.user;

}

}