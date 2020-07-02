import 'package:OpenAndBuy/Model/product.dart';

class Order{
  String orderID;
  String clientID;
  List<Product> items;
  String storeID;
  double totalAmount;
  double  appFee;
  double deleveryFee;
  double discount;
  String time;
  String orderName;
  String orderImage;
  String clientPhoneNumber;
  String storePhoneNumber;
  String storeName;
  String status;
Order({this.orderID,this.clientID,this.items,this.storeID,this.totalAmount,this.appFee,this.deleveryFee,
this.discount,this.time,this.orderName,this.orderImage,this.clientPhoneNumber,this.storePhoneNumber,this.storeName,this.status});
}