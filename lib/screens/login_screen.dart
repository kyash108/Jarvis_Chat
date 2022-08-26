import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jarvis_chat/screens/chat_screen.dart';
import 'package:jarvis_chat/screens/rounded_button.dart';

import '../constants.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';


  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Container(
                height: 200.0,
                child: Image.asset('images/logoiron.png'),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
              onChanged: (value) {
                  email = value;
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(hintText: "Enter your email")
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              obscureText: true,
              onChanged: (value) {
                password = value;
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(hintText: "Enter your password"),
            ),
            SizedBox(
              height: 24.0,
            ),
            RoundedButton(
                color: Colors.black,
                onPressed: ()async{
                  try{
                    final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
                    if(user!=null){
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                  }catch(e){
                    print(e);
                  }

                },
                title: "Log In")
          ],
        ),
      ),
    );
  }
}
