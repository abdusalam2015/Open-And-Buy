import 'package:flutter/material.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:volc/Admin/Controller/edit_store_pages/edit_store_account.dart';
import 'package:volc/Admin/Service/storeDatabase.dart';
import 'package:volc/SharedModels/store/store.dart';
import 'package:volc/SharedWidgets/constant.dart';
import 'dart:io';

import 'package:volc/SharedWidgets/shared_functions.dart';
import 'package:volc/User/Model/user_detail.dart';

class RegisterYourStore extends StatefulWidget {
  final UserDetail userDetail;
  final BuildContext cont;
  RegisterYourStore(this.userDetail,this.cont);
  @override
  _RegisterYourStoreState createState() => _RegisterYourStoreState();
}

class _RegisterYourStoreState extends State<RegisterYourStore> {
 // final AuthService _auth = new AuthService();
  final StoreDatabaseService _store = new StoreDatabaseService();
  final _formKey2 = GlobalKey<FormState>();
  bool loading = false;
  StoreDetail storeDetail = new StoreDetail(sid:'',email:'',name:'',location:'',
  backgroundImage:'',coveredArea:'',storeType:'',phoneNumber:'',
  storeStatus:'',latitude:'',longitude:'') ;
  String email;
  String password;
  String error = '';
  final SharedFunctions sharedfun = new SharedFunctions();
  bool isUploaded = false;
  File img;
  @override
  Widget build(BuildContext context) {
    
    //creating new initailized store's object  to avoid nulls value
  //storeDetail = _store.initStore(storeDetail);
    return  Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        title: Text('Register Your Store in Volc'),
      ),
      body: Builder(
        builder: (context) => ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
              child:  Form(
                key: _formKey2,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0,),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText:'Store Name'),
                      validator: (val) =>  val.isEmpty || val =='' ?'Enter Store Name':null,
                      onChanged: (val){
                        setState(() {
                          storeDetail.name = val;
                        });
                      }
                    ),
                    // SizedBox(height: 20.0,),
                    // TextFormField(
                    //   decoration: textInputDecoration.copyWith(hintText:'Email'),
                    //   validator: (val) =>  val.isEmpty || val =='' ?'Enter an email':null,
                    //   onChanged: (val){
                    //     setState(() {
                    //       storeDetail.email = val;
                    //     });
                    //   }
                    // ),
                    // SizedBox(height: 20.0,),

                    // TextFormField(
                    //   decoration: textInputDecoration.copyWith(hintText:'Location'),
                    //   validator: (val) =>  val.isEmpty || val =='' ?'Enter the store Location':null,
                    //   onChanged: (val){
                    //     setState(() {
                    //       storeDetail.location = val;
                    //     });
                    //   }
                    // ),
                    //               SizedBox(height: 20.0,),

                    // TextFormField(
                    //   decoration: textInputDecoration.copyWith(hintText:'Phone Number'),
                    //   validator: (val) =>  val.isEmpty || val =='' ?'Enter Phone Number':null,
                    //   onChanged: (val){
                    //     setState(() {
                    //       storeDetail.phoneNumber = val;
                    //     });
                    //   }
                    // ),
                    // SizedBox(height: 20.0,),
                    // TextFormField(
                    //   decoration: textInputDecoration.copyWith(hintText:'Password'),
                    //   obscureText: true,
                    //   validator: (val) =>  val.length< 6 ? 'Enter a password 6+ chars long': null,
                    //   onChanged: (val){
                    //     setState(() {
                    //       storeDetail.password = val;
                    //     });
                    //   } ),
                    SizedBox(height: 20.0,),
                    RaisedButton(
                      color:Colors.pink[400],
                      child: Text(
                        'Save & Next ->',
                        style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async{
                         // print("dkfasjl");
                           if(_formKey2.currentState.validate()){//_formKey2.currentState.validate()
                             setState(() => loading = true);
                              
                            //   StoreDetail storeDetail = new StoreDetail( sid: '','','','','','','','','',) ;
                              LocationResult storeLocation = await showLocationPicker(
                                widget.cont,
                                'AIzaSyBwq6jURpuskUG8UoYj7IOJf_B3o0oRims',
                                automaticallyAnimateToCurrentLocation: true,
                                //initialCenter: LatLng(31.1975844, 29.9598339)
                                myLocationButtonEnabled: true,
                                layersButtonEnabled: true, );
                                storeDetail.sid = widget.userDetail.userID;
                                storeDetail.coveredArea = '';
                                storeDetail.storeType = '';
                                storeDetail.email = widget.userDetail.email;
                                storeDetail.latitude = storeLocation.latLng.latitude.toString();
                                storeDetail.longitude = storeLocation.latLng.longitude.toString();
                                storeDetail.location = storeLocation.address.toString();
                             dynamic result  = await _store.updateStoreData(storeDetail);
                              if (result != null){
                                setState(() {
                                  error = 'Registration Problem!!';
                                  loading = false;
                                });
                              }else {
                                print('GOOOD TO GO');
                              setState(() => loading = false);
                              Navigator.pop(context);
                              
                                final result = Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => EditStoreAccount(
                                        widget.cont,
                                        storeDetail,
                                      )
                                    )
                              ); 
                              // make sure that if it is already updated or not
                                result != null ? Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text('Name Updated', style: TextStyle(color: Colors.white),),
                                backgroundColor: Colors.green)):Container();

                              }
                             }
                        },
                    ),
                    SizedBox(height: 12.0,),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red,fontSize: 14.0),
                    )
                ],),
              )
            ),
          ],
        ),
      ),
    );
  }
}


