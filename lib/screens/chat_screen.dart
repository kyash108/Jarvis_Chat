import 'package:flutter/material.dart';
import 'package:jarvis_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
final _fireStore = FirebaseFirestore.instance;
User? loggedInUser;

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  late String messageText;
  final messageTextController = new TextEditingController();

  void getCurrentUser()async{
    try{
      final user = await _auth.currentUser;
      if(user!=null){
        loggedInUser = user;
        print(user);
      }
    }catch(e){
      print(e);
    }
  }

  // void getMessages() async {
  //   final messages = await _fireStore.collection('messages').get();
  //   for (var message in messages.docs) {
  //     print(message.data());
  //   }
  // }

  void messageStream() async {
    await for(var snapshot in _fireStore.collection('messages').snapshots()){
      for(var message in snapshot.docs){
            print(message.data());
      }
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
    print(loggedInUser?.email);
    messageStream();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('️Chat'),
        backgroundColor: Colors.redAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                        //Do something with the user input.
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _fireStore.collection("messages").add({
                        'text':messageText,
                        'sender':loggedInUser?.email,
                      });
                      messageTextController.clear();
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection('messages').snapshots(),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final messages = snapshot.data?.docs;
        List<MessageBubble> messageBubbles=[];
        for(var message in messages!){
          final messageText = message['text'];
          final messageSender = message['sender'];
          final currentUser = loggedInUser?.email;

          final messageBubble = MessageBubble(messageSender, messageText,currentUser==messageSender);
          messageBubbles.add(messageBubble);

        }
        return Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 10.0),
            children: messageBubbles,
          ),
        );

        return Text("No widget to build");
      },
    );
  }
}

class MessageBubble extends StatelessWidget {

  MessageBubble(this.sender,this.text,this.isMe);
  final String sender;
  final String text;
  final bool isMe;


  @override
  Widget build(BuildContext context) {
    final color;
    final crossAxis;
    if(isMe==true){
      color = Colors.blue;
      crossAxis = CrossAxisAlignment.end;
    }else{
      color = Colors.redAccent;
      crossAxis = CrossAxisAlignment.start;
    }
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: crossAxis,
        children: [
          Material(
            shadowColor: color,
            elevation: 40.0,
              borderRadius: BorderRadius.only(topLeft:Radius.circular(10.0),bottomLeft: Radius.circular(30.0),topRight: Radius.circular(30.0)),
              color: color,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                child: Text(
                    '$text',
                  style: TextStyle(fontSize: 20.0),
                ),
              )
          ),
          Text('$sender',style: TextStyle(fontSize: 12.0,color: Colors.grey),),
        ],
      ),
    );
  }
}
