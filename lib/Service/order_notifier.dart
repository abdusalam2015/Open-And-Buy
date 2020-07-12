import 'package:OpenAndBuy/Model/order.dart'; 
import 'package:OpenAndBuy/Service/order_service.dart';
import 'package:flutter/material.dart';

class OrderNotifier extends ChangeNotifier {
  String storeID;
  OrderNotifier({this.storeID});

  Order _order;
  List<Order> _activeOrders;
  int _activeOrdersNumbers;


  Order get order => _order;
  List<Order> get activeOrders => _activeOrders;
  int get activeOrdersNumbers => _activeOrdersNumbers;


  Future<bool> getOrderDetails(String orderID) async {
    _order = await OrderService.getOrder(storeID, orderID);
    notifyListeners();
    return true;
  }

  Future<bool> getActiveOrders(String userID) async {
     List<Order> _activeOrdersCopy = await OrderService.getActiveOrders(storeID, userID);
    _activeOrders  = filterOrders(_activeOrdersCopy);
    notifyListeners();
   if(_activeOrders == null) return false;
   return true;
  }
  filterOrders(List<Order> _activeOrdersCopy){
    List<Order> newList = new List<Order>();
    if(_activeOrdersCopy!=null){
    for(int i = 0 ; i < _activeOrdersCopy.length ; i ++){
      
      if(_activeOrdersCopy[i].status  != 'Completed' && _activeOrdersCopy[i].status  != 'Rejected'){
        newList.add(_activeOrdersCopy[i]);
      // print(_activeOrdersCopy[i].status);
      } 
    }

    }
    return newList;

  }
   
   
}
