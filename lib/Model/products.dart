/*import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:OpenAndBuy/SharedModels/product/product.dart';
import 'package:OpenAndBuy/Controller/product/product_detail.dart';
import 'package:OpenAndBuy/Model/cart_bloc.dart';
 class Products extends StatefulWidget {
 final Function increment;
 final Function decrement;
 final BuildContext cont;


 final Product product;
 Products(this.increment,this.decrement,this.product,this.cont);
  @override
  _ProductsState createState() => _ProductsState();

  }
  class _ProductsState extends State<Products> {
      _favorite(bool added){
       setState(() {
      added = added;
    });
    }
    @override
    Widget build(BuildContext context) {
   
        //final user = Provider.of<User>(context).uid;
       // final userDetail = Provider.of<UserDetail>(context);
      return Container(
      padding: EdgeInsets.only(right: 10.0),
      width: MediaQuery.of(context).size.width - 30.0,
      height: MediaQuery.of(context).size.height - 50.0,
        child: GridView.count(
          crossAxisCount: 3,
          primary: false,
          crossAxisSpacing: 2.0,
          mainAxisSpacing: 5.0,
          childAspectRatio: 0.5,
          children: <Widget>[
                    if(true) ...{
                    productCard( '1' ,'Milk', '20 SEK','assets/drinks/1.png',true,context,'Hi'),
                    productCard('2' ,'Strawberry', '2 SEK','assets/drinks/2.png',false,context,'Hi'),
                    productCard('3' ,'Ice-Cream', '\$3.99','assets/chocolate/1.png',true,context,'Hi'),
                    productCard('4','Morabou', '\$1.99','assets/chocolate/3.png',false,context,'Hi'),
                    productCard('5','Vodka Moscco', '\$1.99','assets/alcoholic_drinks/4.png',false,context,'HI'),
                    productCard('6','Fast Food', '\$3.99','assets/normal/6.png',false,context,'Hi'),
                    productCard('7','Cleaner', '\$2.99','assets/cleaner/4.png',false,context,'Hi'),
                    }else ...{
                    productCard('4' ,'Ice-Cream', '\$3.99','assets/chocolate/1.png',true,context,'Hi'),
                  //  productCard('Swebar', '\$5.99','assets/chocolate/2.png',false,context),
                    }
                  ],   
           ),
      );
    }
  Widget productCard(String id,String name ,  String price, String imagePath, bool added,context, String detail){
    var bloc = Provider.of<CartBloc>(context);  
    var cart = bloc.cart;
    int count = cart[id];
    Product product = new Product(id:id,name:name,imgPath:imagePath,price:price,info:detail);

   // print('COUNT= $count');
    return Padding(
        padding: EdgeInsets.only(top:3,left: 3,right: 3,bottom: 1),
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProductDetail(
                      imgPath: imagePath,
                      price: price , 
                      productName: name ,
                      cont: widget.cont,
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
                    InkWell(
                      onTap: (){
                        _favorite(added); 
                      },
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            added ? Icon(Icons.favorite, color: Colors.pink[400] ):Icon(Icons.favorite_border,color: Colors.pink[400],)
                          ],
                        ),
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
               //  addToCart()
                buttonToAdd(count,product,id),
                ],
              ),
            ),
      ),
          ]  
        )
        );

          
  }

  Widget buttonToAdd(count,product,id){

   return   (count != 0 && count != null )?  Container(
                height: 30,
                width: 100,
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
               child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: <Widget>[
                       GestureDetector(
                         onTap: () {
                         widget.decrement(id,product);
                          },
                         child:Icon(Icons.remove_circle_outline, color: Colors.pink[400], size: 24.0),
                         ),
                         Text(
                             '$count',
                             style: TextStyle(
                               fontFamily: 'Varela',
                               color: Colors.pink[400],
                               fontWeight: FontWeight.bold,
                               fontSize: 15.0
                             ),
                         ),
                         GestureDetector(
                         onTap: () {
                        // Product product = new Product(id,name,imagePath,price,detail);
                         widget.increment(id,product);
                      // print('id = $id');
                       },
                        child: Icon(Icons.add_circle_outline, color: Colors.pink[400], size: 24)                 
                       )
                   ],
               ),
             ):  
            InkWell(
              onTap: (){
               // Product product = new Product(id,name,imagePath,price,detail);
                widget.increment(id,product);
              },
              child: Container(
                height: 30,
               // color: Colors.green,
                width: 100,
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
                child: Center(
                  child: Text(
                    'Add to cart',
                    style: TextStyle(
                      fontFamily: 'Varela',
                      color: Colors.pink[500],
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold, 
                    ),
                  ),
                ),
        ),  
        );
  }
}
*/