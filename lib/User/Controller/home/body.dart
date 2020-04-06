import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:volc/Admin/Controller/store_home_pages/store_page.dart';
import 'package:volc/User/Model/user_detail.dart';

class Body extends StatefulWidget {
  final BuildContext cont;
  Body(this.cont);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    final userDetail = Provider.of<UserDetail>(widget.cont);
    //print('UserDeal in body: $userDetail');
    return ListView(
    padding: EdgeInsets.all(8),
    children: <Widget>[
      categoryName('supermarkets near to me'),
      categoryStores(context, 'supermarkets'),
      SizedBox(height: 10),
      categoryName('Shops near to me'),
      categoryStores(context,'shops'),
      SizedBox(height: 10),
      categoryName('Restaurant near to me'),
      categoryStores(context,'restaurants'),
      SizedBox(height: 10),
      categoryName('Pharmacy near to me'),
      categoryStores( context,'pharmacy' ),
    ],    
  );
  }
Widget categoryName(String name){
  return Text(
          name,
          style: TextStyle(
              fontFamily: 'Varela',
              fontSize: 20.0,
              fontWeight: FontWeight.bold
              )
  );
}
Widget categoryStores(context,String name){
     return Container(
      constraints: BoxConstraints(
        maxHeight: 230.0,
        minHeight: 180.0,
     ),
     child:_listView(context,name),
     );
}
Widget _listView(context,String name){
  return ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  if (name == 'supermarkets')...{
                    _buildCard('Netto', '5%', 'assets/storesImages/netto.png',
                      '2 km away', false, context),
                    _buildCard('ICA', '5%', 'assets/storesImages/ica.png',
                      '4 km away', false, context),
                  } else if(name == 'shops')... {
                    _buildCard('IKEA', '\$1.99',
                      'assets/storesImages/ikea.png', '25 km away', true, context),
                     _buildCard('JYSK', '\$2.99', 'assets/storesImages/jysk.png',
                      '6 km away', false, context),
                     _buildCard('H & M', '\$2.99', 'assets/storesImages/hm.png',
                      '3 km away', false, context),
                  } else if(name == 'restaurants')...{
                  _buildCard('Halal Food ', '\$2.99', 'assets/storesImages/halal.png',
                      '4.5 km away', false, context),
                  }else ...{
                  _buildCard('Pharmacy', '\$2.99', 'assets/storesImages/pharmacy.png',
                  '4.3 km away', false, context) 
                   },
         ],
      );
}
  Widget _buildCard(String name, String dis, String imgPath, String location,
      bool isFavorite, context) {
  return Padding(
    padding: EdgeInsets.all(5),
    child: InkWell(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => StorePage(
                imgPath: imgPath,
                storeDiscount:dis,
                storeName: name,
                cont: widget.cont,
                
              )));
        },
    child: Container(
      height: 50,
      width: 280,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2.0,
                blurRadius: 4.0)
            ],
        color: Colors.pink[400],
        ),
        child: Column(
          children: [
          Padding(
              padding: EdgeInsets.all(1.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    isFavorite ? Icon(Icons.star_half, color: Colors.yellow): Icon(Icons.star,color: Colors.yellow),
                        Text(
                          '5.0',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white
                          ),
                          )
                          ,]
                  ),
                ),
          Hero(
              tag: imgPath,
              child: Container(
                height: 140.0,
                width: 300.0,
                decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(imgPath),
                          fit: BoxFit.contain,
                          )
                    ), 
                ),
          ),
          // Container(color: Colors.black, height: 1.0),
          Padding(
              padding: EdgeInsets.all(1.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      Column(children: <Widget>[
                        Text(
                        name,
                        style: TextStyle(
                            fontFamily: 'Varela',
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold)
                      ),
                      Row(children: <Widget>[
                      Icon(Icons.location_on,
                      color: Colors.white,
                        size: 24.0),
                        Text(
                        location,
                        style: TextStyle(
                            fontFamily: 'Varela',
                            color: Colors.white,
                            fontSize: 18.0)
                      ),
                      ],)  
                      ],),  
                  ])
                  ),
                  ])
                )
            )
          );
}
}