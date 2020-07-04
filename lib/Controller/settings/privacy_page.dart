import 'package:OpenAndBuy/Model/localization/localizationConstants.dart';
import 'package:OpenAndBuy/Controller/constant.dart';
import 'package:OpenAndBuy/Model/localization/localizationConstants.dart';
import 'package:OpenAndBuy/Model/store.dart';
import 'package:OpenAndBuy/Service/storeDatabase.dart';
import 'package:OpenAndBuy/Service/store_notifier.dart';
import 'package:flutter/material.dart';
import 'package:OpenAndBuy/Controller/constants/colors.dart';

import 'package:google_map_location_picker/google_map_location_picker.dart';

import 'package:provider/provider.dart';

class PrivacyPage extends StatefulWidget {
  @override
  _PrivacyPageState createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
   String value(String key) {
    return getTranslated(context, key);
  }
  StoreDetail storeDetail;
  @override
  Widget build(BuildContext context) {
    StoreNotifier storeNotifier = Provider.of<StoreNotifier>(context);
    storeDetail = storeNotifier.storeDetail;

    return Scaffold(
      appBar: AppBar(
        title: Text(value('privacy')),
        backgroundColor: APPBARCOLOR,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Container(
          child: ListView(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    value('termsAndConditions'),
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 50),
              Center(
                child: Text(TERMS.toString()),
              ),
              Center(
                child: Text(TERMS.toString()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
