import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:volc/pages/user/profile_screen.dart';
import 'package:volc/pages/user/user_details.dart';

class SignIn extends StatefulWidget {
  
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();
  Future<FirebaseUser> _signIn(BuildContext context) async{
  
  Scaffold.of(context).showSnackBar(new SnackBar(
    content: new Text('Sign in'),
  ));

  final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
);
    FirebaseUser userDetail = (await _firebaseAuth.signInWithCredential(credential)).user ;
    ProviderDetail providerInfo = new  ProviderDetail(userDetail.providerId);
    List<ProviderDetail> providerData = new List<ProviderDetail>();
    providerData.add(providerInfo);
    print('Provider Info: $providerInfo');
    UserDetail detail = new UserDetail(userDetail.providerId,userDetail.displayName,
    userDetail.photoUrl,userDetail.email,providerData);
    print(' detail: $detail');
    Navigator.push(context,
    new MaterialPageRoute(
    builder: (context) => 
    new ProfileScreen(detailUser: detail),
    )
    );
    return userDetail;
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Builder( 
        builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        Container(
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(15.0,110.0,0.0,0.0),
                child: Text(
                  'Shopping',
                  style: TextStyle(fontSize: 60.0,fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(15.0,175.0,0.0,0.0),
                child: Text(
                  'Now',
                  style: TextStyle(fontSize: 60.0,fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(140.0,140.0,0.0,0.0),
                child: Row(
                  children: <Widget>[
                    Text(
                  '...',
                  style: TextStyle(fontSize: 90.0,fontWeight: FontWeight.bold,color: Colors.green),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5.0,30.0,0.0,0.0),
                  child: Icon(Icons.shopping_cart ,size: 50,color: Colors.green,),
                ),
                  ],
                ), 
              ),
            ],
          )
        ,),
        Container(
          padding: EdgeInsets.only(top: 35.0,left: 20.0,right: 20.0),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green)
                  )
                ),
              ),
              SizedBox(height: 20.0,),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green)
                  ) 
                ),
                obscureText: true,
              ),
              SizedBox(height: 5.0,),
              Container(
                alignment: Alignment(1.0, 0.0),
                padding: EdgeInsets.only(top:20.0, left: 20.0),
                child: InkWell(
                  child: Text('Forgot Password',style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline
                  ),),
                ),
              ),
              SizedBox(height: 40.0,),
              Container(
                height: 60,
                child: Material(
                  borderRadius: BorderRadius.circular(40.0),
                  shadowColor: Colors.greenAccent,
                  color: Colors.green,
                  elevation: 7.0,
                  child: GestureDetector(
                    onTap: (){},
                    child: Center(
                      child: Text(
                        'Login',style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              Container(
                height: 60.0,
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:Colors.black,
                      style:BorderStyle.solid,
                      width:1.0,
                    ),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  child: InkWell(
                    onTap: (){
                      _signIn(context);
                      // .then((FirebaseUser user)=>print(user))
                      // .catchError((e)=>print(e));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: ImageIcon(AssetImage('assets/facebook.png'))
                        ),
                        SizedBox(width: 10.0,),
                        Center(
                          child: Text(
                            'Log in with Facebook',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ,),
        SizedBox(height: 15.0,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'New to Spotify ?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 5.0,),
            InkWell(
              onTap: (){
                Navigator.of(context).pushNamed('/signup');
              },
              child: Text(
                'Register',
                style: TextStyle(
                  color:Colors.green,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline
                )
              ),
            )

          ],
        )
      ],),)
    );
  }
}