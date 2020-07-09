import 'package:OpenAndBuy/Controller/constants/colors.dart';
import 'package:OpenAndBuy/Controller/settings/my_orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:OpenAndBuy/Model/order.dart';
import 'package:OpenAndBuy/Service/order_service.dart';
import 'package:OpenAndBuy/Service/storeDatabase.dart';
import 'package:OpenAndBuy/Model/product.dart';
import 'package:OpenAndBuy/Model/category.dart';
import 'package:OpenAndBuy/Model/store.dart';
import 'package:OpenAndBuy/Controller/alert_message.dart';
import 'package:OpenAndBuy/Controller/home/cart_page.dart';
import 'package:OpenAndBuy/Model/cart_bloc.dart';
import 'package:OpenAndBuy/Model/setting.dart';
import 'package:OpenAndBuy/Model/user_detail.dart';
import 'package:OpenAndBuy/Service/user_notifier.dart';

class AppBarWidget extends StatefulWidget {
  final StoreDetail storeDetail;
  AppBarWidget(this.storeDetail);
  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

UserDetail userInfo;

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    UserNotifier userNotifier = Provider.of<UserNotifier>(context);
    userNotifier.getUserInfo();
    userInfo = userNotifier.userDetail;
    var bloc = Provider.of<CartBloc>(context);
    int totalCount = 0;
    if (bloc.cart.length > 0) {
      totalCount = bloc.cart.values.reduce((a, b) => a + b);
    }
    return  AppBar(
        backgroundColor: APPBARCOLOR,
        elevation: 0.0,
        centerTitle: true,
        // leading: IconButton(
        //   icon: arrBack? Icon(Icons.arrow_back, color: Colors.white) :Icon(Icons.list, color: Colors.white),
        //   onPressed: () {
        //     if(arrBack){
        //     Navigator.of(context).pop();
        //     }
        //   },
        // ),
        title: Text('Shoping Now',
            style: TextStyle(
              fontFamily: 'Varela',
              fontSize: 18.0,
              color: Colors.white,
            )),
        actions: <Widget>[
          widget.storeDetail.sid != '' && widget.storeDetail.sid != null
              ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: new Container(
                      height: 150.0,
                      width: 30.0,
                      child: new GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CartPage(
                                widget.storeDetail,
                                userInfo,
                              ),
                            ),
                          );
                        },
                        child: new Stack(
                          children: <Widget>[
                            new IconButton(
                              icon: new Icon(
                                Icons.shopping_cart,
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
                                        '$totalCount',
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
                      )),
                )
              : Container(),
          IconButton(
            icon: Icon(Icons.history, color: Colors.white),
            onPressed: () async {
              await userNotifier.getOrders();
              Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyOrders(userNotifier.orders),
                            ),
                          );
            },
          ),
        ],
      
    );
  }

// void actionChoice(String choice){
//     if(choice == 'signUp'){
//        Navigator.of(context).push(
//           MaterialPageRoute(builder: (context) => SignUp(
//         )));
//     }else if(choice == 'Feedback'){
//          Navigator.of(context).push(
//           MaterialPageRoute(builder: (context) => SignUp(
//         )));
//     }else if(choice == 'signIn'){
//         Navigator.of(context).push(
//           MaterialPageRoute(builder: (context) => SignIn(
//         )));
//     }else{
//         print('object');

//     }
//   }
}
