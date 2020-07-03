
import 'package:OpenAndBuy/Model/category.dart';
import 'package:OpenAndBuy/Model/product.dart';
import 'package:OpenAndBuy/Model/store.dart';
import 'package:OpenAndBuy/Service/storeDatabase.dart';
import 'package:flutter/material.dart';
import 'package:OpenAndBuy/Model/user_detail.dart';
import 'package:OpenAndBuy/Service/database.dart';


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


  void  getStoreInfo() async {
    _storeDetail =  await StoreDatabaseService.getStoreInfo(sid);
    notifyListeners();

   }
    void getStoreCategories() async{
    _categories =  await StoreDatabaseService.getcategories(sid);
    notifyListeners();
    }
    
    void getCategoryProduct(String cid) async{
    _categoryProducts =  await StoreDatabaseService.getStoreProducts(sid,cid);
    notifyListeners();
    }

    
 }