import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:rablo_demo/models/message.dart';

class ChatService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //get the instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //get the user stream
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  //send message
  Future<void> sendMessage(String reciverID, message) async {
    //get the current user info
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    //create the new message
    Message newMessage = Message(
      senderID: currentUserID,
      senderEmail: currentUserEmail,
      recieverID: reciverID,
      message: message,
      timestamp: timestamp,
    );
    //construct the chat room id froo the two users
    List<String>ids = [currentUserID, reciverID];
    ids.sort(); //makes sure that any two people have the same id
    String chartRoomID = ids.join("_"); //the unqiue id for the chat room
    //add the new message to this chat room
    await _firestore.collection("ChatRooms").doc(chartRoomID).collection(
        "Messages").add(newMessage.toMap());
  }

  //get messages
  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
    //connstruct the chat room id froo the two users
    List<String>ids = [userID, otherUserID];
    ids.sort(); //makes sure that any two people have the same id
    String chartRoomID = ids.join("_"); //the unqiue id for the chat room
    return _firestore.collection("ChatRooms").doc(chartRoomID).collection(
        "Messages").orderBy("timestamp", descending: true).snapshots();
  }
}