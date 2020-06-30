import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volc/Admin/Service/storeDatabase.dart';
import 'package:volc/SharedModels/store/store.dart';
import 'package:volc/User/Controller/home/app_bar.dart';
import 'package:volc/User/Controller/home/body.dart';
import 'package:volc/User/Controller/home/drawer.dart';
import 'package:volc/User/Model/user.dart';
import 'package:volc/User/Model/user_detail.dart';
import 'package:volc/User/Service/user/database.dart';
import 'package:volc/User/Model/cart_bloc.dart';

import 'package:volc/model/localization/localizationConstants.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String value(String key) {
    return getTranslated(context, key);
  }

  @override
  Widget build(BuildContext context) {
    String userID = Provider.of<User>(context).uid;
    StoreDatabaseService obj = new StoreDatabaseService();
    StoreDetail storeDetail = new StoreDetail(
        sid: '',
        name: '',
        location: '',
        backgroundImage: '',
        coveredArea: '',
        storeType: '',
        phoneNumber: '',
        storeStatus: '',
        latitude: '',
        longitude: '');
    return ChangeNotifierProvider<CartBloc>(
        create: (context) => CartBloc(),
        child: MaterialApp(
                  home: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(55.0), // here the desired height
              //child: AppBarWidget(context,storeDetail),
              child: AppBar(
                title: Text(value('title')),
              ),
            ),
            body: FutureBuilder<List<StoreDetail>>(
                future: obj.getAllStores(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<StoreDetail>> snapshot) {
                  if (!snapshot.hasData) {
                    // while data is loading:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    // data loaded:
                    final storesList = snapshot.data;
                    return Center(
                        child: Body(context,
                            storesList) //Text('Android version: ${storesList[0].sid}'),
                        );
                  }
                }),
            // set categoryList =  null,
            // because we do not want to show any category in the drawer inside the homepage.
            drawer: DrawerWidget(context, storeDetail, null),
          ),
        ));
  }
}
