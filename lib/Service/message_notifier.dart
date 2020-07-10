import 'package:OpenAndBuy/Model/category.dart';
import 'package:OpenAndBuy/Model/message.dart';
import 'package:OpenAndBuy/Model/order.dart';
import 'package:OpenAndBuy/Model/product.dart';
import 'package:OpenAndBuy/Model/store.dart';
import 'package:OpenAndBuy/Service/order_service.dart';
import 'package:OpenAndBuy/Service/storeDatabase.dart';
import 'package:flutter/material.dart';

class MessageNotifier extends ChangeNotifier {
  String userID;
  MessageNotifier({this.userID});
 
  List<Message> _messages;
  List<Message> get messages => _messages; 

  
  Future<bool> getMessages(String userID) async {
    _messages = await OrderService.getMessages(userID);
    notifyListeners();
    return true;
  }
}
