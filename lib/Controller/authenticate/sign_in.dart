import 'package:OpenAndBuy/Controller/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:OpenAndBuy/Controller/constant.dart';
import 'package:OpenAndBuy/Controller/loading.dart';
import 'package:OpenAndBuy/Service/auth.dart';
class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = new AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading =false;

  String email = '';
  String password = '';
  String error = '';
  Widget build(BuildContext context) {
    
    return loading? Loading(): Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        backgroundColor: APPBARCOLOR,
        elevation: 0.0,
        title: Text('Sign In'),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: ()  {
              widget.toggleView();
            },
            icon: Icon(Icons.person),
            label: Text('Register'))
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
                decoration: textInputDecoration('Email').copyWith(hintText:'Email'),
                validator: (val) =>  val.isEmpty || val =='' ?'Enter an email':null,
                onChanged: (val){
                  setState(() {
                    email = val;
                  });
                }
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputDecoration('Email').copyWith(hintText:'Password'),
                validator: (val) =>  val.length< 6 ? 'Enter a password 6+ chars long': null,
                obscureText: true,
                onChanged: (val){
                  setState(() {
                    password = val;
                  });
                }
              ),
              SizedBox(height: 20.0,),
              RaisedButton(
                color:APPBARCOLOR,
                child: Text(
                  'Sing in',
                  style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async{
                     if(_formKey.currentState.validate()){
                      setState(() => loading = true);
                       dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                        if (result == null){
                          setState(() {
                          error = 'Could not sign in with those credentials';
                          loading = false;
                        });
                       }
                     }
                  }
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