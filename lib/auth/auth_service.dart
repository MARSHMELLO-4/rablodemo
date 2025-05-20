import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? getCurrentUser(){
    return _auth.currentUser;
  }
  //sign in with email and password
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      try{
        _firestore.collection("Users").doc(userCredential.user!.uid).set({
          'uid': userCredential.user!.uid,
          'email': email,
        });
        print("user registeredd to the cloud store successfully");
      } catch(e){
        print("Error adding user to Firestore: $e");
      }
      return userCredential.user;
    } catch (e) {
      print("Error signing in: $e");
      return null;
    }
  }
  //sign up method
  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      try{
        _firestore.collection("Users").doc(userCredential.user!.uid).set({
          'uid': userCredential.user!.uid,
          'email': email,
        });
        print("user registeredd to the cloud store successfully");
      } catch(e){
        print("Error adding user to Firestore: $e");
      }
      return userCredential.user;
    } catch (e) {
      print("Error signing up: $e");
      return null;
    }
  }
  //sign out method
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("Error signing out: $e");
    }
  }
}