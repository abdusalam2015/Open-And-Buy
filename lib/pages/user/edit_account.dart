import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:volc/models/user_detail.dart';
import 'package:volc/services/auth.dart';
import 'package:volc/shared/shared_functions.dart';

class EditAccount extends StatefulWidget {
   UserDetail userDetail;
  EditAccount(this.userDetail);
  @override
  _EditAccountState createState() => _EditAccountState();
}
class _EditAccountState extends State<EditAccount> {
  final AuthService _auth = new AuthService();
 final SharedFunctions sharedfun = new SharedFunctions();
  bool loading = false;
  bool isUploaded = false;
  File img;
  @override
  Widget build(BuildContext context) {
 // final  userID = Provider.of<User>(context).uid;
  //final userDetail = Provider.of<UserDetail>(context);
       return  Scaffold(
      body:Builder(
        builder: (context) => CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 100.0,
              pinned: true,
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Edit Account',style: TextStyle(fontSize: 22,color: Colors.white),),
              ),
              backgroundColor: Colors.black,
              ),
               SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index){
                    if(index == 0)return profilePicture(context);
                    else if(index == 2)return name('Last Name', 'Fadhel');
                    else if(index == 3)return phoneNumber('Phone Number','+46735517944',true);
                    else if(index == 4)return email('Email','abdussalm9393@gmail.com', false);
                    else return password('Password', '.......');  
                  }, //=>items(index), 
                  childCount: 6,
                ),
                
              ),
              
          ],
        ),
      )
    );
  }
  // Widget items(index){
  //     //  print('Index: $index');
  //       if(index == 0)return profilePicture(context,'userID');//ProfilePage();
  //       else if(index == 1)return name('First Name','Abdulsalam');
  //       else if(index == 2)return name('Last Name', 'Fadhel');
  //       else if(index == 3)return phoneNumber('Phone Number','+46735517944',true);
  //       else if(index == 4)return email('Email','abdussalm9393@gmail.com', false);
  //      else return password('Password', '.......');
  //    }
     
  Widget email(String name, String email, bool isVerified ){
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15.0),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(name,
            style: TextStyle(color:Colors.grey, fontSize: 14), ),
            SizedBox(height: 15.0,),
            Row(
              children: <Widget>[
                Text(email,
                style: TextStyle(color:Colors.black, fontSize: 18), ),
                SizedBox(width: 15,),
                  isVerified? Text('Verified',style: TextStyle(color:Colors.green, fontSize: 18), )
              : Text('Not Verified',style: TextStyle(color:Colors.red, fontSize: 15), ),
              ],
            ),
            SizedBox( height: 15.0),
          
          ],
        ) ,
      );   
    }
  Widget phoneNumber(String image, String phoneNumber, bool isVerified ){
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15.0),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Phone Number',
            style: TextStyle(color:Colors.grey, fontSize: 14), ),
            SizedBox(height: 15.0,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 35,
                  width: 35,
                  child: Image.asset('assets/flags/Sweden.png'),
                ),
                SizedBox(width: 10.0,),
                Text(phoneNumber,
                style: TextStyle(color:Colors.black, fontSize: 18), ),
                SizedBox(width: 90.0,),
                isVerified? Text('Verified',style: TextStyle(color:Colors.green, fontSize: 14), )
                          : Text('Not Verified',style: TextStyle(color:Colors.red, fontSize: 14), ),
                SizedBox( height: 15.0),
              ],
            ),
          ],
        ),
      );
}
    Widget name(String text, String name ){
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15.0),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(text,
            style: TextStyle(color:Colors.grey, fontSize: 14), ),
            SizedBox(height: 15.0,),
            Text(name,
            style: TextStyle(color:Colors.black, fontSize: 18), ),
            SizedBox( height: 15.0),
          ],
        ) ,
      );
    }
  Widget password(String text, String name ){
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15.0),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(text,
            style: TextStyle(color:Colors.grey, fontSize: 14), ),
            SizedBox(height: 8.0,),
            Text(name,
            style: TextStyle(color:Colors.black, fontSize: 22,fontWeight: FontWeight.bold), ),
            SizedBox( height: 15.0),
          ],
        ) ,
      );
    }
Widget profilePicture(context){
   return InkWell(
      child: Padding(
       padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              Stack(
              children: <Widget>[

                // splash screen for updating the profile picture
                loading ? Padding(
                  padding: const EdgeInsets.only(top:30.0,left: 20),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: SpinKitFadingCircle(color: Colors.brown,size: 50.0,),//Text('Loading...')
                  ),
                ): CircleAvatar(
                backgroundImage: isUploaded ?  FileImage(img) :
                widget.userDetail.photoURL.toString() != '' ? 
                NetworkImage(widget.userDetail.photoURL.toString())
                :AssetImage('assets/profile_picture.png'),
                radius: 50.0,
              ),
              Padding(
                padding: const EdgeInsets.only(top:80.0,left: 10),
                child: CircleAvatar(
                  backgroundColor: (Colors.black),
                  child: Icon(Icons.edit,color: Colors.white,size:15.0),
                  radius: 10.0,
                ),
              )
              ]),
                SizedBox(height: 20.0,),
                Divider(color: Colors.grey,thickness: 1, ),
            ],),
     ),
     onTap: () async{
     File _image = await sharedfun.getImage();
    if(_image == null){
      setState(() =>loading = false);
      ImagePicker.retrieveLostData();
    }else {
      img = _image;
      print('IMGGG: $img' );
      setState(() =>loading = true);
      await sharedfun.uploadPic(_image,widget.userDetail.userID);
      isUploaded = true;
     // setState(() {
        loading = false;
        Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Photo Updated', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.green));
    //  });
      setState(() => loading = false);
    }
     },
   );
}
}