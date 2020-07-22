import 'package:OpenAndBuy/Controller/constants/colors.dart';
import 'package:OpenAndBuy/Controller/payment/home_payment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:OpenAndBuy/Model/order.dart';
import 'package:OpenAndBuy/Service/order_service.dart';
import 'package:OpenAndBuy/Model/product.dart';
import 'package:OpenAndBuy/Model/store.dart';
import 'package:OpenAndBuy/Controller/orders_pages/order_confirmation.dart';
import 'package:OpenAndBuy/Model/cart_bloc.dart';
import 'package:OpenAndBuy/Model/user_detail.dart';

class CartPage extends StatelessWidget {
  final StoreDetail storeDetail;
  final UserDetail userDetail;
  CartPage(this.storeDetail, this.userDetail);
//  CartPage({Key key}) : super(key: key);
  List<double> productsPrices = new List<double>();
  double deliveryAndServices = 0.0;
  var bloc, productInfo;
  String storeID;

  String totalAmount() {
    double a = storeDetail.services;
    double b = storeDetail.deliveryFees;
    double c = bloc.total[storeID];
    double total = [a, b, c].reduce((a, b) => a + b);

    return total.toStringAsFixed(2);
    //  (storeDetail.services + storeDetail.deliveryFees + bloc.total[storeID]).toString();
  }

  @override
  Widget build(BuildContext context) {
    storeID = storeDetail.sid;
    bloc = Provider.of<CartBloc>(context);
    if (bloc.total[storeID] == null) bloc.total[storeID] = 0.0;

    if (bloc.cart[storeID] == null) bloc.cart[storeID] = {};
    if (bloc.productInfo[storeID] == null) bloc.productInfo[storeID] = {};

    var cart = bloc.cart[storeID];
    productInfo = bloc.productInfo[storeID];
    List<Product> theOrderedProducts = new List<Product>();
    return Scaffold(
      backgroundColor: BACKGROUNDCOLOR,
      appBar: AppBar(
        title: Text("SHOPPING CART",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
        backgroundColor: Colors.red, // APPBARCOLOR,
      ),
      body: (productInfo.length != 0)
          ? ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                String freqIndex = cart.keys.toList()[index];
                int count = cart[freqIndex];
                String productIndex = productInfo.keys.toList()[index];

                // add the products to send them to the store Adminstration
                theOrderedProducts.add(productInfo[productIndex]);

                if (count == 0) {
                  return Padding(
                    padding: EdgeInsets.all(0),
                  );
                }
                return productCart(count, freqIndex, productInfo[productIndex]);
              })
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                  child: Text(
                'No Product Selected',
                style: TextStyle(fontSize: 20, color: Colors.red),
              )),
            ),
      bottomNavigationBar: productInfo.length != 0
          ? reciept(context, theOrderedProducts)
          : Text(''),
    );
  }

  Widget productCart(int count, String freqIndex, Product product) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 130,
        width: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          //  boxShadow: [
          //   BoxShadow(
          //     color: Colors.red[400].withOpacity(1.0),
          //     spreadRadius: 1.0,
          //     blurRadius: 1.0,
          //   )
          // ],
          color: Colors.grey,
        ),
        // color: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              color: Colors.white,
            ),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: product.imgPath != '' && product.imgPath != null
                            ? NetworkImage(product.imgPath)
                            : AssetImage('assets/chocolate/3.png'),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                Container(
                  color: Colors.grey,
                  height: 150,
                  width: 1.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                              width: 100,
                              child: text3(product.name, Colors.grey, 12.0)),
                          SizedBox(
                            width: 95.0,
                          ),
                          InkWell(
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                color: Colors.red[400],
                              ),
                              //  color: Colors.redAccent,
                              child: Center(
                                  child: Text('X',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold))),
                            ),
                            onTap: () {
                              bloc.clear(freqIndex, storeID);
                            },
                          )
                        ],
                      ),
                      SizedBox(height: 8.0,),
                      text3(product.info, Colors.grey, 12.0),
                      SizedBox(height: 8.0,),
                      Row(
                        children: <Widget>[
                          text3('Price : ', Colors.black, 12.0),
                          text3('SKE ', Colors.black, 12.0),
                          text3(product.price, Colors.black, 12.0),
                        ],
                      ),
                       SizedBox(height: 8.0,),
                      text3('Items :  ' + count.toString(), Colors.black, 12.0),
                      SizedBox(height: 8.0,),
                      Row(
                        children: <Widget>[
                          text3('Savings : ', Colors.black, 12.0),
                          text3('SKE ', Colors.black, 12.0),
                          text3('0.0', Colors.black, 12.0),
                        ],
                      ),
                      SizedBox(height: 8.0,),
                    ],
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget text3(String value, Color color, double fontsize) {
    return Text(value,
        style: TextStyle(
            color: color, fontSize: fontsize, fontWeight: FontWeight.bold));
  }

  Widget reciept(context, theOrderedProducts) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(3), topRight: Radius.circular(3)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[400].withOpacity(0.0),
              spreadRadius: 4.0,
              blurRadius: 6.0,
            )
          ],
          color: PRODUCTCARD,
        ),
        // color: APPBARCOLOR,
        height: 240,
        width: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      // Text('Total Items: 4 Items',),
                      text2('Total Items', Colors.black, 18.0),
                      SizedBox(
                        width: 100,
                      ),
                      text2(productInfo.length.toString(), Colors.red, 18.0),
                    ],
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    children: <Widget>[
                      //Text('Subtotal: 303 SEK'),
                      text2('Subtotal', Colors.black, 18.0),
                      SizedBox(
                        width: 120,
                      ),
                      text2('SEK  ', Colors.red, 18.0),
                      text2(bloc.total[storeID].toStringAsFixed(2), Colors.red,
                          18.0),
                    ],
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    children: <Widget>[
                      text2('Delivery Fee', Colors.black, 18.0),
                      SizedBox(
                        width: 90,
                      ),
                      text2('SEK  ', Colors.red, 18.0),
                      text2(storeDetail.deliveryFees.toString(), Colors.red,
                          18.0),
                    ],
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    children: <Widget>[
                      text2('Services', Colors.black, 18.0),
                      SizedBox(
                        width: 120,
                      ),
                      text2('SEK  ', Colors.red, 18.0),
                      text2(storeDetail.services.toString(), Colors.red, 18.0),
                    ],
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    children: <Widget>[
                      text2('Total Amount', Colors.black, 18.0),
                      SizedBox(
                        width: 84.0,
                      ),
                      text2('SEK  ', Colors.red, 18.0),
                      text2(totalAmount().toString(), Colors.red, 18.0),
                    ],
                  ),
                  SizedBox(
                    height: 11.0,
                  ),
                  text2('All prices are inclusive of applicable taxes.',
                      Colors.red, 14.0),
                ],
              ),
            ),
            storeDetail.storeStatus == "true"
                ? checkOutButton(context, theOrderedProducts)
                : Text(
                    'CLOSED',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  )
          ],
        ),
      ),
    );
  }

  Widget text2(String value, Color color, double fontsize) {
    return Text(value,
        style: TextStyle(
            color: color, fontSize: fontsize, fontWeight: FontWeight.bold));
  }

  Widget text(txt, value, temp) {
    return RichText(
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
            style: TextStyle(fontWeight: FontWeight.normal, color: Colors.red),
          ),
        ],
      ),
    );
  }

  Widget checkOutButton(context, theOrderedProducts) {
    double a = storeDetail.deliveryFees;
    double b = storeDetail.services;
    double c = bloc.total[storeDetail.sid];
    if (c == null) c = 0.0;
    double total = [a, b, c].reduce((a, b) => a + b);

    return Row(
      children: <Widget>[
        InkWell(
          onTap: () async {
            String orderName = userDetail.firstName + ' ' + userDetail.lastName;
            Order order = new Order(
                clientID: userDetail.userID,
                items: theOrderedProducts,
                storeID: storeDetail.sid,
                totalAmount: total,
                appFee: 0.0,
                deleveryFee: storeDetail.deliveryFees,
                discount: 0.0,
                time: DateTime.now().toString(),
                orderName: orderName,
                orderImage: userDetail.photoURL,
                clientPhoneNumber: userDetail.phone['number'],
                storePhoneNumber: storeDetail.phoneNumber,
                status: "waiting for response...",
                storeName: storeDetail.name,
                services: storeDetail.services);

            /// register the order in the store side

            // OrderService obj = new OrderService(orderDetail: order);
            // String orderID = await obj.registerAnOrderInTheStoreDB();

            // register the order in the user side

            /***************** */
            //   clearCart();
            // Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => HomePayment(
                      userDetail: userDetail,
                      storeDetail: storeDetail,
                      order: order,
                    )));

            /*********************** */
          },
          // textColor: Colors.white,

          //  padding: const EdgeInsets.all(0.0),
          child: Container(
            width: 214,
            height: 60,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(0)),
              gradient: LinearGradient(
                colors: [
                  Colors.pink,
                  Colors.pink,
                  Colors.pink,
                ],
              ),
            ),
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: const Text('CHECKOUT',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ),
        Container(
          width: 130,
          height: 60,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(0)),
            gradient: LinearGradient(
              colors: [
                Colors.red,
                Colors.red,
                Colors.red,
              ],
            ),
          ),
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Text('SEK ' + totalAmount().toString(),
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}
