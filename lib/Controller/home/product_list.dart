import 'package:OpenAndBuy/Controller/constants/colors.dart';
import 'package:OpenAndBuy/Controller/home/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:OpenAndBuy/Model/product.dart';
import 'package:OpenAndBuy/Model/cart_bloc.dart';

class ProductList extends StatefulWidget {
  final List<Product> productList;
  String storeID;

  ProductList(this.productList, this.storeID);
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  String storeID = "";
  @override
  Widget build(BuildContext context) {
    storeID = widget.storeID;
    var bloc = Provider.of<CartBloc>(context);
    int totalCount = 0;
    // print(storeID + " bloc.cart.length>0");
    //bloc.cart.length>0
    // aNVyji3ENJ4pMnJjRYmX
    if (bloc.cart[storeID] == null) bloc.cart[storeID] = {};
    if (bloc.cart[storeID].length > 0) {
      totalCount = bloc.cart[storeID].values.reduce((a, b) => a + b);
    } else {
      totalCount = totalCount;
    }
    // Product product ;
    void _increment(String index, Product product) {
      setState(() {
        bloc.addToCart(index, product, storeID);
      });
    }

    void _decrement(String index, Product product) {
      setState(() {
        bloc.subToCart(index, product, storeID);
      });
      if (bloc.cart[storeID][index] == 0) {
        setState(() {
          bloc.clear(index, storeID);
        });
      }
    }

    void _clear(String index) {
      setState(() {
        bloc.clear(index, storeID);
      });
    }

    return productsGridList(widget.productList, _increment, _decrement, _clear);
  }

  Widget productsGridList(productList, _increment, _decrement, _clear) {
    //  product = new Product(id:'4', name:'Morabou',
    // imgPath:'assets/chocolate/3.png',price:'\$1.99',info: 'info');
    return productList != null
        ? Center(
            child: Container(
              color: Colors.grey[200],
              //padding: EdgeInsets.only(right: 10.0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: GridView.builder(
                  itemCount: productList != null ? productList.length : 0,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height),
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return productCard(productList[index], _increment,
                        _decrement, _clear, context);
                  }),
            ),
          )
        : Center(child: Text('No Products'));
  }

  Widget productCard(Product product, Function increment, Function decrement,
      clear, BuildContext context) {
    var bloc = Provider.of<CartBloc>(context);
    var cart = bloc.cart[storeID];
    //     print(product.id + "  PRODUCT CARD");
    int count = 0;
    if (cart != null) {
      count = cart[product.id];
    }

    return Padding(
      padding:
          const EdgeInsets.only(top: 3.0, right: 3.0, left: 3.0, bottom: 0.0),
      child: Column(
        children: <Widget>[
          InkWell(
            child: Container(

              decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(3),
                        topRight: Radius.circular(3)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[400].withOpacity(0.0),
                        spreadRadius: 4.0,
                        blurRadius: 6.0,
                      )
                    ],
              color: (count != 0 && count != null) ? Colors.red : Colors.white,
                  ),
              child: Padding(
                padding: const EdgeInsets.only(left: 2.0, right: 2.0, top: 2.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(3),
                        topRight: Radius.circular(3)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[400].withOpacity(0.0),
                        spreadRadius: 4.0,
                        blurRadius: 6.0,
                      )
                    ],
                    color: Colors.white,
                  ),
                  child: Column(
                    children: <Widget>[
                      // Padding(
                      //   padding: EdgeInsets.all(5.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.end,
                      //     children: <Widget>[
                      //       //   true ? Icon(Icons.favorite, color: Colors.pink[400] ):
                      //       Icon(
                      //         Icons.favorite_border,
                      //         color: Colors.pink[400],
                      //       )
                      //     ],
                      //   ),
                      // ),
                      Hero(
                        tag: product.imgPath + product.id,
                        child: product.imgPath != '' && product.imgPath != null
                            ? Stack(children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 30.0),
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
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        height: 95.0,
                                        width: 110.0,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                          image: NetworkImage(
                                            // height: 100,
                                            // // fadeOutCurve: Curves.bounceIn,
                                            // fadeInDuration: const Duration(seconds: 1),
                                            // placeholder: kTransparentImage,
                                            product.imgPath,
                                          ),
                                          fit: BoxFit.fill,
                                        ))),
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
                              ])
                            : Container(
                                height: 90,
                                width: 90,
                                child: Center(child: Text('No image!'))),
                      ),
                      SizedBox(height: 7.0),
                      Text(
                        product.price + ' SKE',
                        style: TextStyle(
                            color: Colors.pink[800],
                            fontFamily: 'Varela',
                            fontSize: 18.0),
                      ),
                      Container(
                        height: 50,
                        width: 100,
                        child: Text(
                          product.name,
                          style: TextStyle(
                              color: Color(0xFF575E67),
                              fontFamily: 'Varela',
                              fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProductDetailPage(product)));
            },
          ),
          InkWell(
            onTap: () {
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
              height: 40,
              width: 114,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(), //circular(5.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[400].withOpacity(0.0),
                      spreadRadius: .0,
                      blurRadius: 0.0,
                    )
                  ],
                  color: Colors.white),
              child: buttonToAdd(
                  count, product, product.id, increment, decrement, clear),
            ),
          ),
        ],
      ),
    );
  }

  Widget buttonToAdd(int count, product, id, increment, decrement, clear) {
    return (count != 0 && count != null)
        ? Container(
            height: 40,
            width: 120,
            decoration: BoxDecoration(
                //borderRadius: BorderRadius.circular(3.0),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(3),
                    bottomRight: Radius.circular(3)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[300].withOpacity(0.0),
                    spreadRadius: 0.0,
                    blurRadius: 0.0,
                  )
                ],
                color: Colors.red[400]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    product.numberOfItemsForAnOrder = count.toString();
                    decrement(id, product);
                  },
                  child: Icon(Icons.remove_circle_outline,
                      color: Colors.white, size: 24.0),
                ),
                Text(
                  '$count',
                  style: TextStyle(
                      fontFamily: 'Varela',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0),
                ),
                GestureDetector(
                    onTap: () {
                      //  Product product2 = new Product(id,product.name,product.ima,price,detail);
                      product.numberOfItemsForAnOrder = count.toString();
                      // update the number of items
                      increment(id, product);
                      // print('id = $id');
                    },
                    child: Icon(Icons.add_circle_outline,
                        color: Colors.white, size: 24))
              ],
            ),
          )
        : InkWell(
            onTap: () {
              // Product product = new Product(id,name,imagePath,price,detail);
              product.numberOfItemsForAnOrder = count.toString();
              // update the number of items
              increment(id, product);
            },
            child: Container(
              height: 30,
              // color: Colors.green,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(3),
                      bottomRight: Radius.circular(3)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[400].withOpacity(0.3),
                      spreadRadius: 4.0,
                      blurRadius: 6.0,
                    )
                  ],
                  color: Colors.green[400]),
              child: Center(
                child: Text(
                  'ADD TO CART',
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
