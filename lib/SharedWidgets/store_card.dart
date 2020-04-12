import 'package:flutter/material.dart';
import 'package:volc/SharedModels/store/store.dart';


Widget storeCard(StoreDetail storeDetail) {
  return Padding(
    padding: EdgeInsets.all(5),
    child: InkWell(
        onTap: () {
        // Navigator.of(context).push(
        //     MaterialPageRoute(builder: (context) => StorePage(
        //       imgPath: imgPath,
        //       storeDiscount:dis,
        //       storeName: name,
        //       cont: widget.cont, 
        //     )));
        },
    child: Container(
      // height: 50,
      // width: 280,
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
                  //  true ? Icon(Icons.star_half, color: Colors.yellow): Icon(Icons.star,color: Colors.yellow),
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
              tag: 'assets/storesImages/netto.png',
              child: Container(
                height: 140.0,
                width: 300.0,
                decoration: BoxDecoration(
                      image: DecorationImage(
                          image: (storeDetail != null ) ? (storeDetail.backgroundImage != '' && storeDetail.backgroundImage!= null) ?
                          NetworkImage(storeDetail.backgroundImage.toString())
                          :AssetImage('assets/storesImages/netto.png'):AssetImage('assets/storesImages/netto.png'),
                          fit: BoxFit.contain,
                          ),
                    ), 
                ),
          ),
          Padding(
              padding: EdgeInsets.all(1.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      Column(children: <Widget>[
                        Text(
                       storeDetail != null ?storeDetail.name : '',
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
                       storeDetail != null ?storeDetail.coveredArea : '',
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