import 'package:OpenAndBuy/Controller/constant.dart';
import 'package:OpenAndBuy/Model/app_budget.dart';
import 'package:OpenAndBuy/Model/message.dart';
import 'package:OpenAndBuy/Model/order.dart';
import 'package:OpenAndBuy/Model/product.dart';
import 'package:OpenAndBuy/Model/user_detail.dart';
import 'package:OpenAndBuy/Service/order_service_user_side.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderService {
  Order orderDetail;
  OrderService({this.orderDetail});

  Future<String> registerAnOrderInTheStoreDB() async {
    final DocumentReference storeCollection = Firestore.instance
        .collection('stores')
        .document(orderDetail.storeID)
        .collection('Orders')
        .document();
    await storeCollection.setData({
      //17
      'orderID': storeCollection.documentID,
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
    await registerOrderProducts(storeCollection.documentID);

// update the order and register it in the user
    orderDetail.orderID = storeCollection.documentID;
    OrderServiceUserSide orderUserSide =
        new OrderServiceUserSide(orderDetail: orderDetail);
    orderUserSide.registerAnOrderInTheUserDB();
    return orderDetail.orderID;
  }

  final CollectionReference storeCollection2 =
      Firestore.instance.collection('stores');
  registerOrderProducts(orderID) async {
    Product product;
    try {
      for (int i = 0; i < orderDetail.items.length; i++) {
        product = orderDetail.items[i];
        await storeCollection2
            .document(orderDetail.storeID)
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
    } catch (e) {
      print(e.toString() + 'Iam inside registerOrderProducts function');
      return;
    }
  }

  Future getStoreProducts(String storeID, String categoryID) async {
    try {
      var firestore = Firestore.instance;
      QuerySnapshot qn = await firestore
          .collection('stores')
          .document(storeID)
          .collection('categories')
          .document(categoryID)
          .collection('products')
          .getDocuments();
      return qn.documents.map((doc) {
        return Product(
            id: doc.data['productID'],
            name: doc.data['name'],
            imgPath: doc.data['image'],
            price: doc.data['price'],
            info: doc.data['ProductInfo']);
      }).toList();
    } catch (e) {
      print(e.toString() + 'Iam inside getStoreProducts function');
      return;
    }
  }

  static Future getTheOrderItemsToAllOrders(List<Order> myOrders) async {
    try {
      for (int i = 0; i < myOrders.length; i++) {
        // UserDetail client = await getClientInfo(myOrders[i].clientID);
        // await editClientDataInTheOrdersSection(myOrders[i], client);
        // myOrders[i].orderImage = client.photoURL;
        // myOrders[i].clientPhoneNumber = client.phoneNumber;
        // myOrders[i].orderName = client.firstName + ' ' + client.lastName;
        // myOrders[i].clientAddress = client.address;

        var firestore = Firestore.instance;
        String userID = myOrders[i].clientID;
        String orderID = myOrders[i].orderID;
        String storeID = myOrders[i].storeID;

        QuerySnapshot qn = await firestore
            .collection('users')
            .document(userID)
            .collection('Stores')
            .document(storeID)
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
      print(e.toString() + 'I am yyinside getTheOrderItems function');
      return;
    }
  }

// _ago(Timestamp t) {
//   DateFormat.yMMMd().format(t);
//   TimeRange.fromJson(_json)
//   return timeago.format(t.toDate(), 'en_short');
// }
  static Future getOrders(String userID, String storeID) async {
    try {
      var firestore = Firestore.instance;
      QuerySnapshot qn = await firestore
          .collection('users')
          .document(userID)
          .collection('Stores')
          .document(storeID)
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
            totalAmount: doc.data['totalAmount'], //
            appFee: doc.data['appFee'], //
            deleveryFee: doc.data['deleveryFee'], //
            discount: doc.data['discount'], //
            time: time, //
            orderName: doc.data['OrderName'], //
            orderImage: doc.data['OrderImage'], //
            storeName: doc.data['storeName'], //
            clientPhoneNumber: doc.data['clientPhoneNumber'],
            note: doc.data['note'], //
            status: doc.data['status'], //
            clientAddress: doc.data['clientAddress'],
            services: doc.data['services'],
            storePhoneNumber: doc.data['storePhoneNumber']); //
      }).toList();
      myOrders = await getTheOrderItemsToAllOrders(myOrders);
      return myOrders;
    } catch (e) {
      print(e.toString() + 'I kkkam inside getOrders function');
      return null;
    }
  }

  Future getUserOrders(String userID, String storeID) async {
    try {
      var firestore = Firestore.instance;
      QuerySnapshot qn = await firestore
          .collection('users')
          .document(userID)
          .collection('Stores')
          .document(storeID)
          .collection('Orders')
          .getDocuments();
      var myOrders = qn.documents.map((doc) {
        List<Product>
            items; //await getTheOrderItems(doc.data['storeID'],doc.data['orderID']);
        //      DateTime now = DateTime.now();
        //  String formattedTime = DateFormat.jm().format(now);
        return Order(
            orderID: doc.data['orderID'], //storeCollection.documentID,
            clientID: doc.data['clientID'],
            items: items,
            storeID: doc.data['storeID'],
            totalAmount: doc.data['totalAmount'],
            appFee: doc.data['appFee'],
            deleveryFee: doc.data['deleveryFee'],
            discount: doc.data['discount'],
            time: doc.data['timestamp'].toString(),
            orderName: doc.data['OrderName'],
            orderImage: doc.data['OrderImage'],
            clientPhoneNumber: doc.data['clientPhoneNumber'],
            storeName: doc.data['storeName'],
            storePhoneNumber: doc.data['storePhoneNumber']);
      }).toList();
      //return myOrders;
      myOrders = await getItemsToAllOrders(myOrders);
      return myOrders;
    } catch (e) {
      print(e.toString() + 'Iam inside getUserOrders function');
      return null;
    }
  }

  Future getItemsToAllOrders(List<Order> myOrders) async {
    //String storeID, String orderID
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
        //String x = qn.documents[0].documentID;
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
        return myOrders;
      }
    } catch (e) {
      print(e.toString() + 'Iam inside getItemsToAllOrders function');
      return;
    }
  }

  // final CollectionReference storeCollection =
  //     Firestore.instance.collection('stores');
  Future editOrderStatus(
      Order order, String status, String message, double currentBudget) async {
    final CollectionReference storeCollection =
        Firestore.instance.collection('stores');
    final CollectionReference userCollection =
        Firestore.instance.collection('users');
    await storeCollection
        .document(order.storeID)
        .collection('Orders')
        .document(order.orderID)
        .updateData({
      'status': status,
      'note': message,
    });
    // update the order in the user side
    await userCollection
        .document(order.clientID)
        .collection('Stores')
        .document(order.storeID)
        .collection('Orders')
        .document(order.orderID)
        .updateData({
      'status': status,
      'note': message,
    });
  }

  static Future updateStoreBudget(
      String storeID, double currentBudget, double newOrderVlaue) async {
    print(currentBudget);
    print(newOrderVlaue);

    double newTotal = currentBudget + newOrderVlaue;
    final CollectionReference storeCollection =
        Firestore.instance.collection('stores');
    await storeCollection.document(storeID).updateData({
      'budget': newTotal,
    });
  }

  static Future updateAppBudget() async {
    // get the current budget and the number of orders
    ApplicationBudget appBudgetInfo = await getAppBudget();
    double newBudget =
        appBudgetInfo.currentBudget + appBudgetInfo.applicationFee;
    double ordersNumber = appBudgetInfo.numberOfOrders + 1.0;

    final CollectionReference appCollection =
        Firestore.instance.collection('ApplicationBudget');
    await appCollection.document(APPLICATIONID).setData({
      'budget': newBudget,
      'numberOfOrders': ordersNumber,
      'ApplicationFees': APPLICATIONFEES,
    });
    return true;
  }

  static Future<ApplicationBudget> getAppBudget() async {
    ApplicationBudget applicationBudgetDetails = new ApplicationBudget();
    await Firestore.instance
        .collection('ApplicationBudget')
        .document(APPLICATIONID)
        .get()
        .then((onValue) {
      applicationBudgetDetails.numberOfOrders =
          onValue['numberOfOrders'] ?? 0.0;
      applicationBudgetDetails.currentBudget = onValue['budget'] ?? 0.0;
      applicationBudgetDetails.applicationFee =
          onValue['ApplicationFees'] ?? 0.0;
    });
    return applicationBudgetDetails;
  }

  static Future editClientDataInTheOrdersSection(
      Order order, UserDetail client) async {
    final CollectionReference _storeCollection =
        Firestore.instance.collection('stores');
    await _storeCollection
        .document(order.storeID)
        .collection('Orders')
        .document(order.orderID)
        .updateData({
      'OrderName': client.firstName + ' ' + client.lastName,
      'OrderImage': client.photoURL,
      'clientPhoneNumber': client.phoneNumber,
      'clientAddress': client.address,
    });
  }

  static Future getClientInfo(String clientID) async {
    UserDetail _clientDetail;
    try {
      await Firestore.instance
          .collection('users')
          .document(clientID)
          .get()
          .then((doc) {
        _clientDetail = UserDetail(
          email: doc.data['email'],
          userID: doc.data['userID'],
          firstName: doc.data['first_name'] ?? '',
          lastName: doc.data['last_name'] ?? '',
          photoURL: doc.data['photoURL'] ?? '',
          address: doc.data['address'] ?? '',
          phoneNumber: doc.data['phone_number'] ?? '',
          latitude: doc.data['latitude'] ?? '',
          longitude: doc.data['longitude'] ?? '',
        );
      });
      return _clientDetail;
    } catch (e) {
      print('Iam inside getStoreInfo funciton ' + e.toString());
      return null;
    }
  }

  static int getNumberOfUncheckedOrders(List<Order> orders) {
    int count = 0;
    if (orders != null) {
      for (int i = 0; i < orders.length; i++) {
        if (orders[i].status != 'Completed' && orders[i].status != REJECTED)
          count++;
      }
    }
    return count;
  }

  static Future<Order> getOrder(String sid, String orderID) async {
    try {
      Order order = new Order();
      List<Product> items = [];
      var firestore = Firestore.instance;
      await firestore
          .collection('stores')
          .document(sid)
          .collection('Orders')
          .document(orderID)
          .get()
          .then((doc) {
        order = Order(
            orderID: doc.data['orderID'], //
            clientID: doc.data['clientID'], //
            items: items, //
            storeID: doc.data['storeID'], //
            totalAmount: doc.data['totalAmount'], //
            appFee: doc.data['appFee'], //
            deleveryFee: doc.data['deleveryFee'], //
            discount: doc.data['discount'], //
            time: (doc.data['timestamp'] as Timestamp)
                .toDate()
                .toUtc()
                .toString(),
            orderName: doc.data['OrderName'], //
            orderImage: doc.data['OrderImage'], //
            storeName: doc.data['storeName'], //
            clientPhoneNumber: doc.data['clientPhoneNumber'],
            note: doc.data['note'], //
            status: doc.data['status'], //
            clientAddress: doc.data['clientAddress'],
            services: doc.data['services'],
            storePhoneNumber: doc.data['storePhoneNumber']);
      });
      order = await getTheOrderItems(order);
      return order;
    } catch (e) {
      print(e.toString() + 'I am inside get the Order function');
      return null;
    }
  }

  static Future getTheOrderItems(Order order) async {
    try {
      var firestore = Firestore.instance;
      QuerySnapshot qn = await firestore
          .collection('stores')
          .document(order.storeID)
          .collection('Orders')
          .document(order.orderID)
          .collection('Products')
          .getDocuments();
      order.items = qn.documents.map((doc) {
        return Product(
          name: doc.data['name'],
          price: doc.data['price'],
          info: doc.data['ProductInfo'],
          id: doc.data['productID'],
          imgPath: doc.data['image'],
          numberOfItemsForAnOrder: doc.data['NumberOfItems'],
        );
      }).toList();

      return order;
    } catch (e) {
      print(e.toString() + 'I   am inside getTheOrderItems function');
      return;
    }
  }

  static Future<List<Order>> getActiveOrders(
      String storeID, String userID) async {
    try {
      var firestore = Firestore.instance;
      QuerySnapshot qn = await firestore
          .collection('users')
          .document(userID)
          .collection('Stores')
          .document(storeID)
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
            totalAmount: doc.data['totalAmount'], //
            appFee: doc.data['appFee'], //
            deleveryFee: doc.data['deleveryFee'], //
            discount: doc.data['discount'], //
            time: time, //
            orderName: doc.data['OrderName'], //
            orderImage: doc.data['OrderImage'], //
            storeName: doc.data['storeName'], //
            clientPhoneNumber: doc.data['clientPhoneNumber'],
            note: doc.data['note'], //
            status: doc.data['status'], //
            clientAddress: doc.data['clientAddress'],
            services: doc.data['services'],
            storePhoneNumber: doc.data['storePhoneNumber']);
      }).toList();
      myOrders = await getTheOrderItemsToAllOrders(myOrders);
      return myOrders;
    } catch (e) {
      print(e.toString() + 'I am inside getOrders function');
      return null;
    }
  }

  static Future<List<Message>> getMessages(String userID) {
    List<Message> messages = new List<Message>();
    // get the messages!
    return null;
  }

  static Future<bool> confirmOrderCompletion(
      {String orderID, String storeID, String clientID}) async {
    final CollectionReference storeCollection =
        Firestore.instance.collection('stores');

    await storeCollection
        .document(storeID)
        .collection('Orders')
        .document(orderID)
        .updateData({
      'status': 'Completed',
    });

    // update the order in the user side

    final CollectionReference userCollection =
        Firestore.instance.collection('users');
    await userCollection
        .document(clientID)
        .collection('Stores')
        .document(storeID)
        .collection('Orders')
        .document(orderID)
        .updateData({
      'status': 'Completed',
    });

    return true;
  }

  static Future<bool> addReview(String storeID, String orderID, String body,
      UserDetail userDetail) async {
    final CollectionReference storeCollection =
        Firestore.instance.collection('stores');
    await storeCollection
        .document(storeID)
        .collection('reviews')
        .document()
        .setData({
      'body': body,
      'userID': userDetail.userID,
      'orderID': orderID,
      'userName': userDetail.firstName + userDetail.lastName,
      'date': DateTime.now(),
    });
    return true;
  }

  static Future<bool> deleteTheOrder(
      {String orderID, String storeID, String clientID}) async {
    final CollectionReference storeCollection =
        Firestore.instance.collection('stores');

    await storeCollection
        .document(storeID)
        .collection('Orders')
        .document(orderID)
        .delete();

    // delete the order in the user side

    final CollectionReference userCollection =
        Firestore.instance.collection('users');
    await userCollection
        .document(clientID)
        .collection('Stores')
        .document(storeID)
        .collection('Orders')
        .document(orderID)
        .delete();
    return true;
  } 
}
