import 'dart:io';

import 'package:flutter/material.dart';
import 'package:volc/models/user.dart';
import 'package:provider/provider.dart';
import 'package:volc/models/user_detail.dart';
import 'package:volc/pages/user/account_settings.dart';
import 'package:volc/pages/user/edit_account.dart';
class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    // get the all the users details  ==> look at it in the future
    final userDetail = Provider.of<UserDetail>(context);
    //get the current user details
    final userID = Provider.of<User>(context);
    print(userDetail.photoURL.toString());
    //UserFunctions databaseService = new UserFunctions(userID.uid);
    //UserDetail userDetail= databaseService.getUserDetail(usersDetail);

    
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(top:28.0),
        child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              InkWell(
               child: DrawerHeader(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                  Hero(
                    tag: userDetail.photoURL.toString(),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => EditAccount (
                                userDetail,
                              )
                            )
                            );        
                        },
                      child:CircleAvatar(
                      backgroundImage:userDetail.photoURL.toString() != '' ?
                       NetworkImage(userDetail.photoURL.toString())
                       :AssetImage('assets/profile_picture.png'),
                      radius: 50.0,
                        ),
                      ),
                    ),
                  ),
                    Text(userDetail.first_name + ' '+userDetail.last_name ,
                    style: TextStyle(color: Colors.white,fontSize: 18),),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.black, 
                ),
            ),
            onTap: (){},
            ),
            ListTile(
              title: items('Your Orders',Icon(Icons.history)),
                onTap: () {
                  Navigator.pop(context);//lcose the drawer
                },
              ),
              ListTile(
              title: items('Payment',Icon(Icons.payment)),
                onTap: () {
                  //update
                  Navigator.pop(context);//lcose the drawer
                },
              ),
              ListTile(
              title: items('Favorites',Icon(Icons.favorite)),
                onTap: () {
                  //update
                  Navigator.pop(context);//lcose the drawer
                },
              ),
              ListTile(
                title: items('Settings',Icon(Icons.settings)),
                 onTap: (){
                   Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AccountSettings(
                      userDetail,
                    )
                  )
                  );        
              },
                ),
            ],
          ),
      ),
    );
  }
  Widget items(String name,Icon icon){
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          icon,
          SizedBox(width: 10,),
          Text(name,style: TextStyle(fontSize: 18,),),
        ],
      );       
  }

 Widget itemsCategory(name,icon){
  return  Container(
    color: Colors.greenAccent,
    width: 20,
    height: 35,
    child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            icon,
            SizedBox(width: 10,),
            Text(name,),
          ],
        ),
  );
 }
}