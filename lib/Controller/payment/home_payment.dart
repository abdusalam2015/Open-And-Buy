import 'package:OpenAndBuy/Controller/orders_pages/order_confirmation.dart';
import 'package:OpenAndBuy/Model/cart_bloc.dart';
import 'package:OpenAndBuy/Model/order.dart';
import 'package:OpenAndBuy/Model/store.dart';
import 'package:OpenAndBuy/Model/user_detail.dart';
import 'package:OpenAndBuy/Service/order_service.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:OpenAndBuy/Service/payment_service.dart';
import 'package:provider/provider.dart';

class HomePayment extends StatefulWidget {
  UserDetail userDetail;
  StoreDetail storeDetail;
  Order order;
  HomePayment({this.userDetail, this.storeDetail, this.order});
  @override
  _HomePaymentState createState() => _HomePaymentState();
}

class _HomePaymentState extends State<HomePayment> {
  onItemPress(BuildContext context, int index) async {
    switch (index) {
      case 0:
        payViaNewCard(context);
        // pay via new card
        break;
      case 1:
        Navigator.pushNamed(context, '/existing_cards');
    }
  }
String fixTheAmountStripeStandars(String amount){
// StrpeStandars is that we need to add 00 by the end of the amount if we have an integer number and 
//  if we have  a double number then we need to hadle that.
//example: if i want to add  25 to  stipe I need to add  2500 .... 
  var newAmount = amount.split('.');
  return newAmount[0] + ((newAmount[1].length > 1 )? newAmount[1] :  (newAmount[1]+'0') ) ;
}
  payViaNewCard(BuildContext context) async {

    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    await dialog.show();
      // int i = d.toInt(); // i = 20
      // int i = d.round(); // i = 21
      // int i = d.ceil();  // i = 21
       
      String totalAmount = fixTheAmountStripeStandars(widget.order.totalAmount.toString());
       print(totalAmount+ " Total  ");

   var response =
        await StripeService.payWithNewCard(amount: totalAmount , currency: 'SEK');
   
    if (response.success){
      OrderService obj = new OrderService(orderDetail: widget.order);
      String orderID = await obj.registerAnOrderInTheStoreDB();

      bloc.cart.clear();
      bloc.productInfo.clear();
       bloc.clearTotal();
        var t = [1.1, 2.2, 3.3].reduce((a, b) => a + b); // 6.6

       print(bloc.total.toString() + " BLOC IS CLEAR  " + t.toString());
       await dialog.hide();


      Navigator.pop(context);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => OrderConfirmation(
                userDetail: widget.userDetail,
                storeDetail: widget.storeDetail,
                orderID: orderID,
              )));
    } else {

      print(response.message);
    }

    Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(response.message),
        duration: new Duration(
            milliseconds: response.success == true ? 1200 : 3000)));
  }

  @override
  void initState() {
    super.initState();
    StripeService.init();
  }
var bloc;
  @override
  Widget build(BuildContext context) {
     bloc = Provider.of<CartBloc>(context);
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Builder(
        builder: (context) => Container(
          padding: EdgeInsets.all(20),
          child: ListView.separated(
              itemBuilder: (context, index) {
                Icon icon;
                Text text;
                switch (index) {
                  case 0:
                    icon = Icon(Icons.add_circle, color: theme.primaryColor);
                    text = Text('Pay via new card');
                    break;
                  case 1:
                    icon = Icon(Icons.credit_card, color: theme.primaryColor);
                    text = Text('Pay via existing card');
                    break;
                }
                return InkWell(
                    onTap: () {
                      onItemPress(
                        context,
                        index,
                      );
                    },
                    child: ListTile(
                      title: text,
                      leading: icon,
                    ));
              },
              separatorBuilder: (context, index) => Divider(
                    color: theme.primaryColor,
                  ),
              itemCount: 2),
        ),
      ),
    );
  }
}
