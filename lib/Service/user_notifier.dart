
import 'package:OpenAndBuy/Model/order.dart';
import 'package:OpenAndBuy/Service/order_service.dart';
import 'package:OpenAndBuy/Service/order_service_user_side.dart';
import 'package:flutter/material.dart';
import 'package:OpenAndBuy/Model/user_detail.dart';
import 'package:OpenAndBuy/Service/database.dart';


 class UserNotifier extends  ChangeNotifier{

   String uid;
   UserNotifier({this.uid});

  UserDetail _userDetail ;
  List<Order> _orders;
  List<Order> _allUserOrders;


  UserDetail get userDetail => _userDetail;
  List<Order> get orders => _orders;
    List<Order> get allUserOrders => _allUserOrders;


   Future<UserDetail>  getUserInfo() async {
    _userDetail =  await DatabaseService.getUserInfo(uid);
    notifyListeners(); 
   return _userDetail;
   }


 Future<bool> getOrdersForSpecificStore(String storeID) async {
    _orders =   await OrderService.getOrders(uid,storeID) ;
    notifyListeners();
    return true;
}

Future<bool> getAllUserOrders() async {
    _allUserOrders = await OrderServiceUserSide.getUserOrdersHistory(uid);
    notifyListeners();
    return true;
}




 }