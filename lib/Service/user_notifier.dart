
import 'package:flutter/material.dart';
import 'package:OpenAndBuy/Model/user_detail.dart';
import 'package:OpenAndBuy/Service/database.dart';


 class UserNotifier extends  ChangeNotifier{

   String uid;
   UserNotifier({this.uid});

  UserDetail _userDetail ;

  UserDetail get userDetail => _userDetail;
  

   void  getUserInfo() async {
    _userDetail =  await DatabaseService.getUserInfo(uid);
    notifyListeners();
   }


 }