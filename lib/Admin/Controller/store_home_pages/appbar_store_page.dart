import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volc/Admin/Controller/orders/order.dart';
import 'package:volc/Admin/Controller/orders/order_page.dart';
import 'package:volc/Admin/Controller/product/add_product.dart';
import 'package:volc/Admin/Service/order_service.dart';
import 'package:volc/Admin/Service/storeDatabase.dart';
import 'package:volc/SharedModels/product/product.dart';
import 'package:volc/SharedModels/store/category.dart';
import 'package:volc/SharedModels/store/store.dart';
import 'package:volc/SharedWidgets/product_card.dart';
import 'package:volc/User/Model/user_detail.dart';


class TabBarStorePage extends StatefulWidget {
  final BuildContext cont;
  final StoreDetail storeDetail;
  final List<Category>categoriesList;
  final List<Product> productsList;
  final List<Order> orders;
  TabBarStorePage(this.cont,this.storeDetail,this.categoriesList,this.productsList,this.orders);
  @override
  _TabBarStorePageState createState() => _TabBarStorePageState();
}

class _TabBarStorePageState extends State<TabBarStorePage> {
  UserDetail userDetail;
  @override
  Widget build(BuildContext context) {
     
    userDetail = Provider.of<UserDetail>(widget.cont);
    return Scaffold(
      body:  DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home)),
                Tab(icon: messages()),
                Tab(icon:notification(),),
                Tab(icon: Icon(Icons.list)) ,
              ],
            ),
            title: Text('Store Page'),
          ),
          body: TabBarView(
            children: [
              ////////////////////////////
              Container(
                child: ListView(
                  children: <Widget>[
                 // storeCard(widget.storeDetail),
                  button(),
                  productsGridList(null,null,widget.productsList,context,true),
                ],
                ),
              ),
              ///////////////////////////
              messagesList(),
              ///////////////////
              ordersList(),
              ///////////
              Drawer(child: Text('Iam the drawer!'),),
            ],
          ),
        ),
      )
    );
  }
  Widget notification(){
    return GestureDetector(
          // onTap: () {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => OrderNotification(),
          //     ),
          //   );
          // },
          child: new Stack(
            children: <Widget>[
              new IconButton(
                icon: new Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
                onPressed: null,
              ),
              new Positioned(
                  child: new Stack(
                children: <Widget>[
                  new Icon(Icons.brightness_1,
                      size: 20.0, color: Colors.red[700]),
                  new Positioned(
                      top: 3.0,
                      right: 7,
                      child: new Center(
                        child: new Text(
                          widget.orders != null? widget.orders.length.toString():'0',
                          style: new TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500),
                        ),
                      )),
                ],
              )),
            ],
          ),
        
        );
  }
  Widget messages(){
    return GestureDetector(
          // onTap: () {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => OrderNotification(),
          //     ),
          //   );
          // },
          child: new Stack(
            children: <Widget>[
              new IconButton(
                icon: new Icon(
                  Icons.message,
                  color: Colors.white,
                ),
                onPressed: null,
              ),
              new Positioned(
                  child: new Stack(
                children: <Widget>[
                  new Icon(Icons.brightness_1,
                      size: 20.0, color: Colors.red[700]),
                  new Positioned(
                      top: 3.0,
                      right: 7,
                      child: new Center(
                        child: new Text(
                          '0',
                          style: new TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500),
                        ),
                      )),
                ],
              )),
            ],
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
Widget ordersList(){
   return ListView.builder(
        itemCount: widget.orders!=null?widget.orders.length:0,
        itemBuilder: (context,i){
          String img = widget.orders[i].orderImage;
          String status = 'Accepted';
          return ListTile(
          selected: false,
          onTap: (){
           // Navigator.pop(context);
            final result = Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => OrderPage(
                    order:widget.orders[i],
                  )
                )); 
          },
          title: RichText(
            text: TextSpan(
              text: widget.orders[i].orderName,
              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
              children: <TextSpan>[
              TextSpan(text: ' Ordered an order!' , style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal)),
              TextSpan(text:' Total: ${widget.orders[i].totalAmount} SKE ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),
              TextSpan(text:status,style: TextStyle(fontWeight: FontWeight.bold,color: status == 'Accepted'?Colors.green:Colors.red),),
              ],
            ),
          ),
          subtitle: Text( DateTime.now().toString()),
          leading: CircleAvatar(
              backgroundColor: Colors.red,
              backgroundImage: img != ''? NetworkImage(img):AssetImage('assets/profile_picture.png'),
          ),
          );
        },
      );
}
Widget messagesList(){
  return ListView.builder(
        itemCount: 3,
        itemBuilder: (context,i){
          return ListTile(
          title: RichText(
            text: TextSpan(
              text: "Eric Jack",
              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
              children: <TextSpan>[
              TextSpan(text: ' sent you a message!\n', style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal)),
              TextSpan(text:' Hi, Abdu, How are yo...',style: TextStyle(fontWeight: FontWeight.normal,color: Colors.grey),),
              ],
            ),
          ),
          subtitle: Text(' 22 minutes ago'),
          leading: CircleAvatar(
              backgroundColor: Colors.red,
            ),
          );
        },
      );
}
  
}