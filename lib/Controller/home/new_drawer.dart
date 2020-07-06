import 'package:OpenAndBuy/Controller/store_page.dart';
import 'package:OpenAndBuy/Model/category.dart';
import 'package:OpenAndBuy/Model/store.dart';
import 'package:OpenAndBuy/Model/user_detail.dart';
import 'package:OpenAndBuy/Service/store_notifier.dart';
import 'package:OpenAndBuy/Service/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget getDrawer(List<Category> categories, Function categoryIndexFunction) {
  return Drawer(
    child: Container(
      //  color: Colors.blueGrey[200],
      decoration: new BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Colors.purple[200],
              Colors.amberAccent,
            ],
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight,
            stops: [1.0, 0.0],
            tileMode: TileMode.clamp),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Container(
          child: Stack(
            children: <Widget>[
              ListView.builder(
                  itemCount: categories.length, // widget.categoryList.length,
                  itemBuilder: (context, i) {
                    return InkWell(
                      child: Column(
                        children: <Widget>[
                          Container(
                              decoration: new BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Color(0xff915fb5),
                                      Color(0xffca436b)
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
                  })
            ],
          ),
        ),
      ),
    ),
  );
}
