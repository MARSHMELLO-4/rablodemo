import 'package:flutter/material.dart';
import 'package:rablo_demo/auth/auth_service.dart';
import 'package:rablo_demo/widgets/user_tile.dart';

import '../chat/chat_service.dart';
import 'chat_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  //chat and auth service
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();
  void logout(){
    print("logout button pressed");
    final _auth = AuthService();
    final response = _auth.signOut();
    if(response != null){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
    else{
      showDialog(context: context, builder: (context) => AlertDialog(
          title: Text("Error signing out")
      ));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        actions: [
          IconButton(
            onPressed: () {
              // Add your logout logic here
              logout();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: _buildUserList(),
    );
  }
  //build the user list
  Widget _buildUserList() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: _chatService.getUserStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("the error is ${snapshot.error}");
          return const Text("error while loading users");
        }
        if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: CircularProgressIndicator());
        }
        final users = snapshot.data!;
        return ListView(
          children: users.map<Widget>((userData) => _buildUserListItem(userData, context)).toList(),
        );
      },
    );
  }
  //build the user list item
 Widget _buildUserListItem(Map<String,dynamic>userData,BuildContext context){
    //display all users except the current user
  if(userData["email"] != _authService.getCurrentUser()!.email)  {
      return UserTile(
        text: userData['email'],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatScreen(
                      recieverEmail: userData['email'],
                  reciverID: userData['uid'],
                    )),
          );
        },
      );
    }
  else{
      return const SizedBox.shrink(); // Return an empty widget if the user is the current user
    }
  }
  }
