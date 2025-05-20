import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const UserTile({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
        ),
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            //icon
            Icon(Icons.person),
            //user name
            Text(text),
          ],
        ),
      ),
    );
  }
}
