
import 'package:OpenAndBuy/Model/order.dart';
import 'package:OpenAndBuy/Service/order_service.dart';
import 'package:flutter/material.dart';
import 'package:OpenAndBuy/Model/user_detail.dart';
import 'package:OpenAndBuy/Service/database.dart';


 class UserNotifier extends  ChangeNotifier{

   String uid;
   UserNotifier({this.uid});

  UserDetail _userDetail ;
  List<Order> _orders;

  UserDetail get userDetail => _userDetail;
  List<Order> get orders => _orders;

   Future<UserDetail>  getUserInfo() async {
    _userDetail =  await DatabaseService.getUserInfo(uid);
    //notifyListeners();// we do not need to listen 
   return _userDetail;
   }


 Future<bool> getOrders() async {

    _orders =   await OrderService.getOrders(uid) ;
    notifyListeners();
    return true;

   }

 }