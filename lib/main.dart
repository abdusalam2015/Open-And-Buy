
import 'package:OpenAndBuy/Model/cart_bloc.dart';
import 'package:flutter/material.dart';
 
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:OpenAndBuy/Controller/authenticate/authenticate.dart';
import 'package:OpenAndBuy/Controller/home/home.dart';
import 'package:OpenAndBuy/Model/user.dart';
import 'package:OpenAndBuy/Service/auth.dart';
import 'package:OpenAndBuy/model/localization/localization.dart';
import 'package:OpenAndBuy/model/localization/localizationConstants.dart';
import 'package:OpenAndBuy/Service/user_notifier.dart';


 
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
      providers: [
        
        StreamProvider<User>.value(value: AuthService().user),
        ChangeNotifierProvider.value(value: CartBloc()),
        ChangeNotifierProvider<UserNotifier>(
            create: (context) => new UserNotifier(
                uid: Provider.of<User>(context,listen: false).uid.toString())),

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
        // _locale == null? Loading():
        home:  (user == null) ? Authenticate() : Home());
  }
}
 
/*
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:OpenAndBuy/Controller/wrapper.dart';
import 'package:OpenAndBuy/Model/cart_bloc.dart';
import 'package:OpenAndBuy/Model/user.dart';
import 'package:OpenAndBuy/Service/auth.dart';

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
