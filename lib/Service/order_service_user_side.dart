import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:OpenAndBuy/Model/order.dart';
import 'package:OpenAndBuy/Model/product.dart';

class OrderServiceUserSide {
  Order orderDetail;
  OrderServiceUserSide({this.orderDetail});

  Future registerAnOrderInTheUserDB() async {
    final DocumentReference orderCollection = Firestore.instance
        .collection('users')
        .document(orderDetail.clientID)
        .collection('Orders')
        .document(orderDetail.storeID)
        .collection('Orders')
        .document(orderDetail.orderID);
    await orderCollection.setData({
      'orderID': orderCollection.documentID,
      'clientID': orderDetail.clientID,
      'storeID': orderDetail.storeID,
      'totalAmount': orderDetail.totalAmount,
      'deleveryFee': orderDetail.deleveryFee,
      'appFee': orderDetail.appFee,
      'discount': orderDetail.discount,
      'timestamp': DateTime.now(), //toUtc().millisecondsSinceEpoch,
      'OrderName': orderDetail.orderName,
      'OrderImage': orderDetail.orderImage,
      'clientPhoneNumber': orderDetail.clientPhoneNumber,
      'storePhoneNumber': orderDetail.storePhoneNumber,
      'storeName': orderDetail.storeName,
      'status': orderDetail.status,
      'note': orderDetail.note,
      'clientAddress': orderDetail.clientAddress,
    });
    //   FieldValue serverTimestamp() =>FieldValue._(_factory.serverTimestamp());

    await registerOrderProducts(orderCollection.documentID);
  }

  final CollectionReference storeCollection2 =
      Firestore.instance.collection('users');

  registerOrderProducts(orderID) async {
    Product product;
    for (int i = 0; i < orderDetail.items.length; i++) {
      product = orderDetail.items[i];
      await storeCollection2
          .document(orderDetail.clientID)
          .collection('Orders')
          .document(orderID)
          .collection('products')
          .document(product.id)
          .setData({
        'name': product.name,
        'price': product.price,
        'ProductInfo': product.info,
        'productID': product.id,
        'image': product.imgPath,
        'NumberOfItems': product.numberOfItemsForAnOrder,
      });
    }
  }
}
