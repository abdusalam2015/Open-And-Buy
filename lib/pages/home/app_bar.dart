import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:volc/pages/home/cart_page.dart';
import 'package:volc/pages/home/cart_bloc.dart';
import 'package:volc/pages/home/setting.dart';
import 'package:volc/pages/user/sign_up.dart';

class AppBarWidget extends StatefulWidget {
  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}
class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<CartBloc>(context);
    int totalCount = 0 ;
    if (bloc.cart.length > 0) {
      totalCount = bloc.cart.values.reduce( (a, b) => a + b );
    }
     return AppBar(
        backgroundColor: Colors.black54,
        elevation: 0.0,
        centerTitle: true,
        // leading: IconButton(
        //   icon: arrBack? Icon(Icons.arrow_back, color: Colors.white) :Icon(Icons.list, color: Colors.white),
        //   onPressed: () {
        //     if(arrBack){
        //     Navigator.of(context).pop();
        //     }
        //   },
        // ),
        title: Text(
          'Shoping Now',
            style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 18.0,
                color: Colors.white,
              )
              ),
        actions: <Widget>[
         
            Padding(
            padding: const EdgeInsets.all(10.0),
            child: new Container(
                height: 150.0,
                width: 30.0,
                child: new GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartPage(),
                      ),
                    );
                  },
                  child: new Stack(
                    children: <Widget>[
                      new IconButton(
                        icon: new Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                        ),
                        onPressed: null,
                      ),
                      new Positioned(
                          child: new Stack(
                        children: <Widget>[
                          new Icon(Icons.brightness_1,
                              size: 20.0, color: Colors.red[700]),
                          new Positioned(
                              top: 3.0,
                              right: 7,
                              child: new Center(
                                child: new Text(
                                  '$totalCount',
                                  style: new TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              )),
                        ],
                      )),
                    ],
                  ),
                )),
          ),
           IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          
          PopupMenuButton<String>(
            onSelected: actionChoice,
            itemBuilder: (BuildContext context){
              return SettingClass.choices.map((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
              },
          ),
         
        ],
      );
  }

  void actionChoice(String choice){
    if(choice == 'signUp'){
       Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => SignUp(  
        )));
    }else if(choice == 'Feedback'){
         Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => SignUp(  
        )));
    }else if(choice == 'signIn'){
        // Navigator.of(context).push(
        //   MaterialPageRoute(builder: (context) => SignIn(  )));
    }else{
        print('object');
        
    }
  }
// void actionChoice(String choice){
//     if(choice == 'signUp'){
//        Navigator.of(context).push(
//           MaterialPageRoute(builder: (context) => SignUp(  
//         )));
//     }else if(choice == 'Feedback'){
//          Navigator.of(context).push(
//           MaterialPageRoute(builder: (context) => SignUp(  
//         )));
//     }else if(choice == 'signIn'){
//         Navigator.of(context).push(
//           MaterialPageRoute(builder: (context) => SignIn(  
//         )));
//     }else{
//         print('object');
        
//     }
//   }
}


