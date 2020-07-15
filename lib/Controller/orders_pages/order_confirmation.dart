import 'package:OpenAndBuy/Controller/constant.dart';
import 'package:OpenAndBuy/Controller/constants/colors.dart';
import 'package:OpenAndBuy/Model/order.dart';
import 'package:OpenAndBuy/Service/order_notifier.dart';
import 'package:OpenAndBuy/Service/order_service.dart';
import 'package:OpenAndBuy/Service/order_service_user_side.dart';
import 'package:OpenAndBuy/Service/store_notifier.dart';
import 'package:OpenAndBuy/Service/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:OpenAndBuy/Model/product.dart';
import 'package:OpenAndBuy/Model/store.dart';
import 'package:OpenAndBuy/Model/user_detail.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class OrderConfirmation extends StatelessWidget {
  final StoreDetail storeDetail;
  final UserDetail userDetail;
  final String orderID;
  OrderConfirmation({this.storeDetail, this.userDetail, this.orderID});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: OrderNotifier(storeID: storeDetail.sid),
      child: Scaffold(
          body: OrderConfirmation2(
              storeDetail: storeDetail,
              userDetail: userDetail,
              orderID: orderID)),
    );
  }
}

class OrderConfirmation2 extends StatefulWidget {
  final StoreDetail storeDetail;
  final UserDetail userDetail;
  final String orderID;
  OrderConfirmation2({this.storeDetail, this.userDetail, this.orderID});

  @override
  _OrderConfirmation2State createState() => _OrderConfirmation2State();
}

class _OrderConfirmation2State extends State<OrderConfirmation2> {
  Order _order = new Order();
  String status = '';
  String note = '';

  @override
  Widget build(BuildContext context) {
    OrderNotifier orderNotifier = Provider.of<OrderNotifier>(context);
    orderNotifier.getOrderDetails(widget.orderID);
    _order = orderNotifier.order;

    status = _order != null ? _order.status : '';
    note = _order != null ? _order.note : '';
    note == null ? note = '' : note;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: APPBARCOLOR,
        title: Text('Thank you for your order!'),
      ),
      body: Container(
        color: BACKGROUNDCOLOR,
        child: ListView(
          children: <Widget>[
            _order != null
                ? (_order.status == 'Accepted'
                    ? completedOrProblemButtons()
                    : Container())
                : Container(),

            _order != null
                ? (_order.status != 'Accepted' &&
                        _order.status != 'Rejected' &&
                        _order.status != 'Completed')
                    ? cancelOrder()
                    : Container()
                : Container(),

            orderStatus(),
            orderMsg(),
            storeDetails(),
            userDetails(),
            trackButton(),
            //  feedback(),
          ],
        ),
      ),
    );
  }

  Widget feedback() {
    return Container(
      child: Column(
        children: <Widget>[
          ListTile(
            //  contentPadding: EdgeInsets.all(20),
            title: Text('Your Feedback',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                )),
            leading: Icon(
              Icons.feedback,
              size: 40,
              color: Colors.blue,
            ),
            subtitle: Text('We really apprciate Your feedback,Thanks',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                )),
          ),
          ListTile(
            // contentPadding: EdgeInsets.all(20),
            title: Text('Share',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                )),
            leading: Icon(
              Icons.share,
              size: 40,
              color: Colors.blue,
            ),
            subtitle: Text('Share it with your friends',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                )),
          ),
          ListTile(
            title: Text('Call the store',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                )),
            leading: Icon(
              Icons.call,
              size: 40,
              color: Colors.blue,
            ),
            subtitle: Text('You can call the store and tell him your issue',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                )),
          )
        ],
      ),
    );
  }

  Widget orderStatus() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: 70,
          width: 400,
          child: Row(
            children: <Widget>[
              Text(
                'Order Status : ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              (status == 'Accepted')
                  ? Container(
                      child: Text(
                      'Accepted!',
                      style: TextStyle(fontSize: 20, color: Colors.green),
                    ))
                  : Text(
                      status,
                      style: TextStyle(fontSize: 20, color: Colors.red),
                    ),
            ],
          )),
    );
  }

  Widget orderMsg() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          width: 400,
          child: Row(
            children: <Widget>[
              Text(
                'Note : ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(note,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  )),
            ],
          )),
    );
  }

  Widget storeDetails() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          color: Colors.blueGrey[50],
          height: 200,
          width: 400,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    // Text('Total Items: 4 Items',),
                    text('Store Name: ', _order != null ? _order.storeName : '',
                        '')
                  ],
                ),
                Row(
                  children: <Widget>[
                    //Text('Subtotal: 303 SEK'),
                    text(
                        'Subtotal: ',
                        _order != null ? _order.totalAmount.toString() : '',
                        '  SEK')
                  ],
                ),
                Row(
                  children: <Widget>[
                    // Text('Delivery Fee: 10 SEK'),
                    text('Tel.  : ',
                        _order != null ? _order.storePhoneNumber : '', '')
                  ],
                ),
                Row(
                  children: <Widget>[
                    // Text('Total Amount: 313 SEK'),
                    text('Address: ', widget.storeDetail.location, '')
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Widget text(txt, value, temp) {
    return Container(
      width: 300,
      child: RichText(
        text: TextSpan(
          text: txt,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.normal, fontSize: 20),
          children: <TextSpan>[
            TextSpan(
                text: value,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
            TextSpan(
              text: temp,
              style:
                  TextStyle(fontWeight: FontWeight.normal, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  Widget userDetails() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          color: Colors.blueGrey[50],
          height: 200,
          width: 400,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    // Text('Total Items: 4 Items',),
                    text(
                        'Name: ',
                        widget.userDetail.firstName +
                            " " +
                            widget.userDetail.lastName,
                        '')
                  ],
                ),
                Row(
                  children: <Widget>[
                    // Text('Delivery Fee: 10 SEK'),
                    text('Tel.  : ', widget.userDetail.phone['number'], '')
                  ],
                ),
                Row(
                  children: <Widget>[
                    // Text('Total Amount: 313 SEK'),
                    text('Address: ', widget.userDetail.address, '')
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Widget trackButton() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Text(
              'We are working or your order NOW! Your Order will be soon in front of your door : ',
              style: TextStyle(color: Colors.black, fontSize: 14)),
          SizedBox(height: 10.0),
          InkWell(
            child: Text(
              'Track',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget completedOrProblemButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        button(problemDailog, 'THERE WAS A PROBLEM', Colors.white),
        button(confirmDailog, 'ORDER COMPLETED', Colors.red),
      ],
    );
  }

  Widget button(Function action, String name, Color color) {
    return RaisedButton(
      onPressed: action, //confirmDailog,
      textColor: Colors.white,
      padding: const EdgeInsets.all(0.0),
      child: Container(
        color: color,
        // decoration: const BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: <Color>[
        //       Colors.red,
        //       Color(0xFF1976D2),
        //       Colors.red,
        //     ],
        //   ),
        // ),
        padding: const EdgeInsets.all(10.0),
        child: Text(name,
            style: TextStyle(
                fontSize: 14,
                color:
                    (name != 'ORDER COMPLETED') ? Colors.black : Colors.white)),
      ),
    );
  }

  confirmDailog() async {
    String review = "";
    return showDialog<String>(
      context: context,
      child: new AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: new Row(
          children: <Widget>[
            new Expanded(
              flex: 100,
              child: new TextField(
                  autofocus: true,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: new InputDecoration(
                      labelText: 'Write A Review',
                      hintText: 'write your review'),
                  onChanged: (val) {
                    setState(() {
                      review = val;
                    });
                  }),
            )
          ],
        ),
        actions: <Widget>[
          new FlatButton(
              child: const Text(
                CANCEL,
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          new FlatButton(
              child: const Text(
                'Confirm',
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () async {
                /// update the store's budget!
                await OrderService.updateStoreBudget(_order.storeID,
                    _order.totalAmount, widget.storeDetail.budget);

                /// Add the Application fees to the total budget
                 await OrderService.updateAppBudget();

                // Edit the order's status
                await OrderService.confirmOrderCompletion(
                    orderID: _order.orderID,
                    storeID: _order.storeID,
                    clientID: _order.clientID);


                

                 // Add review
                (review != "" || review != null)
                    ? OrderService.addReview(_order.storeID, _order.orderID,
                        review, widget.userDetail)
                    : '';
            // regiser the order in the user side (History)
            await OrderServiceUserSide.registerOrderUserHistory(_order);
                // finish
                Navigator.pop(context);
              })
        ],
      ),
    );
  }

  problemDailog() async {
    String review = "";
    return showDialog<String>(
      context: context,
      child: new AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: new Row(
          children: <Widget>[
            new Expanded(
              flex: 100,
              child: new TextField(
                  autofocus: true,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: new InputDecoration(
                      labelText: 'Descripe the problem',
                      hintText: 'write your review'),
                  onChanged: (val) {
                    setState(() {
                      review = val;
                    });
                  }),
            )
          ],
        ),
        actions: <Widget>[
          new FlatButton(
              child: const Text(
                CANCEL,
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          new FlatButton(
              child: const Text(
                'Confirm',
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () async {
                // /// update the store's budget!
                // await OrderService.updateStoreBudget(_order.storeID,
                //     _order.totalAmount, widget.storeDetail.budget);

                // // Edit the order's status
                // await OrderService.confirmOrderCompletion(
                //     orderID: _order.orderID,
                //     storeID: _order.storeID,
                //     clientID: _order.clientID);

                // // Add review
                // (review != "" || review != null)
                //     ? OrderService.addReview(_order.storeID, _order.orderID,
                //         review, widget.userDetail)
                //     : '';

                // finish
                Navigator.pop(context);
              })
        ],
      ),
    );
  }

  Widget cancelOrder() {
    bool deleted = false;
    return Center(
        child: ButtonTheme(
            minWidth: 100,
            height: 40,
            child: RaisedButton(
                elevation: 0.0,
                color: Colors.red,
                highlightColor: Colors.red,
                child: Text(
                  'CANCEL THE ORDER',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                onPressed: () async {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Confirmation'),
                        content: Text('The order will be deleted!'),
                        actions: <Widget>[
                          new FlatButton(
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true).pop(
                                  false); // dismisses only the dialog and returns false
                            },
                            child: Text('No'),
                          ),
                          FlatButton(
                            onPressed: () async {
                              ProgressDialog dialog =
                                  new ProgressDialog(context);
                              dialog.style(message: 'Please wait...');
                              await dialog.show();
                              await OrderService.deleteTheOrder(
                                  orderID: widget.orderID,
                                  clientID: widget.userDetail.userID,
                                  storeID: widget.storeDetail.sid);
                              // await StoreDatabaseService().deleteCategory(newCategory,storeDetail.sid);

                              Navigator.of(context, rootNavigator: true)
                                  .pop(true);
                              deleted = true;
                              await dialog.hide();
                            },
                            child: Text('Yes'),
                          ),
                        ],
                      );
                    },
                  );

                  deleted ? Navigator.of(context).pop('deleted') : null;
                })));
  }
}
