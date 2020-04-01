import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volc/models/user_detail.dart';
import 'package:volc/pages/home/app_bar.dart';
import 'package:volc/pages/home/body.dart';
import 'package:volc/pages/home/drawer.dart';
import 'package:volc/services/database.dart';
import 'package:volc/models/user.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserDetail>.value(
      value: DatabaseService(uid:Provider.of<User>(context).uid).user,//getUserDetail(DatabaseService().user),
      child:Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(55.0), // here the desired height
          child: AppBarWidget(),
        ),
        body: Body(),
        drawer: DrawerWidget(),
    ));
  }
}
