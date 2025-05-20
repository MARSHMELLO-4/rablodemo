import 'package:flutter/material.dart';

class MessageDecor extends StatelessWidget {
  final String message;
  const MessageDecor({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    //give the message bubble code
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        message,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
