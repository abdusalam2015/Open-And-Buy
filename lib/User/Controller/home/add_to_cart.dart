import 'package:flutter/material.dart';

class AddToCart extends StatefulWidget {
   final String index;
   AddToCart(this.index);

  @override
  _AddToCartState createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  @override
  Widget build(BuildContext context){
  //  var bloc = Provider.of<CartBloc>(context);
 //   var cart = bloc.cart;
   // var productInfo = bloc.productInfo;
    //String giftIndex = cart.keys.toList()[index];
   // int count = cart[widget.index];
   //  if(count==0){
      return Container(
        child: ListView(
          padding:EdgeInsets.all(3),
         // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
              Icon(Icons.remove_circle_outline, color: Colors.pink[400], size: 12.0),
              Text(
                '3',
                style: TextStyle(
                  fontFamily: 'Varela',
                  color: Colors.pink[400],
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0
                ),
              ),
              Icon(Icons.add_circle_outline, color: Colors.pink[400], size: 12)
              ],
             
            ),
      );
    // }else {
      // return Container(
      //           height: 20,
      //           width: 70,
      //           child: Text(
      //             'Add to cart',
      //             style: TextStyle(
      //               fontFamily: 'Varela',
      //               color: Colors.pink[500],
      //               fontSize: 12.0
      //             ),
      //           ),
      //         );
    // }
  }
}
