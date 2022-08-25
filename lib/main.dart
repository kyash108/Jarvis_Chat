import 'package:flutter/material.dart';
import 'package:jarvis_chat/screens/chat_screen.dart';
import 'package:jarvis_chat/screens/login_screen.dart';
import 'package:jarvis_chat/screens/registration_screen.dart';
import 'package:jarvis_chat/screens/welcome_screen.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.black),
        ),
      ),
      initialRoute: 'welcome_screen',
      routes: {
        'welcome_screen': (context)=>WelcomeScreen(),
        'login_screen': (context)=>LoginScreen(),
        'chat_screen': (context)=>ChatScreen(),
        'registration_screen': (context)=>RegistrationScreen(),
      },
    );
  }
}