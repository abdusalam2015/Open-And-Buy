import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:volc/Admin/Controller/orders/order.dart';
import 'package:volc/SharedModels/product/product.dart';
import 'package:volc/User/Service/order_service_user_side.dart';

class OrderService{
   Order orderDetail;
  OrderService({this.orderDetail});


Future registerAnOrderInTheStoreDB() async{
  final DocumentReference storeCollection =   Firestore.instance.collection('stores').
  document(orderDetail.storeID).collection('Orders').document();
  
  await storeCollection.setData({
    'orderID':   storeCollection.documentID,
    'clientID':  orderDetail.clientID ,
    'storeID':  orderDetail.storeID ,
    'totalAmount':  orderDetail.totalAmount,
    'deleveryFee':  orderDetail.deleveryFee,
    'appFee':  orderDetail.appFee,
    'discount':  orderDetail.discount,
    'timestamp': DateTime.now(),//toUtc().millisecondsSinceEpoch,
    'OrderName': orderDetail.orderName,
    'OrderImage': orderDetail.orderImage,
    'clientPhoneNumber': orderDetail.clientPhoneNumber  ,
    'storePhoneNumber': orderDetail.storePhoneNumber,
    'storeName' : orderDetail.storeName,
    'status': orderDetail.status,
  });
    //   FieldValue serverTimestamp() =>FieldValue._(_factory.serverTimestamp());
     await registerOrderProducts(storeCollection.documentID);

// update the order and register it in the user
    orderDetail.orderID = storeCollection.documentID;
    print(orderDetail.orderID+" HEY");
     OrderServiceUserSide orderUserSide = new OrderServiceUserSide(orderDetail:orderDetail);
     orderUserSide.registerAnOrderInTheUserDB();
  }

final CollectionReference storeCollection2 =  Firestore.instance.collection('stores');

registerOrderProducts(orderID) async{
Product product;
try{
for(int i = 0 ; i < orderDetail.items.length; i++){
  product = orderDetail.items[i]; 
  await storeCollection2.document(orderDetail.storeID).collection('Orders').
  document(orderID).collection('products').document(product.id).
    setData({
        'name':  product.name ,
        'price': product.price ,
        'ProductInfo':  product.info ,
        'productID':  product.id ,
       'image':  product.imgPath ,
       'NumberOfItems': product.numberOfItemsForAnOrder ,
    });
  }
  }catch(e){
      print(e.toString()+ 'Iam inside registerOrderProducts function');
      return ;
    }
}
Future getStoreProducts(String storeID,String categoryID ) async {
    try{
var firestore = Firestore.instance;
  QuerySnapshot qn = await  firestore.collection('stores').
    document(storeID).collection('categories').document(categoryID).
    collection('products').getDocuments();
     return qn.documents.map( (doc) {
       return Product(
         id:doc.data['productID'],
         name:doc.data['name'],
         imgPath: doc.data['image'],
         price: doc.data['price'],
         info: doc.data['ProductInfo']
        );
      }).toList(); 
    }catch(e){
      print(e.toString()+ 'Iam inside getStoreProducts function');
      return ;
    }
}


 Future getTheOrderItemsToAllOrders(List<Order> myOrders)async{
   //String storeID, String orderID
  try{
    for(int i = 0 ; i <myOrders.length;i++ ){
    var firestore = Firestore.instance;
    String storeID =  myOrders[i].storeID;
    String orderID = myOrders[i].orderID;
    QuerySnapshot qn = await  firestore.collection('stores').
    document(storeID).collection('Orders').
    document(orderID).collection('products').getDocuments();
      myOrders[i].items =  qn.documents.map((doc){
        return Product(
        name:  doc.data['name'],
        price: doc.data['price'],
        info:  doc.data['ProductInfo'],
        id:  doc.data['productID'],
       imgPath:  doc.data['image'],
       numberOfItemsForAnOrder :doc.data['NumberOfItems'],);
      }).toList();
      return myOrders;
    }
    }catch(e){
      print(e.toString()+ 'Iam inside getTheOrderItems function');
      return ;
    }
  }
 
Future getAllStoreOrders(String storeID) async{
  print('Getall:'+ storeID);
  try{
    var firestore = Firestore.instance;
    QuerySnapshot qn = await  firestore.collection('stores').
    document(storeID).collection('Orders').getDocuments();
    var myOrders = qn.documents.map((doc) {
    List<Product> items ;//await getTheOrderItems(doc.data['storeID'],doc.data['orderID']);  
    DateTime now = DateTime.now();
    String formattedTime = DateFormat.jm().format(now);
    print(formattedTime);
    return Order(
    orderID: doc.data['orderID'], //storeCollection.documentID,
    clientID: doc.data['clientID'],
    items:items ,  
    storeID: doc.data['storeID'] ,
    totalAmount: doc.data['totalAmount'],
    appFee: doc.data['appFee'],
    deleveryFee: doc.data['deleveryFee'],
    discount: doc.data['discount'],
    time:doc.data['timestamp'].toString(),
    orderName: doc.data['OrderName'],
    orderImage: doc.data['OrderImage'],
    storeName: doc.data['storeName'],
    clientPhoneNumber:doc.data['clientPhoneNumber'],
    storePhoneNumber:doc.data['storePhoneNumber'] );
    }).toList();
   //return myOrders;
    myOrders= await getTheOrderItemsToAllOrders(myOrders); 
    return myOrders;
    }catch(e){
      print(e.toString()+ 'Iam inside getAllStoreOrders function');
      return null;
    }

  }
Future getUserOrders(String userID) async{

   try{
    var firestore = Firestore.instance;
    QuerySnapshot qn = await  firestore.collection('users').
    document(userID).collection('Orders').getDocuments();
    var myOrders = qn.documents.map((doc) {
    List<Product> items ;//await getTheOrderItems(doc.data['storeID'],doc.data['orderID']);  
    DateTime now = DateTime.now();
    String formattedTime = DateFormat.jm().format(now);
    print(formattedTime);
    return Order(
    orderID: doc.data['orderID'], //storeCollection.documentID,
    clientID: doc.data['clientID'],
    items:items ,  
    storeID: doc.data['storeID'] ,
    totalAmount: doc.data['totalAmount'],
    appFee: doc.data['appFee'],
    deleveryFee: doc.data['deleveryFee'],
    discount: doc.data['discount'],
    time:doc.data['timestamp'].toString(),
    orderName: doc.data['OrderName'],
    orderImage: doc.data['OrderImage'],
    clientPhoneNumber:doc.data['clientPhoneNumber'],
    storeName: doc.data['storeName'],
    storePhoneNumber:doc.data['storePhoneNumber'] );
    
    }).toList();
   //return myOrders;
    myOrders= await getItemsToAllOrders(myOrders); 
    return myOrders;
    }catch(e){
      print(e.toString()+ 'Iam inside getUserOrders function');
      return null ;
    }

  }
  Future getItemsToAllOrders(List<Order> myOrders)async{
   //String storeID, String orderID
  try{
    for(int i = 0 ; i <myOrders.length;i++ ){
    var firestore = Firestore.instance;
     String userID = myOrders[i].clientID;
     String orderID = myOrders[i].orderID;
    QuerySnapshot qn = await  firestore.collection('users').
    document(userID).collection('Orders').document(orderID).collection('products').getDocuments();
      myOrders[i].items =  qn.documents.map((doc){
        return Product(
        name:  doc.data['name'],
        price: doc.data['price'],
        info:  doc.data['ProductInfo'],
        id:  doc.data['productID'],
       imgPath:  doc.data['image'],
       numberOfItemsForAnOrder :doc.data['NumberOfItems'],);
      }).toList();
      return myOrders;
    }
    }catch(e){
      print(e.toString()+ 'Iam inside getItemsToAllOrders function');
      return ;
    }
  }

  
}