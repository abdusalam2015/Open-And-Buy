import 'package:flutter/material.dart';
import 'package:OpenAndBuy/Model/order.dart';
class OrderPage extends StatefulWidget {
  final Order order;
  OrderPage({this.order});
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Page'),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: (){},
            child: Text('Accept'),
            color: Colors.green,
          ),
          RaisedButton(
            onPressed: (){ },
            child: Text('Reject'),
            color: Colors.red,
          ),
          Container(
            child : Column(
              children: <Widget>[
                Text('Call '+widget.order.orderName),
                Text('Call '+widget.order.clientPhoneNumber),
              ],
            ),
          ),
        ],
      ),
      );
  }
}