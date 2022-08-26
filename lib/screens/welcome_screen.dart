import 'package:flutter/material.dart';
import 'package:jarvis_chat/screens/registration_screen.dart';
import 'package:jarvis_chat/screens/rounded_button.dart';
import 'login_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {

  static String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{
  // late AnimationController controller;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   controller = AnimationController(
  //     duration: Duration(seconds: 1),
  //     vsync: this,
  //     upperBound: 100.0
  //   );
  //   controller.forward();
  //   controller.addListener(() {
  //     setState(() {
  //
  //     });
  //     print(controller.value);
  //   });
  // }

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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(tag: 'logo',
                    child: Container(
                      child: Image.asset('images/logoiron.png'),
                      height: 60.0,
                    ),
                ),
                  SizedBox(
                    width: 170.0,
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 30.0,
                        // fontFamily: 'Bobbers',
                      ),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TyperAnimatedText('Jarvis-Chat'),
                        ],
                        onTap: () {
                          print("Tap Event");
                        },
                      ),
                    ),
                  ),
                Hero(
                  tag: 'logoIron',
                  child: Container(
                    child: Image.asset('images/logoiron.png'),
                    height: 60.0,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(color: Colors.green, onPressed:(){
              Navigator.pushNamed(context, LoginScreen.id);
            }, title: "Login"),
            RoundedButton(color: Colors.orange, onPressed:(){
              Navigator.pushNamed(context, RegistrationScreen.id);
            }, title: "Register"),
          ],
        ),
      ),
    );
  }
}
