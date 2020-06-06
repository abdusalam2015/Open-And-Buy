import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:volc/SharedWidgets/shared_functions.dart';
import 'package:volc/User/Controller/EditUserDetails/edit_first_name.dart';
import 'package:volc/User/Controller/EditUserDetails/edit_last_name.dart';
import 'package:volc/User/Controller/EditUserDetails/edit_phone_number.dart';
import 'package:volc/User/Model/user_detail.dart';
class EditAccount extends StatefulWidget {

  final BuildContext cont;
  EditAccount(this.cont);
  @override
  _EditAccountState createState() => _EditAccountState();
}
class _EditAccountState extends State<EditAccount> {
 final SharedFunctions sharedfun = new SharedFunctions();
  bool loading = false;
  bool isUploaded = false;
  UserDetail userDetail ;
  File img;
  //double c_width ;
  @override
  Widget build(BuildContext context) {
 //  c_width = MediaQuery.of(context).size.width*0.8;
  userDetail  = Provider.of<UserDetail>(widget.cont);
    return Scaffold(
      body: Builder(
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
                    else if(index == 1)return firstName('First Name', userDetail.firstName,context);
                    else if(index == 2)return lastName('Last Name',  userDetail.lastName,context);
                    else if(index == 3)return phoneNumber('Phone Number', userDetail.phoneNumber,true,context);
                    else if(index == 4)return email('Email', userDetail.email.toString(), false);
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
  Widget email(String name, String email, bool isVerified ){
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15.0),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              name,
            style: TextStyle(color:Colors.grey, fontSize: 14), ),
            SizedBox(height: 15.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
              Container(
                width: 250,
                child: Text(email,
                style: TextStyle(color: Colors.black,fontSize: 12),),
              ),
              isVerified? Text('Verified',style: TextStyle(color:Colors.green, fontSize: 14), )
              : Text('Not Verified',style: TextStyle(color:Colors.red, fontSize: 14), ),
              ],
            ),
            SizedBox( height: 15.0),
          ],
        ) ,
      );   
    }
  Widget phoneNumber(String image, String phoneNumber, bool isVerified ,context){
      return InkWell(
          child: Padding(
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
                  Padding(
                    padding: const EdgeInsets.only(top:6.0),
                    child: Container(
                    width: 210,
                    child: Text(phoneNumber,
                    style: TextStyle(color: Colors.black,fontSize: 18),),
                ),
                  ),
                  isVerified? Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: Text('Verified',style: TextStyle(color:Colors.green, fontSize: 14), ),
                  )
                            : Text('Not Verified',style: TextStyle(color:Colors.red, fontSize: 14), ),
                 // SizedBox( height: 15.0),
                ],
              ),
            ],
          ),
        ),
        onTap: ()async{
      final result = await  Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EditPhoneNumber(
                widget.cont,
            ),
      ));
        result != null ? Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Phone Number Updated', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.green)):Container();
        },
      );
}
    Widget firstName(String text, String name,context ){
       //userDetail = Provider.of<UserDetail>(context);

      return InkWell(
          child: Padding(
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
        ),
        onTap: ()async{
         // Navigator.pop(context);
              final result = await  Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditFirstName(
                       widget.cont,
                    )
                  )
            ); 
        // make sure that if it is already updated or not
        result != null ? Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('First Name Updated', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.green)):Container();
        },
      );
      
    }
    Widget lastName(String text, String name,context ){
      return InkWell(
          child: Padding(
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
        ),
        onTap: (){
           // Navigator.pop(context);
               final result = Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditLastName(
                       widget.cont,
                    )
                  )
            ); 
             // make sure that if it is already updated or not
        result != null ? Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Last Name Updated', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.green)):Container();
        },
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
 // print('LLLLOO: ${widget.userDetail.photoURL.isNotEmpty}');
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
                 userDetail.photoURL.isNotEmpty &&  userDetail.photoURL != null ? 
                NetworkImage( userDetail.photoURL.toString())
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
     File _image;
     try{
       _image= await sharedfun.getImage();
       } catch(e){
         print(e);
       }
    if(_image == null){
      setState(() =>loading = false);
     // print('jksldf');
    }else {
      img = _image;
      setState(() =>loading = true);
      await sharedfun.uploadPic(_image, userDetail.userID, userDetail);
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