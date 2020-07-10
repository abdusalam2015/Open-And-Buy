import 'package:OpenAndBuy/Controller/constants/colors.dart';
import 'package:OpenAndBuy/Controller/home/messages_page.dart';
import 'package:OpenAndBuy/Controller/home/notification_page.dart';
import 'package:OpenAndBuy/Service/order_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:OpenAndBuy/Model/store.dart';
import 'package:OpenAndBuy/Controller/home/cart_page.dart';
import 'package:OpenAndBuy/Model/cart_bloc.dart';
import 'package:OpenAndBuy/Model/user_detail.dart';
import 'package:OpenAndBuy/Service/user_notifier.dart';


class AppBarWidget extends StatefulWidget {
  StoreDetail storeDetail;
  AppBarWidget(this.storeDetail);
  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

UserDetail userInfo;
int activeOrders = 0;
int totalCount = 0;

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    totalCount = 0;
    //activeOrders = 0 ;
    UserNotifier userNotifier = Provider.of<UserNotifier>(context);
    userNotifier.getUserInfo();

    OrderNotifier orderNotifier = Provider.of<OrderNotifier>(context);
    orderNotifier.getActiveOrders(userNotifier.userDetail.userID);

    userInfo = userNotifier.userDetail;

    activeOrders = orderNotifier.activeOrders != null
        ? orderNotifier.activeOrders.length
        : 0;

    //print(orderNotifier.activeOrders);

    var bloc = Provider.of<CartBloc>(context);
    if (bloc.cart.length > 0) {
      totalCount = bloc.cart.values.reduce((a, b) => a + b);
    }
    return AppBar(
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
        messages(userNotifier),
        cart(),
        notification(userNotifier),
      ],
    );
  }

  Widget cart() {
    return widget.storeDetail.sid != '' && widget.storeDetail.sid != null
        ? InkWell(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 20, top: 10, bottom: 10),
              child: new Container(
                  height: 150.0,
                  width: 30.0,
                  child: new Stack(
                    children: <Widget>[
                      new IconButton(
                        icon: Padding(
                          padding: const EdgeInsets.only(left: 12.0, top: 3),
                          child: new Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: null,
                      ),
                      new Positioned(
                          child: new Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: new Icon(Icons.brightness_1,
                                size: 25.0, color: Colors.red),
                          ),
                          new Positioned(
                              top: 4.0,
                              right: 8,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    right: totalCount > 9 ? 0.0 : 5.0),
                                child: new Text(
                                  '$totalCount',
                                  style: new TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ))
                        ],
                      )),
                    ],
                  )),
            ),
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
          )
        : Container();
  }

  Widget notification(UserNotifier userNotifier) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0, top: 10, left: 10.0),
        child: GestureDetector(
          child: new Stack(
            children: <Widget>[
              new IconButton(
                icon: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: new Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ),
                ),
                onPressed: null,
              ),
              new Positioned(
                  child: new Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: new Icon(Icons.brightness_1,
                        size: 25.0, color: Colors.red),
                  ),
                  new Positioned(
                      top: 4.0,
                      right: 8,
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: activeOrders > 9 ? 0.0 : 5.0),
                        child: new Text(
                          activeOrders.toString(),
                          style: new TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500),
                        ),
                      )),
                ],
              )),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotificationPage(
              userDetail: userInfo,
              storeDetail: widget.storeDetail,
            ),
          ),
        );
      },
    );
  }

  Widget messages(UserNotifier userNotifier) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0, top: 10, left: 10.0),
        child: GestureDetector(
          child: new Stack(
            children: <Widget>[
              new IconButton(
                icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Icon(
                    Icons.message,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {},
              ),
              new Positioned(
                  child: new Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: new Icon(Icons.brightness_1,
                        size: 25.0, color: Colors.red),
                  ),
                  new Positioned(
                      top: 4.0,
                      right: 8,
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: activeOrders > 9 ? 0.0 : 5.0),
                        child: new Text(
                          activeOrders.toString(),
                          style: new TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500),
                        ),
                      )),
                ],
              )),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MessagesPage(
              userDetail: userInfo,
              storeDetail: widget.storeDetail,
            ),
          ),
        );
      },
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
