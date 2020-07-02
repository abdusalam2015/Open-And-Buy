import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class OrderNotification extends StatefulWidget {
  @override
  _OrderNotificationState createState() => _OrderNotificationState();
}

class _OrderNotificationState extends State<OrderNotification> {
  String _message = '';

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  _register() {
    _firebaseMessaging.getToken().then((token) => print(token));
  }

  @override
  void initState() {
    super.initState();
    getMessage();
  }
  
  void getMessage(){
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print('on message $message');
      setState(() => _message = message["notification"]["title"]);
    }, onResume: (Map<String, dynamic> message) async {
      print('on resume $message');
      setState(() => _message = message["notification"]["title"]);
    }, onLaunch: (Map<String, dynamic> message) async {
      print('on launch $message');
      setState(() => _message = message["notification"]["title"]);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Message: $_message"),
            OutlineButton(
              child: Text("Register My Device"),
              onPressed: () {
                _register();
              },
            ),
            // Text("Message: $message")
          ]),
        ),
      );
  }
}