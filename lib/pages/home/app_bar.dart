import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_now/pages/home/cart_page.dart';
import 'package:shopping_now/pages/home/cart_bloc.dart';
Widget appBar(bool arrBack,context){
  var bloc = Provider.of<CartBloc>(context);
    int totalCount = 0;
    if (bloc.cart.length > 0) {
      totalCount = bloc.cart.values.reduce((a, b) => a + b);
    }
   return AppBar(
        backgroundColor: Colors.green,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: arrBack? Icon(Icons.arrow_back, color: Colors.white) :Icon(Icons.list, color: Colors.white),
          onPressed: () {
            if(arrBack){
            Navigator.of(context).pop();
            }
          },
        ),
        title: Text(
          'Shoping Now',
            style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 20.0,
                color: Colors.white,
              )
              ),
        actions: <Widget>[
          // IconButton(
          //   icon: Icon(Icons.shopping_cart, color: Colors.white),
          //   onPressed: () {},
          // ),
            Padding(
            padding: const EdgeInsets.all(10.0),
            child: new Container(
                height: 150.0,
                width: 30.0,
                child: new GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartPage(),
                      ),
                    );
                  },
                  child: new Stack(
                    children: <Widget>[
                      new IconButton(
                        icon: new Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                        ),
                        onPressed: null,
                      ),
                      new Positioned(
                          child: new Stack(
                        children: <Widget>[
                          new Icon(Icons.brightness_1,
                              size: 20.0, color: Colors.red[700]),
                          new Positioned(
                              top: 3.0,
                              right: 7,
                              child: new Center(
                                child: new Text(
                                  '$totalCount',
                                  style: new TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              )),
                        ],
                      )),
                    ],
                  ),
                )),
          ),
           IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      );
}