import 'package:flutter/material.dart';
import 'package:volc/SharedModels/product/product.dart';
import 'package:volc/SharedModels/store/store.dart';
import 'package:volc/User/Model/user_detail.dart';
class OrderConfirmation extends StatefulWidget {
  final BuildContext cont;
  final StoreDetail storeDetail;
  final List<Product> theOrderedProducts;
  final UserDetail userDetail;
 OrderConfirmation({this.cont,this.storeDetail,this.theOrderedProducts,this.userDetail});

  @override
  _OrderConfirmationState createState() => _OrderConfirmationState();
}

class _OrderConfirmationState extends State<OrderConfirmation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thank you for your order!'),
        ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 70,
                width: 400,
                color: Colors.blueGrey,
                child:Center(child: Text('Thank you for using Volc',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.green),)),
                ),
            ),
              orderStatus(true), 
              order(),
              feedback(),
          ],
        ),
      ),
    );

  }
  Widget feedback(){
    return Container(
      child: Column(
        children: <Widget>[
          ListTile(
          //  contentPadding: EdgeInsets.all(20),
            title:Text('Your Feedback',style: TextStyle(color:Colors.blue,fontSize: 20,)),
            leading: Icon(Icons.feedback,size: 40,color: Colors.blue,),
            subtitle: Text('We really apprciate Your feedback,Thanks',
            style: TextStyle(color:Colors.grey,fontSize: 14,)),
          ),
          ListTile(
           // contentPadding: EdgeInsets.all(20),
            title:Text('Share',style: TextStyle(color:Colors.blue,fontSize: 20,)),
            leading: Icon(Icons.share,size: 40,color: Colors.blue,),
            subtitle: Text('Share it with your friends',
            style: TextStyle(color:Colors.grey,fontSize: 14,)),
          ),
          ListTile(
           // contentPadding: EdgeInsets.all(20),
            title:Text('Call the store',style: TextStyle(color:Colors.blue,fontSize: 20,)),
            leading: Icon(Icons.call,size: 40,color: Colors.blue,),
            subtitle: Text('You can call the store and tell him your issue',
            style: TextStyle(color:Colors.grey,fontSize: 14,)),
          )
          
        ],
      ),
    );
  }
  Widget orderStatus(isAccepted){
    return Container(
      height: 70,
      width: 400,
      child: Row(
        children: <Widget>[
          Text('Your Order: ' , style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          isAccepted? Container(
            child: Text('Accepted!', style: TextStyle(fontSize: 20,color: Colors.green),)
          )
          :Text('Wating For Response...', style: TextStyle(fontSize: 20,color: Colors.red),),
        ],
      )
    );
  }
  Widget order(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container( 
          color: Colors.blueGrey,
          height: 150,
          width: 400, 
      child:Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
        Row(
            children: <Widget>[
            // Text('Total Items: 4 Items',),
            text('Total Items: ','4 ','  Items')
          ],
        ),
        Row(
          children: <Widget>[
            //Text('Subtotal: 303 SEK'),
              text('Subtotal: ','303','  SEK')
          ],
        ),
        Row(
          children: <Widget>[
            // Text('Delivery Fee: 10 SEK'),
          text('Delivery Fee: ','10','  SEK')
          ],
        ),
        Row(
          children: <Widget>[
            // Text('Total Amount: 313 SEK'),
            text('Total Amount: ','313','  SEK')
          ],
        ),
      ],)),
    );
  }
  Widget text(txt,value,temp){
    return RichText(
      text: TextSpan(
        text: txt,
        style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 20),
        children: <TextSpan>[
        TextSpan(text: value, style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20)),
       TextSpan(text: temp,style: TextStyle(fontWeight: FontWeight.normal,color: Colors.red),),
        ],
      ),
    );
  }
}