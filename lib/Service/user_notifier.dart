
import 'package:flutter/material.dart';
import 'package:OpenAndBuy/Model/user_detail.dart';
import 'package:OpenAndBuy/Service/database.dart';


 class UserNotifier extends  ChangeNotifier{

   String sid;
   UserNotifier({this.sid});

  UserDetail _storeDetail ;

  UserDetail get storeDetail => _storeDetail;
  void  getUserInfo() async {
    _storeDetail =  await DatabaseService.getUserInfo(sid);
    notifyListeners();
   }


 }