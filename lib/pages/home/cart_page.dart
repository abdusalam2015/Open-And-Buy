import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_now/pages/home/cart_bloc.dart';
class CartPage extends StatelessWidget {
  CartPage({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context){
    var bloc = Provider.of<CartBloc>(context);
    var cart = bloc.cart;
    var productInfo = bloc.productInfo;
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping Cart"),
      ),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index){
          String giftIndex = cart.keys.toList()[index];
          int count = cart[giftIndex];
          String productIndex = productInfo.keys.toList()[index];
          String imgPath = productInfo[productIndex].imgPath;
          print('FUU $count');
          if(count==0 ){
            return Padding(padding: EdgeInsets.all(0),);
          }
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imgPath),
                    fit: BoxFit.fitWidth,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              title: Text('Item Count: $count'),
              trailing: RaisedButton(
                child: Text('Clear'),
                color: Theme.of(context).buttonColor,
                elevation: 1.0,
                splashColor: Colors.blueGrey,
                onPressed: () {
                  bloc.clear(giftIndex);
                },
              ),
              
            ),
          );
        }
      ),
    );
  }
}
