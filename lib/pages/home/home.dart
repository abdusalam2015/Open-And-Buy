import 'package:flutter/material.dart';
import 'package:volc/pages/home/app_bar.dart';
import 'package:volc/pages/home/body.dart';
import 'package:volc/pages/home/drawer.dart';
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: PreferredSize(
                preferredSize: Size.fromHeight(55.0), // here the desired height
                child: AppBarWidget(),
      ),
      body: body(context),
      drawer: DrawerWidget(),
      );
  }
}
