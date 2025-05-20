import 'package:flutter/material.dart';
import 'package:rablo_demo/auth/auth_service.dart';
import 'package:rablo_demo/screens/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordContoller = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  Future<void> signup() async {
    print("signup button clicked");
    //signup function
    final authservice = AuthService();
    try{
      final response = await authservice.signUpWithEmailAndPassword(
        emailController.text,
        passwordContoller.text,
      );
      //if the response is good then go to the home screen
      if(response != null){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
      else{
        showDialog(context: context, builder: (context) => AlertDialog(
            title: Text("Error signing up")
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
        title: Text("SignUp Screen"),
      ),
      body: Column(
        //email
        children: [
          TextField(
            controller: emailController,
            decoration: InputDecoration(
                hintText: "email",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide
                      (color: Theme.of(context).colorScheme.tertiary)
                ) ,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide
                      (color: Theme.of(context).colorScheme.tertiary)
                )
            ),

          ),
          TextField(
            controller: passwordContoller,
            decoration: InputDecoration(
              hintText: "password",
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide
                    (color: Theme.of(context).colorScheme.tertiary)
              ) ,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide
                    (color: Theme.of(context).colorScheme.tertiary)
              ),
            ),
            obscureText: true,
          ),
          TextField(
            controller: phoneNumberController,
            decoration: InputDecoration(
                hintText: "Phone No.",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide
                      (color: Theme.of(context).colorScheme.tertiary)
                ) ,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide
                      (color: Theme.of(context).colorScheme.tertiary)
                )
            ),
          ),
          ElevatedButton(onPressed: (){
              signup();
          }, child:
          Text("Signup")),
          Row(children: [
            Text("Already have a account?"),
            GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Text("Login", style: TextStyle(fontWeight: FontWeight.bold),))
          ]),

        ],
        //password
      ),
    );
  }
}
