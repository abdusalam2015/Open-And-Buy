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
          productCard( '1' ,'Milk', '20 SEK','assets/drinks/1.png',true,context,'Hi'),                    
          productCard( '1' ,'Milk', '20 SEK','assets/drinks/1.png',true,context,'Hi'),                    
          productCard( '1' ,'Milk', '20 SEK','assets/drinks/1.png',true,context,'Hi'),                    
          productCard( '1' ,'Milk', '20 SEK','assets/drinks/1.png',true,context,'Hi'),                    
          productCard( '1' ,'Milk', '20 SEK','assets/drinks/1.png',true,context,'Hi'),                    
          productCard( '1' ,'Milk', '20 SEK','assets/drinks/1.png',true,context,'Hi'),                    

                  ],   
           ),
      );
    }
  Widget productCard(String id,String name ,  String price, String imagePath, bool added,context, String detail){
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
                child: Center(
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
                ),
              ),
            ),
          ],     
        ),  
      );
  }
}