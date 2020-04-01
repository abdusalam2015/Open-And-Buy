import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volc/models/user.dart';
import 'package:volc/pages/authenticate/authenticate.dart';
import 'package:volc/pages/home/home.dart';

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