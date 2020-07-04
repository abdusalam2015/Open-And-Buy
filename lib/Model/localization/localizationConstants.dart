import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:OpenAndBuy/Controller/constant.dart';
import 'package:OpenAndBuy/model/localization/localization.dart';

const String LANGUAGE_CODE = 'languageCode';

Future<Locale> setLocale(String langaugeCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(LANGUAGE_CODE, langaugeCode);
  return _locale(langaugeCode);
}

Locale _locale(String langaugeCode) {
  Locale _temp;
  switch (langaugeCode.toString()) {
    case ENGLISH:
      _temp = Locale(langaugeCode, 'US');
      break;
    case SWEDISH:
      _temp = Locale(langaugeCode, 'SE');
      break;
    case ARABIC:
      _temp = Locale(langaugeCode, 'SA');
      break;
    default:
      _temp = Locale(ENGLISH, 'US');
  }
  return _temp;
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String langaugeCode = _prefs.getString(LANGUAGE_CODE) ?? ENGLISH;
  print(langaugeCode + " GetLocl");
   return _locale(langaugeCode);
}
String getTranslated(BuildContext context, String key) {
  return Localization.of(context).getTranslatedValue(key).toString();
}