import 'package:flutter/material.dart';
import 'package:shopping_now/pages/cookie_detail.dart';
import 'package:shopping_now/pages/product/product.dart';

class Products extends StatefulWidget {
 final Function increment;
 Product product;
 Products(this.increment,this.product);
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    
    return Container(
      padding: EdgeInsets.only(right: 15.0),
    width: MediaQuery.of(context).size.width - 30.0,
    height: MediaQuery.of(context).size.height - 50.0,
      child: GridView.count(
        crossAxisCount: 3,
        primary: false,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
        childAspectRatio: 0.5,
        children: <Widget>[
                  if(true) ...{
                  productCard( '1' ,'Milk', '20 SEK','assets/drinks/1.png',false,context,'Hi'),
                  productCard('2' ,'Strawberry', '2 SEK','assets/drinks/2.png',false,context,'Hi'),
                  productCard('3' ,'Ice-Cream', '\$3.99','assets/chocolate/1.png',true,context,'Hi'),
                  }else ...{
                  productCard('4' ,'Ice-Cream', '\$3.99','assets/chocolate/1.png',true,context,'Hi'),
                //  productCard('Swebar', '\$5.99','assets/chocolate/2.png',false,context),
                  }
                ],   
         ),
    );
  }
Widget productCard(String id,String name ,  String price, String imagePath, bool added,context, String detail){
  return Padding(
      padding: EdgeInsets.only(top:3,left: 3,right: 3,bottom: 1),
      child: InkWell(
        onTap: (){
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProductDetail(
                imgPath: imagePath,
                price: price , 
                productName: name 
              )
            )
            );        
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[400].withOpacity(0.3),
                  spreadRadius: 4.0,
                  blurRadius: 6.0,
                )
              ],
              color: Colors.white
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    added ? Icon(Icons.favorite, color: Colors.pink[400] ):Icon(Icons.favorite_border,color: Colors.pink[400],)
                  ],
                ),
              ),
              Hero(
                tag: imagePath,
                child: Container(
                  height: 90.0,
                  width: 90.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.contain
                    )
                  ),
                ),
              ),
              SizedBox(height: 7.0),
              Text(
                price,
                style: TextStyle(
                  color: Colors.pink[400],
                  fontFamily: 'Varela',
                  fontSize: 14.0
                ),
              ),
               Text(
                name,
                style: TextStyle(
                  color: Color(0xFF575E67),
                  fontFamily: 'Varela',
                  fontSize: 14.0
                ),
              ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(color: Color(0xFFEBEBEB),height: 1.0,),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
              if(!added) ... [
              GestureDetector(
              onTap: () {
              Product product = new Product(id,name,imagePath,price,detail);
              widget.increment(id,product);
              },
              child: Container(
                height: 20,
                width: 70,
                child: Text(
                        'Add to cart',
                        style: TextStyle(
                          fontFamily: 'Varela',
                          color: Colors.pink[500],
                          fontSize: 12.0
                        ),
                      ),
              )
              ),
               //Icon(Icons.shopping_basket, color: Colors.pink[400], size: 12.0,),                         
                    ],
                     if(added)...{
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
                     },
                  ],
                   ),  
              )
            ],
          ),
        ),
      ),
        
          
        );
  }
}