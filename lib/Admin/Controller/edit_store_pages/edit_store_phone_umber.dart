import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:volc/Admin/Service/storeDatabase.dart';
import 'package:volc/SharedModels/store/store.dart';
import 'package:volc/SharedWidgets/constant.dart';
import 'package:volc/User/Model/user_detail.dart';
class EditStorePhoneNumber extends StatefulWidget {
final BuildContext cont;
final StoreDetail storeDetail;
EditStorePhoneNumber(this.cont,this.storeDetail);
  @override
  _EditStorePhoneNumberState createState() => _EditStorePhoneNumberState();
}

class _EditStorePhoneNumberState extends State<EditStorePhoneNumber> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String newStorePhoneNumber='';
  String error = '';
  UserDetail userDetail;
  @override
  Widget build(BuildContext context) {
  userDetail  = Provider.of<UserDetail>(widget.cont); 
    return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
          leading: IconButton(
          icon:Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop()
        ),
          ),
          body: Builder(
        builder: (context) => Container(
            color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 30.0,horizontal: 20.0),
          child:  Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                'Phone Number', 
                style: TextStyle(color: Colors.grey, fontSize: 17.0),),
                SizedBox(height: 10.0,),
                TextFormField(
                  initialValue:widget.storeDetail.phoneNumber,
                  decoration: textInputDecoration.copyWith(hintText:'Phone Number'),
                  keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly
                    ],
                  maxLength: 15,
                  validator: (val) =>  val.isEmpty || val == ''  ?'Enter Store Location': null,
                  onChanged: (val){
                    setState(() {
                      newStorePhoneNumber = val;
                    }); } ),
                SizedBox(height: 20.0,),
                Center(
                  child: ButtonTheme(
                    minWidth: 300,
                    height: 55,
                    child: RaisedButton(
                    elevation: 0.0,
                    color:Colors.black,
                    highlightColor: Colors.red,
                     child: Text(
                      'SAVE' ,
                      style: TextStyle(color: Colors.white,fontSize: 22, ),
                      ),
                      onPressed: () async{
                      if(_formKey.currentState.validate()){
                             setState(() {
                               loading = true;
                             });
                             
                             try{
                              widget.storeDetail.phoneNumber = (newStorePhoneNumber =='' ?widget.storeDetail.location:newStorePhoneNumber);
                              await StoreDatabaseService().updateStoreData(widget.storeDetail);
                              loading = false;
                              // return TRUE to the previous page to show the SnackBar
                              Navigator.of(context).pop(true);
                             }catch (e){
                               print(e);
                               setState(() {
                                  error = 'Please supply a valid Name';
                                  loading = false;
                                });
                             }     
                          }       
                        },
                    ),
                  ),
                ),
                SizedBox(height: 12.0,),
                Text(
                  error,
                  style: TextStyle(color: Colors.red,fontSize: 14.0),
                )
            ],),
          )
        ),
     ) );
      
  }
}