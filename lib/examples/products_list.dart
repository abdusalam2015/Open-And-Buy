import 'package:flutter/material.dart';

 class ProductsList extends StatefulWidget {
  @override
  _ProductsListState createState() => _ProductsListState();

  }
  class _ProductsListState extends State<ProductsList> {
    @override
    Widget build(BuildContext context) {
      return Container(
      padding: EdgeInsets.only(right: 10.0,left: 5.0),
      width: MediaQuery.of(context).size.width - 30.0,
      height: MediaQuery.of(context).size.height - 50.0,
        child: GridView.count(
          crossAxisCount: 3,
          primary: false,
          crossAxisSpacing: 2.0,
          mainAxisSpacing: 0.0,
          childAspectRatio: 0.5,
          children: <Widget>[
          // productCard( '1' ,'Milk', '20 SEK','assets/drinks/1.png',true,context,'Hi'),                    
          // productCard( '1' ,'Milk', '20 SEK','assets/drinks/1.png',true,context,'Hi'),                    
          // productCard( '1' ,'Milk', '20 SEK','assets/drinks/1.png',true,context,'Hi'),                    
          // productCard( '1' ,'Milk', '20 SEK','assets/drinks/1.png',true,context,'Hi'),                    
          // productCard( '1' ,'Milk', '20 SEK','assets/drinks/1.png',true,context,'Hi'),                    
          // productCard( '1' ,'Milk', '20 SEK','assets/drinks/1.png',true,context,'Hi'),                    

          ],   
           ),
      );
    }
  
}