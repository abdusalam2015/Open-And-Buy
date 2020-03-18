import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_now/pages/home/cart_bloc.dart';
import 'package:shopping_now/pages/home/home.dart';
  
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CartBloc>(
        create: (context) => CartBloc(),
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    ));
  }
}

