import 'package:OpenAndBuy/Controller/constants/colors.dart';
import 'package:OpenAndBuy/Controller/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:OpenAndBuy/Controller/store_page.dart';
import 'package:OpenAndBuy/Service/storeDatabase.dart';
import 'package:OpenAndBuy/Model/product.dart';
import 'package:OpenAndBuy/Model/category.dart';
import 'package:OpenAndBuy/Model/store.dart';
import 'package:OpenAndBuy/Model/user_detail.dart';
import 'package:OpenAndBuy/Model/location.dart';
import 'package:OpenAndBuy/Service/user_notifier.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Body extends StatefulWidget {
  final BuildContext cont;
  final List<StoreDetail> storesList;
  Body(this.cont, this.storesList);
  @override
  _BodyState createState() => _BodyState();
}

UserDetail userDetail;
String userLat = '0.0', userLong = '0.0';

class _BodyState extends State<Body> {
  bool finished = false;
  Future getUserData() async {
    UserNotifier userNotifier = Provider.of<UserNotifier>(context);
    await userNotifier.getUserInfo();
    userDetail = userNotifier.userDetail;
    if (this.mounted) {
      setState(() {
        finished = true;
      });
    }
  }

  @override
  Widget build(context) {
    //print(widget.storesList[2].latitude.toString() + "  dfdfd");
    // Provider.of<UserNotifier>(context,listen: false) ;
    getUserData();
    try {
      userLat = userDetail.latitude;
      userLong = userDetail.longitude;
    } catch (e) {
      print('ERROR');
    }
    return !finished
        ? Loading()
        : ListView.builder(
            padding: EdgeInsets.all(8),
            itemCount: widget.storesList != null ? widget.storesList.length : 0,
            itemBuilder: (context, i) {
              return InkWell(
                  child: _buildCard(widget.storesList[i], false, context),
                  onTap: () async {
                    ProgressDialog dialog = new ProgressDialog(context);
                    await dialog.show();
                    await welcome(dialog);
                    List<Category> categoryList;
                    try {
                      categoryList = await StoreDatabaseService.getcategories(
                          widget.storesList[i].sid);
                    } catch (e) {}
                    await dialog.hide();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => StorePage(
                            storeDetail: widget.storesList[i],
                            categories: categoryList)));
                  });
            },
          );
  }

  Future welcome(ProgressDialog dialog) {
    dialog.style(
      backgroundColor: Colors.blue,
    );
    double percentage = 0.0;
    Future.delayed(Duration(seconds: 2)).then((value) {
      percentage += 40.0;
      dialog.update(progress: percentage, message: "Progressing");
    });
    Future.delayed(Duration(seconds: 2)).then((value) {
      percentage += 60.0;
      dialog.update(progress: percentage, message: "Almost done");
    });
    Future.delayed(Duration(seconds: 2)).then((value) {
      dialog.update(
        progress: percentage,
        message: "WELCOME",
      );
    });

    //return true;
  }

  Widget _buildCard(StoreDetail storeDetail, bool isFavorite, context) {
    // String name, String dis, String imgPath, String location,
    // widget.storesList[i].name, widget.storesList[i].email,
    // widget.storesList[i].backgroundImage,
    // widget.storesList[i].coveredArea

    return Padding(
        padding: EdgeInsets.all(5),
        child: InkWell(
            child: Container(
          // height: 50,
          // width: 280,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[400], spreadRadius: 0.0, blurRadius: 2.0)
            ],
            color:
                storeDetail.storeStatus == "true" ? Colors.white : Colors.white ,// UNAVAILABLE,
          ),
          child: Column(
              //  mainAxisAlignment: MainAxisAlignment.start,

              children: [
                Hero(
                  tag: storeDetail.sid,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Container(
                      height: 190.0,
                      width: 327.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: storeDetail.backgroundImage != '' &&
                                storeDetail.backgroundImage != null
                            ? NetworkImage(storeDetail.backgroundImage)
                            : AssetImage('assets/storesImages/netto.png'),
                        fit: BoxFit.fill,
                      )),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                // Container(color: Colors.black, height: 1.0),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Row(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 120,
                                  child: Text(storeDetail.name,
                                      style: TextStyle(
                                          fontFamily: 'Varela',
                                          color: Colors.black,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 65.0),
                                  child: openButton(),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20.0, bottom: 10.0),
                              child: Container(
                                color: Colors.grey,
                                width: 320,
                                height: 1,
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                storeDetail.storeStatus == "true"
                                    ? Container(
                                        child: Text(
                                          'Opened',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green),
                                        ),
                                      )
                                    : Container(
                                        child: Text(
                                          'Closed',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red),
                                        ),
                                      ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 120.0),
                                  child: stars(),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0,bottom: 3.0),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(Icons.location_on,
                                      color: Colors.grey, size: 24.0),
                                  Text(
                                      Location.calculateDistance(
                                              double.parse(storeDetail.latitude
                                                      .toString())
                                                  .toDouble(),
                                              double.parse(storeDetail.longitude
                                                      .toString())
                                                  .toDouble(),
                                              double.parse(userLat).toDouble(),
                                              double.parse(userLong).toDouble())
                                          .toString(),
                                      style: TextStyle(
                                          fontFamily: 'Varela',
                                          color: Colors.grey,
                                          fontSize: 18.0)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ]),
                ),
              ]),
        )));
  }
}

Widget openButton() {
  return Container(
    width: 130,
    height: 35,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(35.0),
      gradient: LinearGradient(
        colors: <Color>[
          Colors.green[400],
          //Color(0xFF0D47A1),
          //Color(0xFF1976D2),
          Colors.green[400],
          Colors.greenAccent,
          // Color(0xFF42A5F5),
        ],
      ),
    ),
    padding: const EdgeInsets.all(0.0),
    child: Center(
        child: Text('OPEN',
            style: TextStyle(fontSize: 15, color: Colors.white))),
  );
}

double rating = 0;
Widget stars() {
  return SmoothStarRating(
      allowHalfRating: true,
      onRated: (v) {
        rating = v;
      },
      starCount: 5,
      rating: rating,
      size: 30.0,
      isReadOnly: true, // read only ,
      filledIconData: Icons.blur_off,
      halfFilledIconData: Icons.blur_on,
      color: Colors.yellow,
      borderColor: Colors.grey,
      spacing: 0.0);
}

/*
Padding(
              padding: EdgeInsets.all(1.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: <Widget>[
                        Icon(Icons.star_half, color: Colors.yellow),
                        Text(
                          '5.0',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ],
                    ),
                    storeDetail.storeStatus == "true"
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Opened',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Closed',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                          )
                  ]),
            ),
            */
