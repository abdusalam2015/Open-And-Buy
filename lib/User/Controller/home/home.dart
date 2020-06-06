import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volc/Admin/Service/storeDatabase.dart';
import 'package:volc/SharedModels/store/store.dart';
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
      child:Home2(userID) );
  }
}

class Home2 extends StatefulWidget {
    final String userID;
    Home2(this.userID);
  @override
  _Home2State createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  @override
  Widget build(BuildContext context) {
  StoreDatabaseService obj = new StoreDatabaseService();
  StoreDetail storeDetail = new StoreDetail(sid:'',name:'',location:'',
  backgroundImage:'',coveredArea:'',storeType:'',phoneNumber:'',
  storeStatus:'',latitude:'',longitude:'') ;
      return StreamProvider<UserDetail>.value(
      value: DatabaseService(uid:widget.userID).user,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(55.0), // here the desired height
          child: AppBarWidget(context,storeDetail),
        ),
        body: FutureBuilder<List<StoreDetail>>(
          future: obj.getAllStores(),
          builder: (BuildContext context, AsyncSnapshot<List<StoreDetail>> snapshot) {
            if (!snapshot.hasData) {
              // while data is loading:
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              // data loaded:
              final storesList  = snapshot.data;
              return Center(
                child: Body(context,storesList)//Text('Android version: ${storesList[0].sid}'),
              );
            }
          }),
        // set categoryList =  null,
        // because we do not want to show any category in the drawer inside the homepage. 
        drawer:  DrawerWidget(context,storeDetail,null),
    ));
  }
   
}