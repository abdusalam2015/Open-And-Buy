import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:OpenAndBuy/Model/order.dart';
import 'package:OpenAndBuy/Controller/store_page.dart';
import 'package:OpenAndBuy/Service/order_service.dart';
import 'package:OpenAndBuy/Service/storeDatabase.dart';
import 'package:OpenAndBuy/Model/product.dart';
import 'package:OpenAndBuy/Model/category.dart';
import 'package:OpenAndBuy/Model/store.dart';
import 'package:OpenAndBuy/Controller/EditUserDetails/account_settings.dart';
import 'package:OpenAndBuy/Controller/EditUserDetails/edit_account.dart';
import 'package:OpenAndBuy/Controller/home/home.dart';
import 'package:OpenAndBuy/Controller/orders_pages/my_orders.dart';
import 'package:OpenAndBuy/Model/user.dart';
import 'package:OpenAndBuy/Model/user_detail.dart';
import 'package:OpenAndBuy/Controller/location/find_my_location.dart';
import 'package:OpenAndBuy/Controller/payment/home_payment.dart';
import 'package:OpenAndBuy/Service/user_notifier.dart';

class DrawerWidget extends StatefulWidget {
  final BuildContext cont;
  final StoreDetail storeDetail;
  final List<Category> categoryList;

  DrawerWidget (this.cont,this.storeDetail,this.categoryList);
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}
 String userID;
class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    // get the all the users details  ==> look at it in the future
    //final userDetail = Provider.of<UserDetail>(widget.cont);
     UserNotifier userNotifier = Provider.of<UserNotifier>(context);
    userNotifier.getUserInfo();
    final userDetail = userNotifier.storeDetail;
    
    
    //get the current user details
     userID = Provider.of<User>(context).uid;

    //double c_width = MediaQuery.of(context).size.width*0.8;
    return  Drawer(
      child:Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              DrawerHeader(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: <Widget>[
                 Container(
                  // tag: userDetail.userID,
                   child: Material(
                     color: Colors.transparent,
                     child: InkWell(
                       onTap: (){
                         Navigator.of(context).push(
                           MaterialPageRoute(
                             builder: (context) => EditAccount (
                               widget.cont,
                             )
                           )
                           );        
                       },
                     child:CircleAvatar(
                       radius: 32.0,
                       backgroundColor: Colors.white,
                       child: CircleAvatar(
                       backgroundImage:userDetail.photoURL.isNotEmpty && userDetail.photoURL != null  ?
                        NetworkImage(userDetail.photoURL.toString())
                        :AssetImage('assets/profile_picture.png'),
                       radius: 30.0,
                      ),
                     ),
                     ),
                   ),
                 ),
                 SizedBox(width: 10),
                   Container(
                     width: 150,
                     child: Text(userDetail.firstName + ' '+userDetail.lastName ,
                     style: TextStyle(color: Colors.white,fontSize: 18),),
                   ),
                 ],
               ),
               decoration: BoxDecoration(
                 color: Colors.black, 
               ),  
            ),
         _setting(),
        //check if we have already a store or still in the homepage.
        //widget.storeDetail.sid != ''? _categories(userDetail) : Container(),
        
         widget.categoryList != null ? _categories() : Container()
      ],
    ),   
  );
  }
Widget _categories(){
   // getData(userDetail);//numberTruthList = [true, true, true, true , true, true];
      return Expanded(
        child: ListView.builder(
        itemCount: widget.categoryList.length,
        itemBuilder: (context, i) {
          return InkWell(
            child:Padding(
              padding: const EdgeInsets.only(left:15.0),
              child: Column(
              //  mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Container( 
                      width: 270,
                      height: 40, 
                      decoration: BoxDecoration(
                       color: Colors.white,
                       boxShadow: [
                        BoxShadow(color: Colors.green, spreadRadius: 3),
                      ],
                      ),
                      
                    child: Text(widget.categoryList[i].name,
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                  ),
                  
                  SizedBox(height: 20)
                ],
              ),
            ),

            onTap: () async{
            StoreDatabaseService obj = new StoreDatabaseService(sid: widget.storeDetail.sid);   
           // List<Category> categoryList =  await obj.getcategories(userDetail.userID) ;
            StoreDetail storeDetail = await obj.getStoreInfo(widget.storeDetail.sid.toString());
            //print('categoryList[0].categoryID: ' + widget.categoryList[0].categoryID);
            List<Product> productsList =  await obj.getStoreProducts(widget.storeDetail.sid,widget.categoryList[i].categoryID) ;
            Navigator.of(context).pop();
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => StorePage(
                  storeDetail:storeDetail,
                  cont: widget.cont,
                  categoryList:widget.categoryList,
                  productsList:productsList,
                )));
          },
          );   
     },
),
  );
  }
  // Future<List<Category>> getData(userDetail) async {
  //   Future.delayed(
  //     Duration(seconds: 3),
  //     () async{
  //     StoreDatabaseService obj = new StoreDatabaseService(sid: userDetail.userID);   
  //     widget.categoryList =  await obj.getcategories(userDetail.userID) ;
  //     }
  //   );
  // //  categoriesList.toList();
  // }
  Widget _setting(){
    return Column(
      children: <Widget>[
        ListTile(
          title: items('Home',Icon(Icons.home)),
             onTap: () async{
              //Navigator.pop(context);//lcose the drawer
            //  StoreDatabaseService obj = new StoreDatabaseService();
            //  List<StoreDetail> storesList= await  obj.getAllStores() ;
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Home(
                  //  widget.cont,
                  //  storesList
                )));
          },
            
          ),
          ListTile(
          title: items('Your Orders',Icon(Icons.history)),
             onTap: ()async{
          OrderService orderService = new OrderService();
           List<Order>orders = await orderService.getUserOrders(userID);
           // print(orders.length.toString() + 'this is the size');
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MyOrders(
                  //widget.cont,
                  orders
                )
              )
            );        
          },
            
          ),
          ListTile(
          title: items('Payment',Icon(Icons.payment)),
            onTap: () {
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => HomePayment(
                  widget.cont,
                )
              )
            ); 
            },
          ),
          ListTile(
          title: items('Favorites',Icon(Icons.favorite)),
            onTap: () {
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => FindMyLocation(
                  widget.cont,
                )
              )
            ); 
            }
          ),
          ListTile(
            title: items('Settings',Icon(Icons.settings)),
             onTap: (){
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AccountSettings(
                  widget.cont,
                )
              )
            );        
          },
        ),
      ],
    );
  }
  Widget items(String name,Icon icon){
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          icon,
          SizedBox(width: 10,),
          Text(name,style: TextStyle(fontSize: 18,),),
        ],
      );       
  }

 Widget itemsCategory(name,icon){
  return  Container(
    color: Colors.greenAccent,
    width: 20,
    height: 35,
    child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            icon,
            SizedBox(width: 10,),
            Text(name,),
          ],
        ),
  );
 }
}