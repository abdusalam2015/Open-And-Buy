import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volc/Admin/Controller/product/add_product.dart';
import 'package:volc/Admin/Controller/store_home_pages/appbar_store_page.dart';
import 'package:volc/Admin/Service/storeDatabase.dart';
import 'package:volc/SharedModels/product/product.dart';
import 'package:volc/SharedModels/store/category.dart';
import 'package:volc/SharedModels/store/store.dart';
import 'package:volc/SharedWidgets/product_card.dart';
import 'package:volc/SharedWidgets/shared_functions.dart';
import 'package:volc/User/Model/user_detail.dart';
import 'package:volc/SharedWidgets/store_card.dart';


class StoreHomePage extends StatefulWidget {

  final BuildContext cont;
  final StoreDetail storeDetail;
  final List<Category>categoriesList;
  final List<Product> productsList;
  StoreHomePage(this.cont,this.storeDetail,this.categoriesList,this.productsList);
  @override
  _StoreHomePageState createState() => _StoreHomePageState();
}
class _StoreHomePageState extends State<StoreHomePage> {
  final SharedFunctions sharedfun = new SharedFunctions();
  bool loading = false;
  bool isUploaded = false;
  UserDetail userDetail ;
  File img;
  double c_width;
  @override
  Widget build(BuildContext context){
  userDetail = Provider.of<UserDetail>(widget.cont);
  Product product ;
  c_width = MediaQuery.of(context).size.width*0.8;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(55.0), // here the desired height
          child:Center(),// StorePageAppBar(),
        ),
      body:Container(
        child: ListView(
          children: <Widget>[
          storeCard(widget.storeDetail),
          button(),
          productsGridList(null,null,widget.productsList,context,true),
        ],),
      ),
    );  
              
           
  }
  Widget button(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ButtonTheme(
        minWidth: 200,
        height: 60,
        child: RaisedButton(
          color:Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Add Products',style: TextStyle(color: Colors.white,fontSize: 20),),
              // Icon(Icons.navigate_next,color:Colors.white),
              // Text( 'Next', style: TextStyle(color: Colors.white,fontSize: 20), ),
            ],
          ),
            onPressed: () async{ 
              StoreDatabaseService obj = new StoreDatabaseService(sid: widget.storeDetail.sid);   
              List<Category> categoriesList = await obj.getcategories(userDetail.userID);
                  Navigator.pop(context);
                    final result = Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddProduct(
                            widget.cont,
                            widget.storeDetail,
                            categoriesList,
                            widget.productsList
                          )
                        )); 
              // make sure that if it is already updated or not
                // result != null ? Scaffold.of(context).showSnackBar(SnackBar(
                // content: Text('Saved!', style: TextStyle(color: Colors.white),),
                // backgroundColor: Colors.green)):Container();
            }
        ),
      ),
    );
  }
}

// class CategoryLists extends StatefulWidget {
//   String userID; 
//   CategoryLists(this.userID);
//   @override
//   _CategoryListsState createState() => _CategoryListsState();
// }

// class _CategoryListsState extends State<CategoryLists> {

//   Future getcategories() async {
//     var firestore = Firestore.instance;
//     QuerySnapshot qn = await  firestore.collection('stores').
//     document(widget.userID).collection('categories').getDocuments();//  .collection('products').getDocuments();
//     //print("YY:"+ qn.documents);
//     return qn.documents;
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Ex'),

//       ),
//       body: Container(
//         child: FutureBuilder(
//           future: getcategories(),
//           builder: (_, snapshot){
//             if(snapshot.connectionState == ConnectionState.waiting){
//               return Center( child:Text('Loading...') );
//             }else{
//               return ListView.builder(
//                 itemCount: snapshot.data.length,
//                 itemBuilder: (_, index){
//                   return  Text(snapshot.data[index].data["name"]);
//               });
//             }
//           },
//         ),
//       ),
//     );
//   }
//  }