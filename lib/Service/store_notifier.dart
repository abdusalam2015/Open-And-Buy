
import 'package:OpenAndBuy/Model/category.dart';
import 'package:OpenAndBuy/Model/product.dart';
import 'package:OpenAndBuy/Model/store.dart';
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

  StoreDetail get storeDetail => _storeDetail;
  List<Category> get categories => _categories;
  List<Product> get categoryProducts => _categoryProducts;


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

    
 }