import 'package:OpenAndBuy/Model/localization/localizationConstants.dart';
import 'package:OpenAndBuy/Service/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:OpenAndBuy/Controller/loading.dart';
import 'package:OpenAndBuy/Controller/EditUserDetails/edit_account.dart';
import 'package:OpenAndBuy/Model/user_detail.dart';
import 'package:OpenAndBuy/Service/auth.dart';
import 'package:OpenAndBuy/Controller/EditUserDetails/edit_location.dart';
import 'package:OpenAndBuy/Controller/settings/wallet.dart';
import 'package:OpenAndBuy/Controller/settings/my_orders.dart';
import 'package:OpenAndBuy/Controller/settings/feedback.dart';
import 'package:OpenAndBuy/Controller/settings/privacy_page.dart';
import 'package:OpenAndBuy/Controller/settings/change_language.dart';

class AccountSettings extends StatefulWidget {
  @override
  _AccountSettingsState createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  String value(String key) {
    return getTranslated(context, key);
  }

  final AuthService _auth = new AuthService();
  bool loading = false;
  bool finished = false;
  UserDetail userDetail;
  UserNotifier userNotifier;
  @override
  Widget build(BuildContext context) {
    userNotifier = Provider.of<UserNotifier>(context);
    userNotifier.getUserInfo();
    userDetail = userNotifier.userDetail;
    return loading
        ? Loading()
        : Scaffold(
            body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 100.0,
                pinned: true,
                floating: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    'Account Settings',
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ),
                backgroundColor: Colors.black,
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index == 0)
                      return item1(); //ProfilePage();
                    else if (index == 1)
                      return temp(
                          index,
                          context,
                          value('wallet'),
                          value('checkWallet'),
                          Icon(Icons.account_balance_wallet));
                    else if (index == 2)
                      return temp(index, context, value('orders'),
                          value('historyMsg'), Icon(Icons.history));
                    else if (index == 3)
                      return temp(index, context, value('location'),
                          value('changeLoc'), Icon(Icons.my_location));
                    else if (index == 4)
                      return temp(index, context, value('settings'),
                          value('changeSettings'), Icon(Icons.settings));
                    else if (index == 5)
                      return temp(index, context, value('feedback'),
                          value('feedbackNote'), Icon(Icons.feedback));
                    else if (index == 6)
                      return temp(
                          index,
                          context,
                          value('privacy'),
                          value('privacyNote'),
                          Icon(Icons.perm_device_information));
                    else if (index == 7)
                      return temp(index, context, value('language'),
                          value('changeLang'), Icon(Icons.language));
                    else
                      return signOut();
                  },
                  childCount: 9,
                ),
              ),
            ],
          ));
  }

  Widget divider() {
    return Divider(
      color: Colors.grey,
      thickness: 1,
    );
  }

  Widget textItem(name) {
    return Text(
      name,
      style: TextStyle(
        fontSize: 14,
        color: Colors.black,
      ),
    );
  }

  item1() {
    return InkWell(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20, top: 20.0),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  // check if the there is any photo or not!
                  backgroundImage: userDetail.photoURL != '' &&
                          userDetail.photoURL != null
                      ?
                      // profile pic is updated
                      NetworkImage(userDetail.photoURL)
                      // profile picture is not updated , so we will go with the default one
                      : AssetImage('assets/profile_picture.png'),
                  radius: 40.0,
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      userDetail.firstName + " " + userDetail.lastName,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '',
                      //userDetail.phone['number'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          divider(),
        ],
      ),
      onTap: () async {
        await Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => EditAccount()));
      },
    );
  }

  Widget temp(
      int index, BuildContext cont, String name, String desc, Icon icon) {
    return InkWell(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // SizedBox(height: 20,),
                Row(
                  children: <Widget>[
                    icon,
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(name),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: Text(
                        desc,
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey,
            thickness: 1,
          ),
        ],
      ),
      onTap: () async {
        var result;

       finished = await userNotifier.getAllUserOrders();
        if (index == 1) {
          result = Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Wallet()));
        } else if (index == 2) {
          if (finished) {
            result = Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MyOrders(userNotifier.allUserOrders)));
          }else {
            print(' I need to create a function to get all  the orders for all store');
          }
        } else if (index == 3) {
          result = Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => EditUserLocation()));
        } else if (index == 4) {
          result = Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => EditAccount()));
        } else if (index == 5) {
          result = Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => FeedBack()));
        } else if (index == 6) {
          result = Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => PrivacyPage()));
        } else if (index == 7) {
          result = Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ChangeLanguage()));
        }

        // result != null ? Scaffold.of(cont).showSnackBar(SnackBar(
        // content: Text('Location Updated', style: TextStyle(color: Colors.white),),
        // backgroundColor: Colors.green)):Container();
      },
    );
  }

  Widget signOut() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              InkWell(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.exit_to_app,
                          size: 20,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(value('signOut')),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 38.0),
                          child: Text(
                            value('signOut'),
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                onTap: () async {
                  _auth.signOut();
                  Navigator.of(context).pop();
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.grey,
          thickness: 1,
        ),
      ],
    );
  }
}

// Future getData() async {
//   var url = 'http://volcshopping.000webhostapp.com/get.php';
//   http.Response response = await http.get(url);
//    var data = jsonDecode(response.body);
//    print(data.toString());

// }
// @override
// void initState(){
//   getData();
// }
