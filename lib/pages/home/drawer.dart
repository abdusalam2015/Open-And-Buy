import 'package:flutter/material.dart';
import 'package:volc/pages/user/account_settings.dart';

class DrawerWidget extends StatelessWidget {

  @override
   Widget build( BuildContext context) {
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
                    Icon(Icons.account_circle,color: Colors.white,size: 80,),
                    Text('Abdulsalam Fadhel' ,
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
                 onTap: () {
                   Navigator.of(context).pushNamed('/accountsettings');
                    //update
                  //  Navigator.pop(context);//lcose the drawer
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