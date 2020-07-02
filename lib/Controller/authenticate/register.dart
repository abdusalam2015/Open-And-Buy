import 'package:flutter/material.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:OpenAndBuy/Controller/constant.dart';
import 'package:OpenAndBuy/Controller/loading.dart';
import 'package:OpenAndBuy/Service/auth.dart';


class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = new AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String email;
  String password;
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign Up in to Volc'),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: ()  {
            widget.toggleView();
          },
            icon: Icon(Icons.person),
            label: Text('Sign In')),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        child:  Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText:'Email'),
                validator: (val) =>  val.isEmpty || val =='' ?'Enter an email':null,
                onChanged: (val){
                  setState(() {
                    email = val;
                  });
                }
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText:'Password'),
                obscureText: true,
                validator: (val) =>  val.length< 6 ? 'Enter a password 6+ chars long': null,
                onChanged: (val){
                  setState(() {
                    password = val;
                  });
                } ),

              SizedBox(height: 20.0,),
              RaisedButton(
                color:Colors.pink[400],
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async{
                     if(_formKey.currentState.validate()){
                       setState(() {
                         loading = true;
                       });
                       LocationResult mylocation = await showLocationPicker(
                      context,
                      'AIzaSyBwq6jURpuskUG8UoYj7IOJf_B3o0oRims',
                      automaticallyAnimateToCurrentLocation: true,
                       //initialCenter: LatLng(31.1975844, 29.9598339)
                      myLocationButtonEnabled: true,
                      layersButtonEnabled: true, );

                       dynamic result  = await _auth.registerWithEmailAndPassword(email, password, mylocation);
                        if (result == null){
                          setState(() {
                            error = 'Please supply a valid email';
                            loading = false;
                          });
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
      
    );
  }
}