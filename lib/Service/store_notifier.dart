
import 'package:flutter/material.dart';
import 'package:OpenAndBuy/Model/user_detail.dart';
import 'package:OpenAndBuy/Service/database.dart';


 class StoreNotifier extends  ChangeNotifier{

   // we change this class just to get the data from the store. we do not need to listen

   String sid;
   StoreNotifier({this.sid});

  UserDetail _storeDetail ;

  UserDetail get storeDetail => _storeDetail;
  void  getUserInfo() async {
   // _storeDetail =  await DatabaseService.getStoreInfo(sid);
  //  notifyListeners();
  }


 }