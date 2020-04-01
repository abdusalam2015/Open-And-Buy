import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volc/models/user.dart';
import 'package:volc/models/user_detail.dart';
import 'package:volc/pages/home/cart_bloc.dart';
import 'package:volc/pages/home/wrapper.dart';
import 'package:volc/pages/user/account_settings.dart';
import 'package:volc/pages/user/sign_up.dart';
import 'package:volc/services/auth.dart';
import 'package:volc/services/database.dart';
  
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    print("objectin the main.");
    print(AuthService().user);
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

