import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:volc/pages/user/user_details.dart';
class ProfileScreen extends StatelessWidget {
  final UserDetail detailUser;

  const ProfileScreen({Key key, this.detailUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GoogleSignIn _gsignIn = GoogleSignIn();

    return Scaffold(
      appBar: AppBar(
        title: Text(detailUser.userName),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              size: 20,
              color: Colors.white),
               onPressed: (){
              _gsignIn.signOut();
              print('Signed out');
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(detailUser.photoUrl),
             radius: 50.0,
          ),
          SizedBox(height: 10.0,),
          Text(
            "Name : "+ detailUser.userName,
            style:TextStyle(fontWeight: FontWeight.bold,color:Colors.black,fontSize: 20.0),
          ),
          Text(
            "Email : "+ detailUser.email,
            style:TextStyle(fontWeight: FontWeight.bold,color:Colors.black,fontSize: 20.0),
          ),
          Text(
            "Provider : "+ detailUser.providerDetails,
            style:TextStyle(fontWeight: FontWeight.bold,color:Colors.black,fontSize: 20.0),
          )
        ],
      ),),
    );
  }
}