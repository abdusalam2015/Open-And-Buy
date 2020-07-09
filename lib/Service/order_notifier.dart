
import 'package:OpenAndBuy/Model/category.dart';
import 'package:OpenAndBuy/Model/order.dart';
import 'package:OpenAndBuy/Model/product.dart';
import 'package:OpenAndBuy/Model/store.dart';
import 'package:OpenAndBuy/Service/order_service.dart';
import 'package:OpenAndBuy/Service/storeDatabase.dart';
import 'package:flutter/material.dart'; 


 class OrderNotifier extends  ChangeNotifier{
 

   String storeID;
   OrderNotifier({this.storeID});
 
  Order _order ;
 
  Order get order => _order;

 
    Future<bool> getOrderDetails(String orderID) async {
    _order =   await OrderService.getOrder(storeID, orderID) ;
    notifyListeners();
    return true;
}
 }