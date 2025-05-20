import 'package:flutter/material.dart';
import 'package:rablo_demo/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rablo_demo/widgets/message_decor.dart';
import '../chat/chat_service.dart';

class ChatScreen extends StatefulWidget {
  final recieverEmail;
  final reciverID;
  const ChatScreen({super.key, this.recieverEmail, this.reciverID});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  //chat
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  //send message
  void sendMessage() {
    String message = _messageController.text.trim();
    if (message.isNotEmpty) {
      //get the reciever id
      String recieverID = widget.reciverID;
      //send the message
      _chatService.sendMessage(recieverID, message);
      //clear the text field
      _messageController.clear();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat with ${widget.recieverEmail}"),
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessagesList()),
          _buildUserInput(),
        ],
      )
    );
  }
  Widget _buildMessagesList(){
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(stream: _chatService.getMessages(widget.reciverID, senderID),
        builder: (context,snapshot){
        if(snapshot.hasError){
          return Center(child: Text("Error loading messages"));
        }
        if(snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView(
          reverse: true,
          children: [
            // Use spread operator to flatten the list
            ...snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
          ],
        );
        });
  }
  Widget _buildMessageItem(DocumentSnapshot doc){
    Map<String,dynamic> data = doc.data() as Map<String, dynamic>;
    //check if the message is sent by the current user
    bool isSentByMe = data["senderID"] == _authService.getCurrentUser()!.uid;
    return Column(
      crossAxisAlignment: isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        MessageDecor(message: data["message"]),
      ],
    );
  }

  //build the user input
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: "Type a message",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          IconButton(
            onPressed: sendMessage,
            icon: Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
