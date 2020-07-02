import 'package:OpenAndBuy/Model/user_detail.dart';
import 'package:OpenAndBuy/Service/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:OpenAndBuy/Controller/store_page.dart';
import 'package:OpenAndBuy/Service/storeDatabase.dart';
import 'package:OpenAndBuy/Model/product.dart';
import 'package:OpenAndBuy/Model/store.dart';
import 'package:provider/provider.dart';

class NewDrawer extends StatefulWidget {
  @override
  _NewDrawerState createState() => _NewDrawerState();
}

class _NewDrawerState extends State<NewDrawer> {
  UserDetail userDetail;
  @override
  Widget build(BuildContext context) {
    UserNotifier userNotifier = Provider.of<UserNotifier>(context);
    userNotifier.getUserInfo();
    userDetail = userNotifier.userDetail;

    return Drawer(
      child: Container(
        //  color: Colors.blueGrey[200],
        decoration: new BoxDecoration(
          gradient: LinearGradient(
              colors: [
                // Color(0xff915fb5),Color(0xffca436b)
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
            //   color: Colors.blueGrey[200],

            child: Stack(
              children: <Widget>[
                ListView.builder(
                    itemCount: 10, // widget.categoryList.length,
                    itemBuilder: (context, i) {
                      return categoryCard('Drink', 1);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget categoryCard(String name, int index) {
    return InkWell(
      child: Column(
        children: <Widget>[
          Container(
              decoration: new BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xff915fb5), Color(0xffca436b)],
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.bottomRight,
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
              //  color: Colors.blueGrey[500],
              height: 50,
              width: 400,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    name,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              )),
              SizedBox(height: 4,),
        ],
      ),
      onTap: () {
        // StoreDatabaseService obj =
        // new StoreDatabaseService(sid: widget.storeDetail.sid);
        //   // List<Category> categoryList =  await obj.getcategories(userDetail.userID) ;
        //   StoreDetail storeDetail =
        //       await obj.getStoreInfo(widget.storeDetail.sid.toString());
        //   //print('categoryList[0].categoryID: ' + widget.categoryList[0].categoryID);
        //   List<Product> productsList = await obj.getStoreProducts(
        //       widget.storeDetail.sid, widget.categoryList[i].categoryID);
        //   Navigator.of(context).pop();
        //   Navigator.of(context).push(MaterialPageRoute(
        //       builder: (context) => StorePage(
        //             storeDetail: storeDetail,
        //             cont: widget.cont,
        //             categoryList: widget.categoryList,
        //             productsList: productsList,
        //           )));
      },
    );
  }
}
