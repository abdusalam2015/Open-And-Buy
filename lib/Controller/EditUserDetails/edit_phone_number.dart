import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:OpenAndBuy/Controller/constant.dart';
import 'package:OpenAndBuy/Model/user_detail.dart';
import 'package:OpenAndBuy/Service/database.dart';

class EditPhoneNumber extends StatefulWidget {
final BuildContext cont;
EditPhoneNumber(this.cont);
  @override
  _EditPhoneNumberState createState() => _EditPhoneNumberState();
}
UserDetail userDetail;
class _EditPhoneNumberState extends State<EditPhoneNumber> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String newPhoneNumber='';
  String error = '';
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
                  initialValue:userDetail.phoneNumber,
                  decoration: textInputDecoration.copyWith(hintText:'Phone Number'),
                  keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly
                    ],
                  // countrol the max chars in the first name 
                  maxLength: 15,
                  validator: (val) =>  val.isEmpty || val == ''  ?'Enter Your Phone Number': null,
                  onChanged: (val){
                    setState(() {
                      newPhoneNumber = val;
                    });
                  }
                ),
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
                          setState((){loading = true;});
                          try{
                            await DatabaseService(uid: userDetail.userID).updateUserData(
                            email:userDetail.email,
                            firstName:userDetail.firstName,
                            lastName:userDetail.lastName,
                            // make sure if the value is empty, save with the previous value
                            phoneNumber: (newPhoneNumber =='' ? userDetail.phoneNumber:newPhoneNumber),
                            address:userDetail.address, 
                            photoURL:userDetail.photoURL,                   
                            latitude: userDetail.latitude,
                            longitude:userDetail.longitude,);
                            loading = false;
                            // return TRUE to the previous page to show the SnackBar
                            Navigator.of(context).pop(true);
                          }catch (e){
                            print(e);
                            setState(() {
                              error = 'Please supply a valid phone Number';
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