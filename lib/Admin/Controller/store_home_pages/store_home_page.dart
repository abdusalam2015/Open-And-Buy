import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volc/Admin/Controller/product/add_product.dart';
import 'package:volc/Admin/Controller/store_home_pages/products_tapbar.dart';
import 'package:volc/Admin/Service/storeDatabase.dart';
import 'package:volc/SharedModels/store/store.dart';
import 'package:volc/SharedWidgets/shared_functions.dart';
import 'package:volc/User/Model/user_detail.dart';


class StoreHomePage extends StatefulWidget {

  final BuildContext cont;
  final StoreDetail storeDetail;
  StoreHomePage(this.cont,this.storeDetail);
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
  c_width = MediaQuery.of(context).size.width*0.8;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Home Store Page'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right:40.0),
            child: Icon(Icons.message),
          ),
          Padding(
            padding: const EdgeInsets.only(right:20.0),
            child: Icon(Icons.notifications_active),
          ),
        ],
      ),
      
      body:Container(
        child: ListView(children: <Widget>[
          _storeCard(),
          button(),
          ProductsTapBar(),
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
              StoreDatabaseService().test(userDetail.userID);
              print('Done!');
                  Navigator.pop(context);
                    final result = Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddProduct(
                           widget.cont,
                            widget.storeDetail,
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
Widget _storeCard() {
  return Padding(
    padding: EdgeInsets.all(5),
    child: InkWell(
        onTap: () {
          // Navigator.of(context).push(
          //     MaterialPageRoute(builder: (context) => StorePage(
          //       imgPath: imgPath,
          //       storeDiscount:dis,
          //       storeName: name,
          //       cont: widget.cont,
                
          //     )));
        },
    child: Container(
      // height: 50,
      // width: 280,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2.0,
                blurRadius: 4.0)
            ],
        color: Colors.pink[400],
        ),
        child: Column(
          children: [
          Padding(
              padding: EdgeInsets.all(1.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                  //  true ? Icon(Icons.star_half, color: Colors.yellow): Icon(Icons.star,color: Colors.yellow),
                        Text(
                          '5.0',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white
                          ),
                          )
                          ,]
                  ),
                ),
          Hero(
              tag: 'assets/storesImages/netto.png',
              child: Container(
                height: 140.0,
                width: 300.0,
                decoration: BoxDecoration(
                      image: DecorationImage(
                          image: widget.storeDetail.backgroundImage != '' ?
                          NetworkImage(widget.storeDetail.backgroundImage.toString())
                          :AssetImage('assets/storesImages/netto.png'),
                          fit: BoxFit.contain,
                          )
                    ), 
                ),
          ),
          Padding(
              padding: EdgeInsets.all(1.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      Column(children: <Widget>[
                        Text(
                        widget.storeDetail.name,
                        style: TextStyle(
                            fontFamily: 'Varela',
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold)
                      ),
                      Row(children: <Widget>[
                      Icon(Icons.location_on,
                      color: Colors.white,
                        size: 24.0),
                        Text(
                        widget.storeDetail.coveredArea,
                        style: TextStyle(
                            fontFamily: 'Varela',
                            color: Colors.white,
                            fontSize: 18.0)
                      ),
                      ],)  
                      ],),  
                  ])
                  ),
                  ])
                )
            )
          );
}
}