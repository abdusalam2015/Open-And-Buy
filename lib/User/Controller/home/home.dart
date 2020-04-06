import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volc/User/Controller/home/app_bar.dart';
import 'package:volc/User/Controller/home/body.dart';
import 'package:volc/User/Controller/home/drawer.dart';
import 'package:volc/User/Model/user.dart';
import 'package:volc/User/Model/user_detail.dart';
import 'package:volc/User/Service/user/database.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String userID  = Provider.of<User>(context).uid;
     
    return StreamProvider<UserDetail>.value(
      value: DatabaseService(uid:userID).user,//getUserDetail(DatabaseService().user),
      child:Home2(userID));
  }
}

class Home2 extends StatefulWidget {
     String userID;
    Home2(this.userID);
  @override
  _Home2State createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserDetail>.value(
      value: DatabaseService(uid:widget.userID).user,//getUserDetail(DatabaseService().user),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(55.0), // here the desired height
          child: AppBarWidget(context),
        ),
        body: Body(context),
        drawer: DrawerWidget(context),
    ));
  }
}