import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_now/pages/home/app_bar.dart';
import 'package:shopping_now/pages/home/cart_bloc.dart';
import 'package:shopping_now/pages/product/product.dart';
import 'package:shopping_now/pages/store_pages/products.dart';

 class StorePage extends StatefulWidget{
  final imgPath, storeDiscount, storeName;
  StorePage({this.imgPath, this.storeDiscount, this.storeName});
  @override
  _StorePageState createState() => _StorePageState();
  }

class _StorePageState extends State<StorePage> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<CartBloc>(context);
    int totalCount = 0;
    if (bloc.cart.length > 0) {
      totalCount = bloc.cart.values.reduce((a, b) => a + b);
    }
    Product product = null;
    void _increment(String index,Product product){
      setState((){
        bloc.addToCart(index,product);
        print(totalCount );
       });
    }
    void _decrement(String index,Product product){
      setState((){
        bloc.subToCart(index,product);
        print(totalCount );
       });
    }
    return Scaffold(
      appBar:appBar(true,context),
      body: ListView(
        padding: EdgeInsets.only(left: 20.0),
        children: <Widget>[
          SizedBox(height: 10.0),
          Text(
            'Categories',
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 5.0),
          TabBar(
              controller: _tabController,
              indicatorColor: Colors.transparent,
              labelColor: Colors.pink[400],
              isScrollable: true,
              labelPadding: EdgeInsets.only(right: 45.0),
              unselectedLabelColor: Color(0xFFCDCDCD),
              tabs: [
                Tab(child: categoryText('Drinks',14.0),),
                 Tab(child: categoryText('Fresh Fruits',14.0)),
                // Tab(child: categoryText('Veg',14.0)),
                // Tab(child: categoryText('Mixed',14.0)),
                // Tab(child: categoryText('Cleaners',14.0)),
                // Tab(child: categoryText('Alcoholic Drinks',14.0)),
                // Tab(child: categoryText('Chocolate',14.0)),
              ]),
              Container(
                height: MediaQuery.of(context).size.height - 50.0,
                width: double.infinity,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                   // products('drinks',context),
                    
                    Products(_increment,_decrement,product),
                    Products(_increment,_decrement,product),

                    // products('fresh_fruits',context),
                    // products('veg',context),
                    // products('normal',context),
                    // products('cleaner',context),
                    // products('alcoholic_drinks',context),
                    // products('chocolate',context),
                  ]
                  )
              )
        ],
      ),
    );
  }
  Widget categoryText(String text, double fsize){
    return Text(
      text,
    style: TextStyle(
            fontFamily: 'Varela',
            fontSize: fsize,
          ));
  }
  // Widget products(categoryName,context){
  //   return ListView(
  //       children: <Widget>[
  //               if(categoryName == 'drinks') ...{
  //               productCard('Milk', '20 SEK','assets/drinks/1.png',false,context),
  //               productCard('Strawberry', '\$5.99','assets/drinks/2.png',true,context),
  //               productCard('Juice', '\$1.99','assets/drinks/3.png',false,context),
  //               productCard('RedBull', '\$2.99','assets/drinks/6.png',true,context),
  //               productCard('RedBull', '\$3.99','assets/drinks/7.png',false,context),
  //               productCard('Celsius', '\$5.99','assets/drinks/9.png',false,context),
  //               productCard('Another One', '\$1.99','assets/drinks/10.png',false,context),
  //               productCard('Wolverine', '\$2.99','assets/drinks/11.png',false,context),
  //               productCard('Pepsi', '\$1.99','assets/drinks/12.png',true,context),
  //               productCard('drink', '\$2.99','assets/drinks/33.png',false,context),
  //               }else if(categoryName == 'chocolate')...{
  //               productCard('Ice-Cream', '\$3.99','assets/chocolate/1.png',true,context),
  //               productCard('Swebar', '\$5.99','assets/chocolate/2.png',false,context),
  //               productCard('Morabou', '\$1.99','assets/chocolate/3.png',false,context),
  //               productCard('Maryland', '\$2.99','assets/chocolate/4.png',false,context),
  //               }else if(categoryName == 'alcoholic_drinks')...{
  //               productCard('Fever-Tree', '\$3.99','assets/alcoholic_drinks/1.png',false,context),
  //               productCard('Vodka', '\$5.99','assets/alcoholic_drinks/2.png',true,context),
  //               productCard('Vodka Moscco', '\$1.99','assets/alcoholic_drinks/3.png',false,context),
  //               productCard('Beer', '\$2.99','assets/alcoholic_drinks/4.png',false,context),
  //               }else if(categoryName == 'veg')...{
  //               productCard('Salad', '\$3.99','assets/veg/1.png',false,context),
  //               productCard('Lemon', '\$5.99','assets/veg/9.png',true,context),
  //               productCard('Lettuce', '\$1.99','assets/veg/10.png',false,context),
  //               }else if(categoryName == 'fresh_fruits')...{
  //               productCard('Banana', '\$3.99','assets/fresh_fruits/1.png',false,context),
  //               productCard('Mango', '\$5.99','assets/fresh_fruits/2.png',true,context),
  //               productCard('Red Apples', '\$1.99','assets/fresh_fruits/8.png',false,context),
  //                }else if(categoryName == 'cleaner')...{
  //               productCard('Shampo', '\$3.99','assets/cleaner/1.png',false,context),
  //               productCard('Ajax', '\$5.99','assets/cleaner/2.png',false,context),
  //               productCard('NO', '\$1.99','assets/cleaner/3.png',true,context),
  //               productCard('Cleaner', '\$2.99','assets/cleaner/4.png',false,context),
  //                }else ...{
  //               productCard('Fast Food', '\$3.99','assets/normal/6.png',false,context),
  //               productCard('Buttato', '\$5.99','assets/normal/2.png',true,context),
  //               productCard('Chips', '\$1.99','assets/normal/3.png',false,context),
  //               productCard('Chips Cheese', '\$2.99','assets/normal/4.png',false,context),
  //                }
  //             ],
              
          
  //      );
  // }
  // Widget productCard(String name , String price, String imagePath, bool added,context){
  // return Container(
  //   padding: EdgeInsets.only(right: 15.0),
  //   width: MediaQuery.of(context).size.width - 30.0,
  //   height: MediaQuery.of(context).size.height - 50.0,
  //   child: GridView.count(
  //     crossAxisCount: 3,
  //     primary: false,
  //     crossAxisSpacing: 5.0,
  //     mainAxisSpacing: 5.0,
  //     childAspectRatio: 0.5,
  //     children: [
  //   Padding(
  //     padding: EdgeInsets.only(top:3,left: 3,right: 3,bottom: 1),
  //     child: InkWell(
  //       onTap: (){
  //         Navigator.of(context).push(
  //           MaterialPageRoute(
  //             builder: (context) => ProductDetail(
  //               imgPath: imagePath,
  //               price: price , 
  //               productName: name 
  //             )
  //           )
  //           );        
  //       },
  //       child: Container(
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(5.0),
  //             boxShadow: [
  //               BoxShadow(
  //                 color: Colors.grey[400].withOpacity(0.3),
  //                 spreadRadius: 4.0,
  //                 blurRadius: 6.0,
                  
  //               )
  //             ],
  //             color: Colors.white
  //         ),
  //         child: Column(
  //           children: <Widget>[
  //             Padding(
  //               padding: EdgeInsets.all(5.0),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.end,
  //                 children: <Widget>[
  //                   added ? Icon(Icons.favorite, color: Colors.pink[400] ):Icon(Icons.favorite_border,color: Colors.pink[400],)
  //                 ],
  //               ),
  //             ),
  //             Hero(
  //               tag: imagePath,
  //               child: Container(
  //                 height: 90.0,
  //                 width: 90.0,
  //                 decoration: BoxDecoration(
  //                   image: DecorationImage(
  //                     image: AssetImage(imagePath),
  //                     fit: BoxFit.contain
  //                   )
  //                 ),
  //               ),
  //             ),
  //             SizedBox(height: 7.0),
  //             Text(
  //               price,
  //               style: TextStyle(
  //                 color: Colors.pink[400],
  //                 fontFamily: 'Varela',
  //                 fontSize: 14.0
  //               ),
  //             ),
  //              Text(
  //               name,
  //               style: TextStyle(
  //                 color: Color(0xFF575E67),
  //                 fontFamily: 'Varela',
  //                 fontSize: 14.0
  //               ),
  //             ),
  //           Padding(
  //             padding: EdgeInsets.all(8.0),
  //             child: Container(color: Color(0xFFEBEBEB),height: 1.0,),
  //             ),
  //             Padding(
  //               padding: EdgeInsets.only(left: 5.0, right: 5.0),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                 children: <Widget>[
  //                   if(!added) ... [
  //             GestureDetector(
  //             onTap: () {


                
  //              // bloc.addToCart(index);
  //             // print('df');
  //             },
  //             child: Container(
  //               height: 20,
  //               width: 70,
  //               child: Text(
  //                       'Add to cart',
  //                       style: TextStyle(
  //                         fontFamily: 'Varela',
  //                         color: Colors.pink[500],
  //                         fontSize: 12.0
  //                       ),
  //                     ),
  //             )
  //             ),

                      
  //                     //Icon(Icons.shopping_basket, color: Colors.pink[400], size: 12.0,),
                      
                      
  //                   ],
  //                    if(added)...{
  //                     Icon(Icons.remove_circle_outline, color: Colors.pink[400], size: 12.0),
  //                     Text(
  //                       '3',
  //                       style: TextStyle(
  //                         fontFamily: 'Varela',
  //                         color: Colors.pink[400],
  //                         fontWeight: FontWeight.bold,
  //                         fontSize: 12.0
  //                       ),
  //                     ),
  //                     Icon(Icons.add_circle_outline, color: Colors.pink[400], size: 12)
  //                    },
  //                 ],
  //                  ),  
  //             )
  //           ],
  //         ),
  //       ),
  //       ),
  //       )
  //     ])
  // );
  // }
}