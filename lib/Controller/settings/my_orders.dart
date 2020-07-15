import 'package:OpenAndBuy/Controller/constants/colors.dart';
import 'package:OpenAndBuy/Model/localization/localizationConstants.dart';
import 'package:OpenAndBuy/Model/order.dart';
import 'package:flutter/material.dart';

class MyOrders extends StatefulWidget {
  final List<Order> myOrders;
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
                      DataColumn(label: text2(value('n'))),
                      DataColumn(label: text2(value('storeName'))),
                      DataColumn(label: text2(value('date'))),
                      DataColumn(label: text2('Order Status')),
                      DataColumn(label: text2(value('totalOrders'))),
                    ],
                    rows: myOrders
                        .map(((order) => DataRow(cells: <DataCell>[
                              DataCell(text((++counter).toString())),
                              DataCell(text(order.storeName.toString())),
                              DataCell(text(order.time.toString())),
                              DataCell(text(order.status.toString())),
                              DataCell(text(order.totalAmount.toString())),
                            ])))
                        .toList(),
                  ),
                ),
              ),
            )
          : Center(child: Text(value('noOrders'))),
    );
    
  }
  Widget text(String value){
    return Text(
      value,style: TextStyle(color: Colors.black,fontSize: 24),
    );
  }
   Widget text2(String value){
    return Text(
      value,style: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.bold),
    );
  }

}
