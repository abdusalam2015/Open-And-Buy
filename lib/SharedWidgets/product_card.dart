import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:volc/SharedModels/product/product.dart';
import 'package:volc/User/Model/cart_bloc.dart';



Widget productsGridList(_increment,_decrement,productList,context,isAdmin) {
    //  product = new Product(id:'4', name:'Morabou',
    // imgPath:'assets/chocolate/3.png',price:'\$1.99',info: 'info');
    return productList != null ? Container(
      padding: EdgeInsets.only(right: 10.0),
      width: MediaQuery.of(context).size.width - 30.0,
      height:  MediaQuery.of(context).size.height - 250.0,
        child:  GridView.builder(
          itemCount: productList != null ? productList.length : 0,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height),
          ),
          itemBuilder: (BuildContext context, int index){ 
            return productCard(productList[index],_increment,_decrement,context,isAdmin);
          }),  
      ): Center(child:Text('No Products'));
  }
Widget productCard(Product product, Function increment, Function decrement,
BuildContext context,bool isAdmin){
  // SharedFunctions obj = new SharedFunctions();
  // Uint8List imageFile ;
  // imageFile = obj.getmg(); //getProductImage('hello','Drinks',productList[index].name);
  // print(imageFile.toString() + ' HY');
  var bloc = Provider.of<CartBloc>(context);  
  var cart = bloc.cart;
  int count = cart[product.id];
        return Padding(
        padding: EdgeInsets.only(top:3,left: 3,right: 3,bottom: 1),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(),
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
                     //   true ? Icon(Icons.favorite, color: Colors.pink[400] ):
                        Icon(Icons.favorite_border,color: Colors.pink[400],)
                      ],
                    ),
                  ),
                  Hero(
                    tag: product.imgPath + product.id,
                    child: product.imgPath !='' && product.imgPath != null ? Stack(
                      children:[
                      Padding(
                        padding: const EdgeInsets.only(top:30.0),
                        child: Center(
                          child: Container(
                            height: 40,
                            width: 40,
                            child: SpinKitFadingCircle(
                              color: Colors.red,
                              size: 30.0,
                             // controller: AnimationController(  duration: const Duration(milliseconds: 1200)),
                                )
                                   // CircularProgressIndicator()
                          ),
                        ),
                      ),
                       Container(
                        height: 90.0,
                        width: 90.0,
                        child: FadeInImage.memoryNetwork(
                          height: 100,
                         // fadeOutCurve: Curves.bounceIn,
                          fadeInDuration: const Duration(seconds:1),
                          placeholder: kTransparentImage,
                          image: product.imgPath,
                        ),
                      ),
                      //  Container(
                      //   height: 90.0,
                      //   width: 90.0,
                      //   decoration: BoxDecoration(
                      //     image: DecorationImage(
                      //     image: product.imgPath !='' && product.imgPath != null  ?
                      //     // profile pic is updated 
                      //     NetworkImage(product.imgPath)
                      //     //Image.memory(imageFile)
                      //     // profile picture is not updated , so we will go with the default one 
                      //     :AssetImage('assets/chocolate/3.png'),
                      //     fit: BoxFit.contain
                      //     )
                      //   ),
                      // ),
                      ]
                    ):Container(
                      height: 90,width: 90,
                      child:Center(child: Text('No image!'))
                      ),
                  ),
                  SizedBox(height: 7.0),
                  Text(
                    product.price,
                    style: TextStyle(
                      color: Colors.pink[400],
                      fontFamily: 'Varela',
                      fontSize: 14.0
                    ),
                  ),
                   Container(
                     height: 50,
                     width: 100,
                     child: Text(
                      product.name,
                      style: TextStyle(
                        color: Color(0xFF575E67),
                        fontFamily: 'Varela',
                        fontSize: 14.0
                      ),
                  ),
                ),
              ],
          ),
      ),      
      Padding(
        padding: EdgeInsets.all(0.0),
        child: Container(color: Color(0xFFEBEBEB),height: 1.0,),
        ),
        InkWell(
          onTap: (){
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => ProductDetail(
            //       imgPath: imagePath,
            //       price: price , 
            //       productName: name ,
            //       cont: widget.cont,
            //     )
            //   )
            //   ); 
              },
              child: Container(
                height: 30,
                width: 110,
                decoration: BoxDecoration(
                borderRadius: BorderRadius.only(),//circular(5.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[400].withOpacity(0.3),
                      spreadRadius: 4.0,
                      blurRadius: 6.0,
                    )
                  ],
                  color: Colors.white
              ),
                child: isAdmin? buttonToEdit(): buttonToAdd(count,product,product.id,increment,decrement),
              ),
            ),
          ],     
        ),  
      );
  }
  Widget buttonToEdit(){
    return Center(
      child: Row(
        children: <Widget>[
          Icon(Icons.edit,color: Colors.pink,),
          Text(
            'Edit Product',
            style: TextStyle(
              fontFamily: 'Varela',
              color: Colors.pink[500],
              fontSize: 13.0,
              fontWeight: FontWeight.bold, 
            ),
          ),
        ],
      ),
    );
  }
 Widget buttonToAdd(int count,product,id,increment,decrement){
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
                            product.numberOfItemsForAnOrder = count.toString();
                         decrement(id,product);
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
                       //  Product product2 = new Product(id,product.name,product.ima,price,detail);
                        product.numberOfItemsForAnOrder = count.toString();
 // update the number of items
                         increment(id,product);
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
              product.numberOfItemsForAnOrder = count.toString();
                    // update the number of items
                increment(id,product);
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