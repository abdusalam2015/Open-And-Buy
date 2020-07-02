import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:OpenAndBuy/Model/category.dart';
import 'package:OpenAndBuy/Model/store.dart';
import 'package:OpenAndBuy/Controller/product_card.dart';
import 'package:OpenAndBuy/Controller/authenticate/authenticate.dart';
import 'package:OpenAndBuy/Controller/home/app_bar.dart';
import 'package:OpenAndBuy/Controller/home/drawer.dart';
import 'package:OpenAndBuy/Model/cart_bloc.dart';
import 'package:OpenAndBuy/Model/user.dart';
import 'package:OpenAndBuy/Model/product.dart';

 class StorePage extends StatefulWidget{
  final StoreDetail storeDetail;
  final BuildContext cont;
  final List<Category> categoryList;
  final List<Product> productsList;
  StorePage({this.storeDetail,this.cont,this.categoryList,this.productsList});
  @override
  _StorePageState createState() => _StorePageState();
  }

class _StorePageState extends State<StorePage> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
   // print(widget.productsList.length.toString() + 'HHHHHHH');
  //final userDetail = Provider.of<UserDetail>(context);
  //print('UserDeal in body: $userDetail');
    var bloc = Provider.of<CartBloc>(context); 
    int totalCount = 0;
    if (bloc.cart.length > 0) {
      totalCount = bloc.cart.values.reduce((a, b) => a + b);
    }else {
      totalCount = totalCount;
    }
   // Product product ;
    void _increment(String index,Product product){
      setState((){
        bloc.addToCart(index,product);
      });
    }
    void _decrement(String index,Product product){
      setState((){
        bloc.subToCart(index,product);
       });
    }
    final user = Provider.of<User>(context); 
    if(user.uid == null){
      Navigator.of(context).pop();
      return Authenticate();
    }else{  
      return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55.0), // here the desired height
        /// we need to send StoreID to the appbar, because we need to check 
        /// if we are already inside a store or still in the home page.
        /// if we are already inside a store then we can open the shopping cart for the user,
        /// if not then we need to make it disable. 
        child:  AppBarWidget(widget.cont,widget.storeDetail),
      ),
      body:ListView(
        children: <Widget>[
        widget.productsList != null && widget.productsList.length > 0 ? productsGridList(_increment,_decrement,widget.productsList,context,false)
        : Container(height: 600,width: 50,child: Center(child: Text('No Products exist in this Category',style: TextStyle(fontSize: 20,color: Colors.red),)),)
       ],
      ), 
      drawer: DrawerWidget(widget.cont,widget.storeDetail,widget.categoryList),
    
    );
    }
  }
  
}