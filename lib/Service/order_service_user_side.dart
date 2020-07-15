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
        .collection('Stores')
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
      'services': orderDetail.services??0.0

    });
    //   FieldValue serverTimestamp() =>FieldValue._(_factory.serverTimestamp());

    await registerOrderProducts(
        orderCollection.documentID, orderDetail.storeID);
  }

  final CollectionReference storeCollection2 =
      Firestore.instance.collection('users');

  registerOrderProducts(String orderID, String storeID) async {
    Product product;
    for (int i = 0; i < orderDetail.items.length; i++) {
      product = orderDetail.items[i];
      await storeCollection2
          .document(orderDetail.clientID)
          .collection('Stores')
          .document(storeID)
          .collection('Orders')
          .document(orderID)
          .collection('Products')
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

  static Future registerOrderUserHistory(Order orderDetail) async {
    final DocumentReference orderCollection = Firestore.instance
        .collection('users')
        .document(orderDetail.clientID)
        .collection('Orders')
        .document(orderDetail.orderID);
    await orderCollection.setData({
      'orderID': orderDetail.orderID,
      'clientID': orderDetail.clientID,
      'storeID': orderDetail.storeID,
      'totalAmount':  orderDetail.totalAmount ,
      'deleveryFee':  orderDetail.deleveryFee  ,
      'appFee':  orderDetail.appFee ,
      'discount': orderDetail.discount  ,
      'timestamp': orderDetail.time, //toUtc().millisecondsSinceEpoch,
      'OrderName': orderDetail.orderName,
      'OrderImage': orderDetail.orderImage,
      'clientPhoneNumber': orderDetail.clientPhoneNumber,
      'storePhoneNumber': orderDetail.storePhoneNumber,
      'storeName': orderDetail.storeName,
      'status': orderDetail.status,
      'note': orderDetail.note,
      'clientAddress': orderDetail.clientAddress,
      'services': orderDetail.services ??0.0
    });
    //   FieldValue serverTimestamp() =>FieldValue._(_factory.serverTimestamp());

    await registerOrderProductsHistory(orderDetail);
  }

  static Future registerOrderProductsHistory(Order orderDetail) async {
    Product product;
    final CollectionReference storeCollection =
        Firestore.instance.collection('users');
    for (int i = 0; i < orderDetail.items.length; i++) {
      product = orderDetail.items[i];
      await storeCollection
          .document(orderDetail.clientID)
          .collection('Orders')
          .document(orderDetail.orderID)
          .collection('Products')
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

  static Future getUserOrdersHistory(String userID) async {
    try {
      var firestore = Firestore.instance;
      QuerySnapshot qn = await firestore
          .collection('users')
          .document(userID)
          .collection('Orders')
          .getDocuments();
      var myOrders = qn.documents.map((doc) {
        List<Product> items = [];
        Timestamp t = doc.data['timestamp'] as Timestamp;
        String time = t.toDate().toUtc().toString();

        return Order(
            orderID: doc.data['orderID'], //
            clientID: doc.data['clientID'], //
            items: items, //
            storeID: doc.data['storeID'], //
            totalAmount:
                double.parse(doc.data['totalAmount'].toString()) ?? 0.0, //
            appFee: double.parse(doc.data['appFee'].toString()) ?? 0.0, //
            deleveryFee:
                double.parse(doc.data['deleveryFee'].toString()) ?? 0.0, //
            discount: double.parse(doc.data['discount'].toString()) ?? 0.0, //
            time: time, //
            orderName: doc.data['OrderName'], //
            orderImage: doc.data['OrderImage'], //
            storeName: doc.data['storeName'], //
            clientPhoneNumber: doc.data['clientPhoneNumber'],
            note: doc.data['note'], //
            status: doc.data['status'], //
            clientAddress: doc.data['clientAddress'], //
            services: double.parse(doc.data['services'].toString()) ?? 0.0, //
            storePhoneNumber: doc.data['storePhoneNumber']); //
      }).toList();
      myOrders = await getTheOrderItemsToAllOrders(myOrders);
      return myOrders;
    } catch (e) {
      print(e.toString() + ' I am inside getUserOrdersHistory function');
      return null;
    }
  }

  static Future getTheOrderItemsToAllOrders(List<Order> myOrders) async {
    try {
      for (int i = 0; i < myOrders.length; i++) {
        var firestore = Firestore.instance;
        String userID = myOrders[i].clientID;
        String orderID = myOrders[i].orderID;

        QuerySnapshot qn = await firestore
            .collection('users')
            .document(userID)
            .collection('Orders')
            .document(orderID)
            .collection('Products')
            .getDocuments();
        myOrders[i].items = qn.documents.map((doc) {
          return Product(
            name: doc.data['name'],
            price: doc.data['price'],
            info: doc.data['ProductInfo'],
            id: doc.data['productID'],
            imgPath: doc.data['image'],
            numberOfItemsForAnOrder: doc.data['NumberOfItems'],
          );
        }).toList();
      }
      return myOrders;
    } catch (e) {
      print(e.toString() +
          'I am inside getTheOrderItemsToAllOrders function USER SIDE');
      return;
    }
  }
}
