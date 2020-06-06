import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
   File _image;
 // final AuthService _auth = new AuthService();
 @override
  void dispose() {
    super.dispose();
  }

Future uploadPic(BuildContext context) async{
      String fileName = basename(_image.path);
      StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask  uploadTask = firebaseStorageRef.putFile(_image);
      await uploadTask.onComplete;
      setState((){
        print('Profile Picture Uploaded');
       // Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded'),));
      });
    }

     Future getImage() async{
      var image = await ImagePicker.pickImage(source:ImageSource.gallery);
      setState(() {
        _image = image ;
        print('Image Path is $_image');
      });
    }
  @override
  Widget build(BuildContext context) {
    bool uploadButton = false;
    return Column(
       children: <Widget>[
         SizedBox(height: 20,),
         Padding(
            padding: EdgeInsets.only(left: 20),
           child: Row(
           //  mainAxisAlignment: MainAxisAlignment.start,
             children: <Widget>[
               CircleAvatar(
               backgroundImage: (_image == null)? AssetImage('assets/profile_picture.png'): 
               FileImage(_image),
               radius: 40.0,
             ), 
             Padding(
               padding: EdgeInsets.only(top: 60.0),
               child: IconButton(
                icon: Icon(Icons.camera_alt,size: 25.0,),
                onPressed: (){
                  getImage();
                  upImg(context);
                  // (_image != null) ? Image.file(_image,fit:BoxFit.fill)
                  // : Image.file(_image,fit:BoxFit.fill);
                  // uploadPic(context,_image);
                },
               ),
             ),
             SizedBox(width: 10,),
               Column(
               mainAxisAlignment: MainAxisAlignment.start,
     children: <Widget>[
     InkWell(
         child: Row(
         children: <Widget>[
          Text(
         'Abdulsalam',
          style: TextStyle(fontSize: 14,color:Colors.black, ),
         ),
          Icon(Icons.edit,size:20,color: Colors.blue,),
         ],
        ),
        onTap: (){

        },
     ),
       InkWell(
         child: Row(
         children: <Widget>[
           Text(
           '+46735517944',
           style: TextStyle(fontSize: 14,color:Colors.black, ),),
          
          Icon(Icons.edit,size:20,color: Colors.blue,),
         ],
        ),
        onTap: (){
          
        },
     ),
     Text('abdussalm9393@gmail.com'
     ,style: TextStyle(fontSize: 14,color:Colors.black, ),),
            
           !uploadButton? Padding(
               padding: EdgeInsets.only(top: 0.0),
               child: IconButton(
                icon: Icon(Icons.cloud_upload,size: 20.0,),
                onPressed: (){
                  uploadPic(context);
                },
             ),
             ): Container(),
               ],),
      ],),
      
         ),
        SizedBox(height: 10,),
       ],
        );
  }
  Widget upImg(context){
    return Padding(
               padding: EdgeInsets.only(top: 0.0),
               child: IconButton(
                icon: Icon(Icons.cloud_upload,size: 20.0,),
                onPressed: (){
                  uploadPic(context);
                },
             ),
             );
  }
}