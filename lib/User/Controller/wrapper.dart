import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volc/User/Controller/authenticate/authenticate.dart';
import 'package:volc/User/Controller/home/home.dart';
import 'package:volc/User/Model/user.dart';


class Wrapper extends StatefulWidget {
  
  @override
  _WrapperState createState() => _WrapperState();
}


class _WrapperState extends State<Wrapper> {
  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if(user == null){
      return Authenticate();
    }else  {
      // StoreDatabaseService obj = new StoreDatabaseService();
      // List<StoreDetail> storesList = obj.getAllStores 
      // //print(storesList.toString() + "Lengthi is here ");
    // DatabaseService _obj = new DatabaseService(uid: user.uid);
    // dynamic tokens = await _obj.registerTokens(user.uid);
      return Home();
    }
  }
}