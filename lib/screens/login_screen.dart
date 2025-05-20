import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rablo_demo/auth/auth_service.dart';
import 'package:rablo_demo/screens/Signup_screen.dart';
import 'package:rablo_demo/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordContoller = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  //login function
  Future<void> login(BuildContext context) async {
    print("login button pressed");
    final authservice = AuthService();

    //try login
    try{
      final response = await authservice.signInWithEmailAndPassword(
        emailController.text,
        passwordContoller.text,
      );
      //if the respnse is good to to home screen
      if(response != null){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
      else{
        showDialog(context: context, builder: (context) => AlertDialog(
            title: Text("Error signing in")
        ));
      }
    }
    catch(e){
      showDialog(context: context, builder: (context) => AlertDialog(
        title: Text(e.toString())
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LOGIN SCREEN"),
      ),
      body: Column(
        //email
        children: [
          TextField(
            controller: emailController,
            decoration: InputDecoration(
                hintText: "email",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.tertiary)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.tertiary))),
          ),
          TextField(
            controller: passwordContoller,
            decoration: InputDecoration(
              hintText: "password",
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.tertiary)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.tertiary)),
            ),
            obscureText: true,
          ),
          TextField(
            controller: phoneNumberController,
            decoration: InputDecoration(
                hintText: "Phone No.",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.tertiary)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.tertiary))),
          ),
          ElevatedButton(
              onPressed: () {
                //this is the login button
                login(context);
              },
              child: Text("Login")),
          Row(children: [
            Text("Not a member Register Now"),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupScreen()),
                  );
                },
                child: Text(
                  "Sign Up",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ))
          ]),
        ],
        //password
      ),
    );
  }
}
