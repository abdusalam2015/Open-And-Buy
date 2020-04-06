import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volc/User/Controller/authenticate/authenticate.dart';
import 'package:volc/User/Controller/home/home.dart';
import 'package:volc/User/Model/user.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if(user == null){
      return Authenticate();
    }else{
      return Home();
    }
  }
}