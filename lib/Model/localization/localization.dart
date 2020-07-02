import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Localization {
  final Locale locale;
  Localization(this.locale);
  static Localization of(BuildContext context) {
    return Localizations.of<Localization>(context, Localization);
  }

  Map<String, String> _localizedValues;

  Future load() async {
     String jsonStringValues = await rootBundle
        .loadString('assets/translations/${locale.languageCode}.json');

    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    _localizedValues = mappedJson.map((key, value) => MapEntry(key, value.toString()));
  }

  String getTranslatedValue(String key) {
     //print(locale.languageCode + " getTranslatedValue  " + key);
     return _localizedValues[key];
  }
  static const LocalizationsDelegate<Localization> delegate = _LocalizationDelegate();
}

class _LocalizationDelegate extends LocalizationsDelegate<Localization> {
  const _LocalizationDelegate();
  @override
  bool isSupported(Locale locale) {
    return ['en', 'se', 'ar', 'gr'].contains(locale.languageCode);
  }

  @override
  Future<Localization> load(Locale locale) async {
    print("Inside Load  "+ locale.languageCode);
    Localization localization = new Localization(locale);
    await localization.load();
    return localization;
  }
  @override
  bool shouldReload(_LocalizationDelegate old) => false;
}
