import 'package:flutter/material.dart';
import 'package:volc/User/Controller/home/app_bar.dart';
class ProductDetail extends StatelessWidget {
  final imgPath, price, productName;
  final BuildContext cont;
ProductDetail({this.imgPath, this.price, this.productName,this.cont});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
                preferredSize: Size.fromHeight(55.0), // here the desired height
                child: AppBarWidget(cont),
            ),
      body: ListView(
        children: [
            SizedBox(height: 15.0),
            Hero(
              tag: imgPath,
              child: Image.asset(imgPath,
              height: 150.0,
              width: 100.0,
              fit: BoxFit.contain
              )
            ),
            SizedBox(height: 20.0),
            Center(
              child: Text(price,
                  style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink[400])),
            ),
            SizedBox(height: 10.0),
            Center(
              child: Text(productName,
                  style: TextStyle(
                      color: Color(0xFF575E67),
                      fontFamily: 'Varela',
                      fontSize: 24.0)),
            ),
            SizedBox(height: 20.0),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 50.0,
                child: Text('Cold, creamy ice cream sandwiched between delicious deluxe cookies. Pick your favorite deluxe cookies and ice cream flavor.',
                textAlign: TextAlign.center,
                style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 16.0,
                      color: Color(0xFFB4B8B9))
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Colors.pink[400],
                ),
                child: Center(
                  child: Text('Add to cart',
                    style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                ),
                  )
                )
              )
            )
        ]
      ),
     );
  }
}
