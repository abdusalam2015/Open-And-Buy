import 'package:OpenAndBuy/Controller/constants/colors.dart';
import 'package:OpenAndBuy/Controller/orders_pages/order_confirmation.dart';
import 'package:OpenAndBuy/Model/localization/localizationConstants.dart';
import 'package:OpenAndBuy/Model/store.dart';
import 'package:OpenAndBuy/Model/user_detail.dart';
import 'package:OpenAndBuy/Service/order_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatelessWidget {
  StoreDetail storeDetail;
  UserDetail userDetail;
  NotificationPage( {this.storeDetail, this.userDetail});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: OrderNotifier(storeID: storeDetail.sid),
      child: NotificationPage2(
        storeDetail: storeDetail,
        userDetail: userDetail,
      ),
    );
  }
}

class NotificationPage2 extends StatefulWidget {
  StoreDetail storeDetail;
  UserDetail userDetail;
  NotificationPage2({this.storeDetail, this.userDetail});
  @override
  _NotificationPage2State createState() => _NotificationPage2State();
}

class _NotificationPage2State extends State<NotificationPage2> {
  String value(String key) {
    return getTranslated(context, key);
  }

  @override
  Widget build(BuildContext context) {
    OrderNotifier orderNotifier = Provider.of<OrderNotifier>(context);
    orderNotifier.getActiveOrders(widget.userDetail.userID);
    //print(orderNotifier.activeOrders.length);

    return Scaffold(
      appBar: AppBar(backgroundColor: APPBARCOLOR, title: Text(value('title'))),
      body: (orderNotifier.activeOrders != null)
          ? (orderNotifier.activeOrders.length != 0)
              ? ordersList(orderNotifier)
              : Center(child: Text(value('noNotification')))
          : Center(child: Text(value('noNotification'))),
    );
  }

  Widget ordersList(OrderNotifier orderNotifier) {
    return orderNotifier.activeOrders != null
        ? ListView.builder(
            itemCount: orderNotifier.activeOrders != null
                ? orderNotifier.activeOrders.length
                : 0,
            itemBuilder: (context, i) {
              String img = orderNotifier.activeOrders[i].orderImage;
              String status = orderNotifier.activeOrders[i].status;
              return ListTileTheme(
                selectedColor: Colors.blueAccent,
                child: ListTile(
                  selected: status == '' ? false : true,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => OrderConfirmation(
                              storeDetail: widget.storeDetail,
                              userDetail: widget.userDetail,
                              orderID: orderNotifier.activeOrders[i].orderID,
                            )));
                  },
                  title: RichText(
                    text: TextSpan(
                      text: 'Check Your Order  ',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                          text: value('total') +
                              ' ${orderNotifier.activeOrders[i].totalAmount} SKE \n',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                        TextSpan(
                          text: "Store Name:  ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: status == 'Accepted'
                                  ? Colors.black
                                  : Colors.black),
                        ),
                        TextSpan(
                          text: orderNotifier.activeOrders[i].storeName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: status == 'Accepted'
                                  ? Colors.green
                                  : Colors.red),
                        ),
                      ],
                    ),
                  ),
                  subtitle: Text(orderNotifier.activeOrders[i].time.toString()),
                  leading: CircleAvatar(
                    backgroundColor: Colors.red,
                    backgroundImage: img != ''
                        ? NetworkImage(img)
                        : AssetImage('assets/profile_picture.png'),
                  ),
                ),
              );
            },
          )
        : Center(child: Text(value('noOrders')));
  }
}
