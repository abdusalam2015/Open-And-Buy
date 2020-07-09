
import 'package:OpenAndBuy/Model/category.dart';
import 'package:OpenAndBuy/Model/order.dart';
import 'package:OpenAndBuy/Model/product.dart';
import 'package:OpenAndBuy/Model/store.dart';
import 'package:OpenAndBuy/Service/order_service.dart';
import 'package:OpenAndBuy/Service/storeDatabase.dart';
import 'package:flutter/material.dart'; 


 class StoreNotifier extends  ChangeNotifier{

   // we change this class just to get the data from the store. 
   //we do not need to listen

   String sid;
   StoreNotifier({this.sid});

  StoreDetail _storeDetail ;
  List<Category> _categories;
  List<Product> _categoryProducts;
  Order _order ;

  StoreDetail get storeDetail => _storeDetail;
  List<Category> get categories => _categories;
  List<Product> get categoryProducts => _categoryProducts;
  Order get order => _order;


  Future<bool>  getStoreInfo() async {
    _storeDetail =  await StoreDatabaseService.getStoreInfo(sid);
    //notifyListeners();
    return true;

   }
    Future<bool> getStoreCategories() async{
    _categories =  await StoreDatabaseService.getcategories(sid);
    //notifyListeners();
    return true;
    }
    
    Future<bool> getCategoryProduct(String cid) async{
    _categoryProducts =  await StoreDatabaseService.getStoreProducts(sid,cid);
    notifyListeners();
    return true;
    }
    Future<bool> getOrderDetails(String orderID) async {
    _order =   await OrderService.getOrder(sid, orderID) ;
    notifyListeners();
    return true;
}

    
 }