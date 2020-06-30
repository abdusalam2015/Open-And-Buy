
import 'package:flutter/material.dart';
 
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:volc/SharedWidgets/loading.dart';
import 'package:volc/User/Controller/authenticate/authenticate.dart';
import 'package:volc/User/Controller/home/home.dart';
import 'package:volc/User/Model/user.dart';
import 'package:volc/User/Service/user/auth.dart';
import 'package:volc/model/localization/localization.dart';
import 'package:volc/model/localization/localizationConstants.dart';
import 'package:volc/User/Model/user_detail.dart';
import 'package:volc/User/Service/user/database.dart';
import 'package:volc/User/Service/user_notifier.dart';


 
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
      providers: [
        StreamProvider<User>.value(value: AuthService().user),
        ChangeNotifierProvider<UserNotifier>(
            create: (context) => new UserNotifier(
                sid: Provider.of<User>(context, listen: false).uid.toString())),

       // StreamProvider<UserDetail>.value(value: DatabaseService(uid:Provider.of<User>(context).uid).user),
      ],
      child: OpenAndBuy(),
      ));
}
class OpenAndBuy extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _OpenAndBuyState state =
        context.findAncestorStateOfType<_OpenAndBuyState>();
    state.setLocale(locale);
  }

  @override
  _OpenAndBuyState createState() => _OpenAndBuyState();
}

class _OpenAndBuyState extends State<OpenAndBuy> {
  Locale _locale;
  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
     return MaterialApp(
      locale: _locale,
        supportedLocales: [
          Locale('en', 'US'),
          Locale('se', 'SW'),
          Locale('ar', 'AR'),
          Locale('gr', 'GR')
        ],
        localizationsDelegates: [
          Localization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (deviceLocale, supportedLocales) {
          for (var locale in supportedLocales) {
            if (locale.languageCode == deviceLocale.languageCode &&
                locale.countryCode == deviceLocale.countryCode) {
              return deviceLocale;
            }
          }
          return supportedLocales.first;
        },
        initialRoute: '/',
        routes: {
          '/home': (context) => Home(),
        },
        home: _locale == null
            ? Loading()
            : Scaffold(body: (user == null) ? Authenticate() : Home()));
  }
}
 
/*
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volc/User/Controller/wrapper.dart';
import 'package:volc/User/Model/cart_bloc.dart';
import 'package:volc/User/Model/user.dart';
import 'package:volc/User/Service/user/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
          value: AuthService().user,
          child: ChangeNotifierProvider<CartBloc>(
            create: (context) => CartBloc(),
            child: MaterialApp(
       // debugShowCheckedModeBanner: false,
      //  routes:{
        // '/signup':( context) => new SignUp(),
        // '/home_payment': (context) =>HomePayment(context),
        // '/existing_cards':(context) => ExistingCardsPage()
     // },
      home: Wrapper(),
      )
      ),
         
    );
  }
}


*/
