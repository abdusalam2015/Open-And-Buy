import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volc/User/Controller/EditUserDetails/account_settings.dart';
import 'package:volc/User/Controller/EditUserDetails/edit_account.dart';
import 'package:volc/User/Model/user.dart';
import 'package:volc/User/Model/user_detail.dart';
class DrawerWidget extends StatefulWidget {
  final BuildContext cont;
  DrawerWidget (this.cont);
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    // get the all the users details  ==> look at it in the future
    final userDetail = Provider.of<UserDetail>(context);
    
    //get the current user details
    final userID = Provider.of<User>(context).uid;
    

    //double c_width = MediaQuery.of(context).size.width*0.8;
    return  Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
           child: Row(
             mainAxisAlignment: MainAxisAlignment.start,
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
                           widget.cont,
                         )
                       )
                       );        
                   },
                 child:CircleAvatar(
                   radius: 31.0,
                   backgroundColor: Colors.white,
                   child: CircleAvatar(
                   backgroundImage:userDetail.photoURL.isNotEmpty && userDetail.photoURL != null  ?
                    NetworkImage(userDetail.photoURL.toString())
                    :AssetImage('assets/profile_picture.png'),
                   radius: 30.0,
                  ),
                 ),
                 ),
               ),
             ),
             SizedBox(width: 10),
               Container(
                 width: 150,
                 child: Text(userDetail.first_name + ' '+userDetail.last_name ,
                 style: TextStyle(color: Colors.white,fontSize: 18),),
               ),
             ],
           ),
           decoration: BoxDecoration(
             color: Colors.black, 
           ),
            
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
                  widget.cont,
                )
              )
            );        
          },
        ),
      ],
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