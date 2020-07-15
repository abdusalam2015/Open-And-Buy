import 'package:OpenAndBuy/Controller/EditUserDetails/account_settings.dart';
import 'package:OpenAndBuy/Controller/constants/colors.dart';
import 'package:OpenAndBuy/Controller/home/home.dart';
import 'package:OpenAndBuy/Controller/store_page.dart';
import 'package:OpenAndBuy/Model/category.dart';
import 'package:OpenAndBuy/Model/store.dart';
import 'package:OpenAndBuy/Model/user_detail.dart';
import 'package:OpenAndBuy/Service/store_notifier.dart';
import 'package:OpenAndBuy/Service/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget getDrawer(
    List<Category> categories, Function categoryIndexFunction, context) {
  return Drawer(
    child: Container(
      //  color: Colors.blueGrey[200],
      decoration: new BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Colors.green[300],
              Colors.green[200],
            ],
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight,
            stops: [1.0, 0.0],
            tileMode: TileMode.clamp),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Container(
          child: Stack(
            children: <Widget>[
              ListTile(
                title: Row(
                  children: <Widget>[
                    Icon(Icons.home),
                    SizedBox(width: 5.0),
                    Text("Home")
                  ],
                ),
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                    (Route<dynamic> route) => false,
                  );
                  
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: ListTile(
                  title: Row(
                    children: <Widget>[
                      Icon(Icons.settings),
                      SizedBox(width: 5.0),
                      Text("Setting")
                    ],
                  ),
                  onTap: (){
                    Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AccountSettings(
                          )));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 80.0),
                child: ListTile(
                  title: Row(
                    children: <Widget>[
                      Icon(Icons.info),
                      SizedBox(width: 5.0),
                      Text("Information")
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 155.0, bottom: 20.0, left: 5.0),
                child: Container(
                  child: Text(
                    'Categories',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 160.0,
                  right: 0.0,
                  left: 0.0,
                ),
                child: ListView.builder(
                    itemCount: categories.length, // widget.categoryList.length,
                    itemBuilder: (context, i) {
                      return InkWell(
                        child: Column(
                          children: <Widget>[
                            Container(
                                decoration: new BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Colors.lightGreen,
                                        APPBARCOLOR,
                                        // Color(0xff915fb5),
                                        // Color(0xffca436b)
                                      ],
                                      begin: FractionalOffset.topLeft,
                                      end: FractionalOffset.bottomRight,
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                                height: 50,
                                width: 400,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      categories[i].name,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                )),
                            SizedBox(
                              height: 4,
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          categoryIndexFunction(i);
                        },
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
