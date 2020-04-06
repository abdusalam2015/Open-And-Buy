import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volc/User/Controller/wrapper.dart';
import 'package:volc/User/Model/cart_bloc.dart';
import 'package:volc/User/Model/user.dart';
import 'package:volc/User/Service/user/auth.dart';
import 'package:volc/examples/sign_up%20un.dart';
  
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
          value: AuthService().user,
          child: ChangeNotifierProvider<CartBloc>(
            create: (context) => CartBloc(),
            child: MaterialApp(
       // debugShowCheckedModeBanner: false,
        routes:{
        '/signup':( context) => new SignUp(),
      },
      home: Wrapper(),
      )
      ),
         
    );
  }
}

