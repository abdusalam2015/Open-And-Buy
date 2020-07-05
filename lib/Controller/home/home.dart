import 'package:OpenAndBuy/Controller/EditUserDetails/account_settings.dart';

import 'package:OpenAndBuy/Model/setting.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:OpenAndBuy/Service/storeDatabase.dart';
import 'package:OpenAndBuy/Model/store.dart';
import 'package:OpenAndBuy/Controller/home/body.dart';
import 'package:OpenAndBuy/Model/user.dart';
import 'package:OpenAndBuy/Model/cart_bloc.dart';
import 'package:OpenAndBuy/Controller/settings/feedback.dart';

import 'package:OpenAndBuy/model/localization/localizationConstants.dart';

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
                backgroundColor: Colors.pink[400],
                title: Text(value('title')),
                actions: <Widget>[
                  PopupMenuButton<String>(
                    onSelected: actionChoice,
                    itemBuilder: (BuildContext context) {
                      return SettingClass.choices.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                  ),
                ],
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
            //drawer: NewDrawer(), //DrawerWidget(context, storeDetail, null),
          ),
        ));
  }

  void actionChoice(String choice) async {
    if (choice == 'Feedback') {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => FeedBack()));
    } else if (choice == 'Setting') {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => AccountSettings()));
    }
  }
}
