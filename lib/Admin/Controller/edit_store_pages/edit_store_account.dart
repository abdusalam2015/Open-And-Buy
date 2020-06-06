import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:volc/Admin/Controller/edit_store_pages/edit_store_email.dart';
import 'package:volc/Admin/Controller/edit_store_pages/edit_store_location.dart';
import 'package:volc/Admin/Controller/edit_store_pages/edit_store_name.dart';
import 'package:volc/Admin/Controller/edit_store_pages/edit_store_phone_umber.dart';
import 'package:volc/Admin/Controller/orders/order.dart';
import 'package:volc/Admin/Controller/store_home_pages/appbar_store_page.dart';
import 'package:volc/Admin/Controller/store_home_pages/store_home_page.dart';
import 'package:volc/Admin/Service/order_service.dart';
import 'package:volc/Admin/Service/storeDatabase.dart';
import 'package:volc/SharedModels/product/product.dart';
import 'package:volc/SharedModels/store/category.dart';
import 'package:volc/SharedModels/store/store.dart';
import 'package:volc/SharedWidgets/alert_message.dart';
import 'package:volc/SharedWidgets/shared_functions.dart';
import 'package:volc/User/Model/user_detail.dart';

class EditStoreAccount extends StatefulWidget {

  final BuildContext cont;
  final StoreDetail storeDetail;
  EditStoreAccount(this.cont,this.storeDetail);
  @override
  _EditStoreAccountState createState() => _EditStoreAccountState();
}
class _EditStoreAccountState extends State<EditStoreAccount> {
  final SharedFunctions sharedfun = new SharedFunctions();
  bool loading = false;
  bool isUploaded = false;
  UserDetail userDetail ;
  File img;
  //double c_width;
  @override
  Widget build(BuildContext context){
  userDetail = Provider.of<UserDetail>(widget.cont);
 // c_width = MediaQuery.of(context).size.width*0.8;
    return Scaffold(
      body: Builder(
        builder: (context) => CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 100.0,
              pinned: true,
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Edit Store Account',style: TextStyle(fontSize: 22,color: Colors.white),),
              ),
              backgroundColor: Colors.black,
              ),
               SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index){
                    if(index == 0)return profilePicture(context);
                    else if(index == 1)return storeName('Store Name', widget.storeDetail.name,context);
                    else if(index == 2)return location('Location',  widget.storeDetail.location,context);
                    else if(index == 3)return phoneNumber('Phone Number', widget.storeDetail.phoneNumber,true,context);
                    else if(index == 4)return email('Email', widget.storeDetail.email, false,context );
                    else if(index == 5)return password('Password', '.......');
                    else return button();  
                  }, //=>items(index), 
                  childCount: 7,
                ),
                ),
                ],
              ), 
               
          ),

        );
  }
  Widget button(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ButtonTheme(
        minWidth: 200,
        height: 60,
        child: RaisedButton(
          color:Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Save',style: TextStyle(color: Colors.white,fontSize: 20),),
              Icon(Icons.navigate_next,color:Colors.white),
              Text( 'Next', style: TextStyle(color: Colors.white,fontSize: 20), ),
            ],
          ),
            onPressed: () async{
              ProgressDialog dialog = new ProgressDialog(context);
              dialog.style(message: 'Please wait...');
              await dialog.show();
              try{
              StoreDatabaseService obj = new StoreDatabaseService(sid:widget.storeDetail.sid);  
              StoreDetail myStoreDetail = await obj.getStoreInfo(widget.storeDetail.sid); 
              List<Category> categoriesList =  myStoreDetail != null? await obj.getcategories(widget.storeDetail.sid) :null;
              List<Product> productsList =  myStoreDetail != null? await obj.getStoreProducts(widget.storeDetail.sid,(categoriesList.length >0)?categoriesList[0].categoryID:'') :null;
              OrderService orderService = new OrderService();
              List<Order>orders = myStoreDetail != null? await orderService.getAllStoreOrders(myStoreDetail.sid):null;
              await dialog.hide();
              print(myStoreDetail);
              if(myStoreDetail != null){
                  print('sign!!');

                Navigator.of(context).push(
                MaterialPageRoute( builder: (context) => TabBarStorePage(//StoreHomePage(
                  widget.cont,
                  myStoreDetail,
                  categoriesList,
                  productsList,
                  orders,
                  )
                ));
              }else {
                showAlertDialog(widget.cont,'Not Found','No store registered!');

              }    
              }catch(e){
              // return null;
              }
              



              // StoreDatabaseService obj = new StoreDatabaseService(sid: widget.storeDetail.sid);   
              // List<Category> categoriesList = await obj.getcategories(userDetail.userID);
              //  List<Product> productsList =  await obj.getStoreProducts(userDetail.userID,(categoriesList.length >0)?categoriesList[0].categoryID:'') ;
              //     Navigator.pop(context);
              //       Navigator.of(context).push(
              //           MaterialPageRoute(
              //             builder: (context) =>TabBarStorePage(// StoreHomePage(
              //               widget.cont,
              //               widget.storeDetail,
              //               categoriesList,
              //               productsList
              //             )
              //           )); 
              // make sure that if it is already updated or not
                // result != null ? Scaffold.of(context).showSnackBar(SnackBar(
                // content: Text('Saved!', style: TextStyle(color: Colors.white),),
                // backgroundColor: Colors.green)):Container();
            }
        ),
      ),
    );
  }
 Widget email(String name, String email, bool isVerified ,context){
      return InkWell(
          child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15.0),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Email',
              style: TextStyle(color:Colors.grey, fontSize: 14), ),
              SizedBox(height: 15.0,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[ 
                  Padding(
                    padding: const EdgeInsets.only(top:6.0),
                    child: Container(
                    width: 210,
                    child: Text(email,
                    style: TextStyle(color: Colors.black,fontSize: 18),),
                ),
                  ),SizedBox(width: 40.0,),
                  isVerified? Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: Text('Verified',style: TextStyle(color:Colors.green, fontSize: 14), ),
                  )
                  : Text('Not Verified',style: TextStyle(color:Colors.red, fontSize: 14), ),
                 // SizedBox( height: 15.0),
                ],
              ),
            ],
          ),
        ),
        onTap: ()async{
      final result = await  Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EditStoreEmail(
                widget.cont,
                widget.storeDetail
            ),
      ));
        result != null ? Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Email Updated', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.green)):Container();
        },
      );
}
  Widget phoneNumber(String image, String phoneNumber, bool isVerified ,context){
      return InkWell(
          child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15.0),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Phone Number',
              style: TextStyle(color:Colors.grey, fontSize: 14), ),
              SizedBox(height: 15.0,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 35,
                    width: 35,
                    child: Image.asset('assets/flags/Sweden.png'),
                  ),
                  SizedBox(width: 10.0,),
                  Padding(
                    padding: const EdgeInsets.only(top:6.0),
                    child: Container(
                    width: 210,
                    child: Text(phoneNumber,
                    style: TextStyle(color: Colors.black,fontSize: 18),),
                ),
                  ),
                  isVerified? Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: Text('Verified',style: TextStyle(color:Colors.green, fontSize: 14), ),
                  )
                  : Text('Not Verified',style: TextStyle(color:Colors.red, fontSize: 14), ),
                 // SizedBox( height: 15.0),
                ],
              ),
            ],
          ),
        ),
        onTap: ()async{
      final result = await  Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EditStorePhoneNumber(
                widget.cont,
                widget.storeDetail
            ),
      ));
        result != null ? Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Phone Number Updated', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.green)):Container();
        },
      );
}
  Widget storeName(String text, String name,context ){
      return InkWell(
          child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15.0),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(text,
              style: TextStyle(color:Colors.grey, fontSize: 14), ),
              SizedBox(height: 15.0,),
              Text(name,
              style: TextStyle(color:Colors.black, fontSize: 18), ),
              SizedBox( height: 15.0),
            ],
          ) ,
        ),
        onTap: ()async{
         // Navigator.pop(context);
              final result = await  Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditStoreName(
                       widget.cont,
                       widget.storeDetail
                    )
                  )
            ); 
        // make sure that if it is already updated or not
        result != null ? Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Store Name Updated', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.green)):Container();
        },
      );
      
    }
    Widget location(String text, String name,context ){
      return InkWell(
          child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15.0),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(text,
              style: TextStyle(color:Colors.grey, fontSize: 14), ),
              SizedBox(height: 15.0,),
              Text(name,
              style: TextStyle(color:Colors.black, fontSize: 18), ),
              SizedBox( height: 15.0),
            ],
          ) ,
        ),
        onTap: (){
           // Navigator.pop(context);
               final result = Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditStoreLocation(
                      widget.cont,
                       widget.storeDetail
                    )
                  )
            ); 
             // make sure that if it is already updated or not
        result != null ? Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Location Updated', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.green)):Container();
        },
      );
    }
  Widget password(String text, String name ){
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15.0),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(text,
            style: TextStyle(color:Colors.grey, fontSize: 14), ),
            SizedBox(height: 8.0,),
            Text(name,
            style: TextStyle(color:Colors.black, fontSize: 22,fontWeight: FontWeight.bold), ),
            SizedBox( height: 15.0),
          ],
        ) ,
      );
    }

Widget profilePicture(cont){
   return InkWell(
      child: Padding(
       padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              Stack(
              children: <Widget>[

                // splash screen for updating the profile picture
                loading ? Padding(
                  padding: const EdgeInsets.only(top:30.0,left: 20),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: SpinKitFadingCircle(color: Colors.brown,size: 50.0,),//Text('Loading...')
                  ),
                ): Image(
                image: isUploaded ?  FileImage(img):AssetImage('assets/storeImage.png'),
                //radius: 50.0,
              ),
              Padding(
                padding: const EdgeInsets.only(top:80.0,left: 10),
                child: CircleAvatar(
                  backgroundColor: (Colors.black),
                  child: Icon(Icons.edit,color: Colors.white,size:15.0),
                  radius: 10.0,
                ),
              )
              ]),
                SizedBox(height: 20.0,),
                Divider(color: Colors.grey,thickness: 1, ),
            ],),
     ),
     onTap: () async{
     File _image;
     try{
       _image= await sharedfun.getImage();
       } catch(e){
         print(e);
       }
    if (_image == null) {
      setState(() =>loading = false);
     // print('jksldf');
    } else {
      img = _image;
      setState(() =>loading = true);
      await sharedfun.uploadStorePic(_image, userDetail.userID, widget.storeDetail);
      isUploaded = true;
      loading = false;
      Scaffold.of(cont).showSnackBar(
      SnackBar( content: Text('Photo Updated', style: TextStyle(color: Colors.white),),
      backgroundColor: Colors.green) );
      setState(() => loading = false);
    }
    },
   );
}
}