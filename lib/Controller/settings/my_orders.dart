import 'package:OpenAndBuy/Controller/constants/colors.dart';
import 'package:OpenAndBuy/Model/localization/localizationConstants.dart';
import 'package:OpenAndBuy/Model/order.dart';
import 'package:OpenAndBuy/Model/user_detail.dart';
import 'package:OpenAndBuy/Service/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyOrders extends StatefulWidget {
  List<Order> myOrders;
  MyOrders(this.myOrders);
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

List<Order> myOrders = [];

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    String value(String key) {
      return getTranslated(context, key);
    }

    myOrders = widget.myOrders;
    //add the abount of orders total
    int counter = 0;
    // if(myOrders != null) myOrders.add(Order(totalAmount: 2009.93));
    //  myOrders != null ? print(myOrders.length.toString() + 'this is the size'):print('NULLS');

    return Scaffold(
      appBar: AppBar(
        title: Text(value('myOrders')),
        backgroundColor: APPBARCOLOR,
      ),
      body: myOrders != null
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: FittedBox(
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text(value('n'))),
                      DataColumn(label: Text(value('clientName'))),
                      DataColumn(label: Text(value('date'))),
                      DataColumn(label: Text(value('totalOrders'))),
                    ],
                    rows: myOrders
                        .map(((order) => DataRow(cells: <DataCell>[
                              DataCell(Text((++counter).toString())),
                              DataCell(Text(order.storeName.toString())),
                              DataCell(Text('03/04/2020')),
                              DataCell(Text(order.totalAmount.toString())),
                            ])))
                        .toList(),
                  ),
                ),
              ),
            )
          : Center(child: Text(value('noOrders'))),
    );
  }
}
