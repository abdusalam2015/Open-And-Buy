
import 'package:flutter/material.dart';
import 'package:volc/User/Model/user_detail.dart';
import 'package:volc/User/Service/user/database.dart';


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