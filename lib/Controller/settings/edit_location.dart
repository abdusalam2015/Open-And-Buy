import 'package:OpenAndBuy/Controller/constant.dart';
import 'package:OpenAndBuy/Model/localization/localizationConstants.dart';
import 'package:OpenAndBuy/Model/store.dart';
import 'package:OpenAndBuy/Service/storeDatabase.dart';
import 'package:OpenAndBuy/Service/store_notifier.dart';
import 'package:flutter/material.dart';
import 'package:OpenAndBuy/Controller/constants/colors.dart';

import 'package:google_map_location_picker/google_map_location_picker.dart';

import 'package:provider/provider.dart';

class EditStoreLocation extends StatefulWidget {
  @override
  _EditStoreLocationState createState() => _EditStoreLocationState();
}
StoreDetail storeDetail;
class _EditStoreLocationState extends State<EditStoreLocation> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _txtFormCtrl = TextEditingController();
  bool loading = false;
  String newAddress='';
  String error = '';
  String lat = '';
  String long = '';
   @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _txtFormCtrl.dispose();
    super.dispose();
  }
   String value(String key) {
    return getTranslated (context, key);
  }

  void initState() {

    super.initState();
    _txtFormCtrl.addListener(() {
      final text = _txtFormCtrl.text;
      _txtFormCtrl.value = _txtFormCtrl.value.copyWith(
        text: text,
        selection:
      TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
  }
  @override
  Widget build(BuildContext context) {
 StoreNotifier storeNotifier = Provider.of<StoreNotifier>(context);
 _txtFormCtrl.text = ( newAddress  == '')? storeNotifier.storeDetail.location : newAddress;
  storeDetail  = storeNotifier.storeDetail;    return Scaffold(
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
                value('updateLocation'), 
                style: TextStyle(color: Colors.grey, fontSize: 17.0),),
                SizedBox(height: 10.0,),
                TextFormField(
                  controller: _txtFormCtrl,
                 // decoration:  textInputDecoration(value('address')).copyWith(hintText:value('addressHint')),
                  // countrol the max chars in the first name 
                  validator: (val) =>  val.isEmpty || val == ''  ?value('notBeEmpty'): null,
                  onChanged: (val){
                    setState(() {
                      newAddress = val;
                    });
                  }
                ),
                SizedBox(height: 20.0,),
                  getNewLocation(),
                  
                SizedBox(height: 40.0,),
                Center(
                  child: ButtonTheme(
                    minWidth: 300,
                    height: 55,
                    child: RaisedButton(
                    elevation: 0.0,
                    color:BUTTONCOLOR,
                    highlightColor: Colors.red,
                     child: Text(
                      value('save') ,
                      style: TextStyle(color: Colors.white,fontSize: 22, ),
                      ),
                      onPressed: () async{
                      if(_formKey.currentState.validate()){
                        setState((){
                        loading = true;
                        });
                        try{
                        // await StoreDatabaseService().updateStoreLocation(
                        //   lat == ''? storeDetail.latitude:lat,
                        //   long == ''? storeDetail.longitude:long,
                        //   newAddress == ''? storeDetail.location:newAddress,
                        //   storeDetail.sid);
                        loading = false;
                        // return TRUE to the previous page to show the SnackBar
                        Navigator.of(context).pop(true);
                             }catch (e){
                               print(e);
                               setState(() {
                                  error = value('addValidName');
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
            ],
            ),
          )
        ),
     ) 
     );

      
  }
  Widget getNewLocation(){
    return Center(
                  child: ButtonTheme(
                    minWidth: 100,
                    height: 40,
                    child: RaisedButton(
                    elevation: 0.0,
                    color:Colors.green,
                    highlightColor: Colors.red,
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                         Text(
                          value('useGoogleMapButton') ,
                          style: TextStyle(color: Colors.white,fontSize: 14, ),
                          ),
                          Icon(Icons.edit_location),
                       ],
                     ),
                      onPressed: ()async{
                      LocationResult mylocation = await showLocationPicker(
                      context,
                      'AIzaSyBwq6jURpuskUG8UoYj7IOJf_B3o0oRims',
                      automaticallyAnimateToCurrentLocation: true,
                       //initialCenter: LatLng(31.1975844, 29.9598339)
                      myLocationButtonEnabled: true,
                      layersButtonEnabled: true, );
                      if(mylocation != null){
                      newAddress =  mylocation.address;
                      _txtFormCtrl.text = newAddress;
                      lat = mylocation.latLng.latitude.toString();
                      long = mylocation.latLng.longitude.toString();
                      }else{
                        ////
                      }
                      },
                    )
                  )
                  );   
  }
  }
