import 'package:OpenAndBuy/Controller/constant.dart';
import 'package:OpenAndBuy/Model/localization/localizationConstants.dart';
import 'package:OpenAndBuy/Model/store.dart';
import 'package:OpenAndBuy/Model/language.dart';

import 'package:OpenAndBuy/Service/storeDatabase.dart';
import 'package:OpenAndBuy/Service/store_notifier.dart';
import 'package:flutter/material.dart';
import 'package:OpenAndBuy/Controller/constants/colors.dart';

import 'package:google_map_location_picker/google_map_location_picker.dart';

import 'package:provider/provider.dart';

class ChangeLanguage extends StatefulWidget {
  @override
  _ChangeLanguageState createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
   String value(String key) {
    return getTranslated(context, key);
  }
  StoreDetail storeDetail ;
  @override
  Widget build(BuildContext context) {
      // UserNotifier userNotifier = Provider.of<UserNotifier>(context);
    // userNotifier.getUserInfo();

    return Scaffold(
      appBar: AppBar(
        title: Text(value('changeLang')),
        backgroundColor: APPBARCOLOR,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(value('selectLang'), style: TextStyle(fontSize: 20,color:Colors.black),),
                ],
              ),
              SizedBox(height: 50),
              Container(child: changeLang(),color: Colors.grey,),
            ],
          ),
        ), 
       ),
    );
  }
  Widget changeLang() {
    return Padding(
        padding: EdgeInsets.all(8.0),
        
        child: DropdownButton(
          onChanged: (Language language) {
           //  _changeLanguage(language);
          },
          underline: SizedBox(),
          icon: Icon(Icons.language, color: Colors.white),
          items: Language.languageList()
              .map<DropdownMenuItem<Language>>((lang) => DropdownMenuItem(
                  value: lang,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(lang.flag),
                        Text(lang.name, style: TextStyle(fontSize: 30)),
                      ])))
              .toList(),
        ));
  }
}