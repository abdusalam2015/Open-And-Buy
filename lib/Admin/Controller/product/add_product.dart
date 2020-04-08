import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:volc/Admin/Controller/product/category_list.dart';
import 'package:volc/Admin/Controller/store_home_pages/store_home_page.dart';
import 'package:volc/Admin/Service/storeDatabase.dart';
import 'package:volc/SharedModels/store/category.dart';
import 'package:volc/SharedModels/store/store.dart';
import 'package:volc/SharedWidgets/constant.dart';
import 'package:volc/SharedWidgets/shared_functions.dart';
import 'package:volc/User/Model/user_detail.dart';
import 'package:volc/User/Service/user/auth.dart';

class AddProduct extends StatefulWidget {
  final List<Category> categoriesList;
  final BuildContext cont;
  final StoreDetail storeDetail;
  AddProduct(this.cont,this.storeDetail,this.categoriesList);
  @override
  _AddProductState createState() => _AddProductState();
}
class _AddProductState extends State<AddProduct> {
  final SharedFunctions sharedfun = new SharedFunctions();
  bool loading = false;
  UserDetail userDetail ;
  File img;
  double c_width;
  String error='';
  final AuthService _auth = new AuthService();
  final StoreDatabaseService _store = new StoreDatabaseService();
  final _formKey2 = GlobalKey<FormState>();
  //StoreDetail storeDetail = new StoreDetail('','','','','','','','','',) ;
  bool isUploaded = false;
  @override
  Widget build(BuildContext context){
  userDetail = Provider.of<UserDetail>(widget.cont);
  c_width = MediaQuery.of(context).size.width*0.8;
    return Scaffold(
      body: Builder(
        builder: (context) => CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 100.0,
              pinned: true,
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Add Product',style: TextStyle(fontSize: 22,color: Colors.white),),
              ),
              backgroundColor: Colors.black,
              ),
               SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index){
                    if(index == 0)return profilePicture(context);
                    else if(index == 1)return CategoriesList(widget.storeDetail,userDetail,widget.categoriesList); 
                    else if(index == 2)return _form(userDetail);
                    // else if(index == 2)return location('Location',  widget.storeDetail.location,context);
                    // else if(index == 3)return phoneNumber('Phone Number', widget.storeDetail.phoneNumber,true,context);
                    // else if(index == 4)return email('Email', widget.storeDetail.email, false,context );
                    // else if(index == 5)return password('Password', '.......');
                    else return SizedBox(height: 300,);  
                  }, //=>items(index), 
                  childCount: 4,
                ),
                ),
                ],
              ), 
               
          ),

        );
  }
  Widget _form(userDetail){
    String error='';
    return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
              child:  Form(
                key: _formKey2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 20.0,),
                    Text('Product Name',style: TextStyle(fontWeight: FontWeight.bold)),SizedBox(height: 5,),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText:'Product Name'),
                      validator: (val) =>  val.isEmpty || val =='' ?'Enter Product Name':null,
                      onChanged: (val){
                        setState(() {
                          widget.storeDetail.name = val;
                        });
                      }
                    ),
                    SizedBox(height: 20.0,),
                    Text('Product Price',style: TextStyle(fontWeight: FontWeight.bold)),SizedBox(height: 5,),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText:'Price'),
                      validator: (val) =>  val.isEmpty || val =='' ?'Enter the Product Price':null,
                      onChanged: (val){
                        setState(() {
                          widget.storeDetail.location = val;
                        });
                      }
                    ),
                    SizedBox(height: 20.0,),
                    Text('Product Description:',style: TextStyle(fontWeight: FontWeight.bold)),SizedBox(height: 5,),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText:'Description'),
                      validator: (val) =>  val.isEmpty || val =='' ?'Enter product description':null,
                      onChanged: (val){
                        setState(() {
                          widget.storeDetail.email = val;
                        });
                      }
                    ),
                    SizedBox(height: 60.0,),
                    ButtonTheme(
                      height: 60,
                      minWidth: 300,
                       child: RaisedButton(
                        color:Colors.black,
                        child: Text(
                          'ADD PRODUCT',
                          style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async{
                             if(_formKey2.currentState.validate()){//_formKey2.currentState.validate()
                               setState(() => loading = true);
                            dynamic result ;// = await _store.addProduct(storeDetail,userDetail.userID);
                                if (result != null){
                                  setState(() {
                                    error = 'Error!!';
                                    loading = false;
                                  });
                                }else {
                                  print('GOOOD TO GO');
                                  setState(() => loading = false);
                                 Navigator.pop(context);
                                //   final result = Navigator.of(context).push(
                                //       MaterialPageRoute(
                                //         builder: (context) => EditStoreAccount(
                                //           widget.cont,
                                //           storeDetail,
                                //         )
                                //       )
                                // ); 
                                // make sure that if it is already updated or not
                                  // result != null ? Scaffold.of(context).showSnackBar(SnackBar(
                                  // content: Text('Last Name Updated', style: TextStyle(color: Colors.white),),
                                  // backgroundColor: Colors.green)):Container();

                                }
                               }
                          },
                      ),
                    ),
                    SizedBox(height: 12.0,),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red,fontSize: 14.0),
                    )
                ],),
              )
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
              Text('Add',style: TextStyle(color: Colors.white,fontSize: 20),),
              ],
          ),
            onPressed: () async{
                  Navigator.pop(context);
                    final result = Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => StoreHomePage(
                           widget.cont,
                            widget.storeDetail,
                          )
                        )); 
              // make sure that if it is already updated or not
                // result != null ? Scaffold.of(context).showSnackBar(SnackBar(
                // content: Text('Saved!', style: TextStyle(color: Colors.white),),
                // backgroundColor: Colors.green)):Container();
            }
        ),
      ),
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
                padding: const EdgeInsets.only(top:65.0,left: 80),
                child: CircleAvatar(
                  backgroundColor: (Colors.grey[800]),
                  child: Icon(Icons.add,color: Colors.white,size:40.0),
                  radius: 20.0,
                ),
              ),
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
    if(_image == null){
      setState(() =>loading = false);
     // print('jksldf');
    }else {
      img = _image;
      setState(() =>loading = true);
      await sharedfun.uploadStorePic(_image, userDetail.userID, widget.storeDetail);
      isUploaded = true;
     
      loading = false;
      Scaffold.of(cont).showSnackBar(SnackBar(
      content: Text('Photo Updated', style: TextStyle(color: Colors.white),),
      backgroundColor: Colors.green));
     
      setState(() => loading = false);
    }
     },
   );
}
}