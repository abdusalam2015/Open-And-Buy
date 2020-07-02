import 'package:flutter/material.dart';
import 'package:OpenAndBuy/Model/order.dart';
class MyOrders extends StatefulWidget {
  final List<Order>myOrders ;//= new List<Order>();
  MyOrders(this.myOrders);

  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    //add the abount of orders total 
    int counter = 0 ;
    if(widget.myOrders != null)widget.myOrders.add(Order(totalAmount: 2009.93));
    widget.myOrders !=null ?print(widget.myOrders.length.toString() + 'this is the size'):print('NULLS');
    return Scaffold(
      appBar: AppBar(
        title: Text('MY ORDERS'),
      ),
      body: widget.myOrders != null ? Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
            child: FittedBox(
              child: DataTable(
            columns: [
              DataColumn(label: Text('N')),
              DataColumn(label:  Text('Store Name')),
              DataColumn(label: Text('Date')),
              DataColumn(label: Text('Total')),
            ],
            rows: 
            widget.myOrders.map(
              ((order)=> counter != widget.myOrders.length-1? DataRow(
                cells:<DataCell>[
                    DataCell(Text((++counter).toString())),
                    DataCell(Text(order.storeName.toString())),
                    DataCell(Text('03/04/2020')),
                    DataCell(Text(order.totalAmount.toString())),
              ]):
                
               DataRow(
                cells:<DataCell>[
                    DataCell(Text('Total ')),
                    DataCell(Text('')),
                    DataCell(Text('')),
                    DataCell(Text(order.totalAmount.toString())),
              ]) )).toList(),
          
            
          ),
        ),
        ),
      ): Center(child:Text('No Orders')),
    );
  }
}