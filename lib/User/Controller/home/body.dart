import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:volc/Admin/Controller/store_home_pages/store_page.dart';
import 'package:volc/Admin/Service/storeDatabase.dart';
import 'package:volc/SharedModels/product/product.dart';
import 'package:volc/SharedModels/store/category.dart';
import 'package:volc/SharedModels/store/store.dart';
import 'package:volc/User/Model/user_detail.dart';
import 'package:volc/location/location.dart';

class Body extends StatefulWidget {
  final BuildContext cont;
  final List<StoreDetail> storesList;
  Body(this.cont,this.storesList);
  @override
  _BodyState createState() => _BodyState();
}
UserDetail userDetail;
class _BodyState extends State<Body> {
   @override
  Widget build(BuildContext context) {
    userDetail = Provider.of<UserDetail>(widget.cont);
    return  ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: widget.storesList != null ? widget.storesList.length : 0 ,
      itemBuilder: (context, i){
        return InkWell(
        child: _buildCard(widget.storesList[i], false, context),
        onTap: () async {
          ProgressDialog dialog = new ProgressDialog(context);
          dialog.style(
            message: 'Please wait...'
          );
          await dialog.show();
          StoreDatabaseService obj = new StoreDatabaseService(sid: userDetail.userID);   
          List<Category> categoryList;
          List<Product> productsList;
      try{
        categoryList  =  await obj.getcategories(widget.storesList[i].sid);
        }catch(e){}
      try{ 
      productsList =  await obj.getStoreProducts(widget.storesList[i].sid,
      (categoryList.length > 0 ) ?categoryList[0].categoryID:'') ;
      }catch(e){}
      await dialog.hide();
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => StorePage(  
            storeDetail:widget.storesList[i],
            cont: widget.cont,
            categoryList:categoryList,
            productsList:productsList,
      )));
      }
      ); 
       },   
  );
  }
  Widget _buildCard( StoreDetail storeDetail,
      bool isFavorite, context) {
        // String name, String dis, String imgPath, String location,
        // widget.storesList[i].name, widget.storesList[i].email,
        // widget.storesList[i].backgroundImage,
        // widget.storesList[i].coveredArea

  return Padding(
  padding: EdgeInsets.all(5),
  child: InkWell(
    // onTap: () async{
    //   StoreDatabaseService obj = new StoreDatabaseService(sid: userDetail.userID);   
    //   List<Category> categoryList;
    //   StoreDetail storeDetail;
    //   List<Product> productsList;
    //   try{categoryList  =  await obj.getcategories(userDetail.userID);}catch(e){}
    //  // try{ storeDetail = await obj.getStoreInfo(userDetail.userID.toString());}catch(e){}
    //   try{ productsList=  await obj.getStoreProducts(userDetail.userID,
    //   (categoryList.length >0 ) ?categoryList[0].categoryID:'') ;}catch(e){}
    //   Navigator.of(context).push(
    //       MaterialPageRoute(builder: (context) => StorePage(
    //         storeDetail:storeDetail,
    //         cont: widget.cont,
    //         categoryList:categoryList,
    //         productsList:productsList,
    //       )));
    // },
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
                    isFavorite ? Icon(Icons.star_half, color: Colors.yellow)
                               : Icon(Icons.star,color: Colors.yellow),
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
              tag: storeDetail.sid,
              child: Container(
                height: 140.0,
                width: 300.0,
                decoration: BoxDecoration(
                      image: DecorationImage(
                          image: storeDetail.backgroundImage != '' && storeDetail.backgroundImage != null  ?
                        NetworkImage(storeDetail.backgroundImage)
                        :AssetImage( 'assets/storesImages/netto.png' ),
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
                        storeDetail.name,
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
                    Location.calculateDistance(
                        double.parse(storeDetail.latitude).toDouble(), double.parse(storeDetail.longitude).toDouble(),
                        double.parse(userDetail.latitude).toDouble(),  double.parse(userDetail.longitude).toDouble()).toString(),
                    // storeDetail.longitude,
                        

                        style: TextStyle(
                            fontFamily: 'Varela',
                            color: Colors.white,
                            fontSize: 18.0)
                      ),
                      ],
                      ) , 
                      ],
                      ),  
                  ] 
                  ),
                  ),
                  ]),
                )
            )
          );
      }
    }