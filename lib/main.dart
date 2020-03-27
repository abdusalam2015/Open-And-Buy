import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volc/pages/home/cart_bloc.dart';
import 'package:volc/pages/home/home.dart';
import 'package:volc/pages/user/account_settings.dart';
import 'package:volc/pages/user/sign_up.dart';
  
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CartBloc>(
        create: (context) => CartBloc(),
        child: MaterialApp(

      debugShowCheckedModeBanner: false,
      routes:{
      '/signup':( context) => new SignUp(),
      '/accountsettings':(context) =>  AccountSettings(),
    },
      home: Home(),
    ));
  }
}

