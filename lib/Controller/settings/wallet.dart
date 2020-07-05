import 'package:OpenAndBuy/Model/localization/localizationConstants.dart';
import 'package:OpenAndBuy/Model/store.dart';
import 'package:OpenAndBuy/Model/user_detail.dart';
import 'package:OpenAndBuy/Service/store_notifier.dart';
import 'package:OpenAndBuy/Service/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:OpenAndBuy/Controller/constants/colors.dart';


import 'package:provider/provider.dart';

class Wallet extends StatefulWidget {
  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  String value(String key) {
    return getTranslated(context, key);
  }

  UserDetail userDetail;
  @override
  Widget build(BuildContext context) {
    UserNotifier userNotifier = Provider.of<UserNotifier>(context);
    userDetail = userNotifier.userDetail;

    return Scaffold(
      appBar: AppBar(
        title: Text(value('transMoneyTitle')),
        backgroundColor: APPBARCOLOR,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    value('myBudget'),
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  Text(
                    userDetail.budget.toString(),
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 50),
              Center(
                child: RaisedButton(
                    elevation: 0.0,
                    color: BUTTONCOLOR,
                    highlightColor: Colors.red,
                    child: Text(
                      value('transMoneyButton'),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                    onPressed: () async {}),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
