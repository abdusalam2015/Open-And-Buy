import 'package:OpenAndBuy/Controller/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:OpenAndBuy/Model/order.dart';
import 'package:OpenAndBuy/Service/order_service.dart';
import 'package:OpenAndBuy/Model/product.dart';
import 'package:OpenAndBuy/Model/store.dart';
import 'package:OpenAndBuy/Controller/orders_pages/order_confirmation.dart';
import 'package:OpenAndBuy/Model/cart_bloc.dart';
import 'package:OpenAndBuy/Model/user_detail.dart';
import 'package:OpenAndBuy/Model/order_calculation.dart';

class CartPage extends StatelessWidget {
  final StoreDetail storeDetail;
  final UserDetail userDetail;
  CartPage(this.storeDetail, this.userDetail);
//  CartPage({Key key}) : super(key: key);
  List<double> productsPrices = new List<double>();
  double deliveryAndServices = 0.0;

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<CartBloc>(context);
    void clearCart() {
      bloc.cart.clear();
      bloc.productInfo.clear();
    }

    String totalAmount() =>
        (storeDetail.services + storeDetail.deliveryFees + bloc.total)
            .toString();

    var cart = bloc.cart;
    var productInfo = bloc.productInfo;
    List<Product> theOrderedProducts = new List<Product>();
    return Scaffold(
      backgroundColor: BACKGROUNDCOLOR,
      appBar: AppBar(
        title: Text("Shopping Cart"),
        backgroundColor: APPBARCOLOR,
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

                // add products prices
                //   productsPrices.add(double.parse(productInfo[productIndex].price).toDouble());
                //    print(productIndex);
                //  bloc.productsSummation(productsPrices);

                String imgPath = productInfo[productIndex].imgPath;
                if (count == 0) {
                  return Padding(
                    padding: EdgeInsets.all(0),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imgPath != '' && imgPath != null
                              ? NetworkImage(imgPath)
                              : AssetImage('assets/chocolate/3.png'),
                          fit: BoxFit.fitWidth,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    title: Text('Item Count: $count'),
                    trailing: RaisedButton(
                      child: Text(
                        'Delete',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.red, //.of(context).buttonColor,
                      elevation: 1.0,
                      splashColor: Colors.white,
                      onPressed: () {
                        bloc.clear(freqIndex);
                      },
                    ),
                  ),
                );
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
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: APPBARCOLOR,
                height: 300,
                width: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        // Text('Total Items: 4 Items',),
                        text(
                            'Number of Products: ', '${productInfo.length}', '')
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        //Text('Subtotal: 303 SEK'),
                        text('Subtotal: ', '${bloc.total.toString()}', '  SEK')
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        // Text('Delivery Fee: 10 SEK'),
                        text('Delivery Fee: ', '${storeDetail.deliveryFees}',
                            '  SEK')
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        text('Services: ', '${storeDetail.services} ', '  SEK')
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        text('Total Amount: ', '${totalAmount().toString()} ',
                            '  SEK')
                      ],
                    ),
                    checkOutButton(context, theOrderedProducts, clearCart)
                  ],
                ),
              ),
            )
          : Text(''),
    );
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

  Widget checkOutButton(context, theOrderedProducts, clearCart) {
    return RaisedButton(
      onPressed: () {
        String orderName = userDetail.firstName + ' ' + userDetail.lastName;
        Order order = new Order(
          clientID: userDetail.userID,
          items: theOrderedProducts,
          storeID: storeDetail.sid,
          totalAmount: 130.4,
          appFee: 20.9,
          deleveryFee: 50.8,
          discount: 0.1,
          time: DateTime.now().toString(),
          orderName: orderName,
          orderImage: userDetail.photoURL,
          clientPhoneNumber: userDetail.phoneNumber,
          storePhoneNumber: storeDetail.phoneNumber,
          status: "waiting for response...",
          storeName: storeDetail.name,
        );

        /// register the order in the store side
        OrderService obj = new OrderService(orderDetail: order);
        obj.registerAnOrderInTheStoreDB();
        // register the order in the user side

        // clear the cart
        clearCart();

//
        Navigator.pop(context);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => OrderConfirmation(
                  storeDetail: storeDetail,
                  theOrderedProducts: theOrderedProducts,
                  userDetail: userDetail,
                  //categoriesList,
                  //productsList
                )));
      },
      textColor: Colors.white,
      padding: const EdgeInsets.all(0.0),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xFF0D47A1),
              Color(0xFF1976D2),
              Color(0xFF42A5F5),
            ],
          ),
        ),
        padding: const EdgeInsets.all(10.0),
        child: const Text('Check Out', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
