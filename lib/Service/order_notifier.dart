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
    _activeOrders = await OrderService.getActiveOrders(storeID, userID);

    notifyListeners();
    return true;
  }
   
   
}
