import 'package:flutter/material.dart';
import 'package:shopping_now/pages/home/app_bar.dart';
import 'package:shopping_now/pages/home/body.dart';
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar:appBar(false,context),
      body: body(context),
      );
  }
}
