import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:volc/Admin/Service/storeDatabase.dart';
import 'package:volc/SharedModels/product/product.dart';
import 'package:volc/SharedModels/store/category.dart';
import 'package:volc/SharedModels/store/store.dart';
import 'package:volc/User/Model/user_detail.dart';
import 'package:volc/User/Service/user/database.dart';


class SharedFunctions{

Future uploadPic(File _image, String uid, UserDetail userDetail)async{
      String fileName =uid;
      StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask  uploadTask = firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      /// update user details (PhotoURL)
      firebaseStorageRef.getDownloadURL().then((fileURL) async {  
        await DatabaseService(uid: uid).updateUserData(
          userDetail.email,
          userDetail.first_name,
          userDetail.last_name,
          userDetail.phone_number,
          userDetail.address,
          fileURL);
      });


    }
Future uploadStorePic(File _image, String uid, StoreDetail storeDetail)async{
      String fileName =uid;
      StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('stores').child(fileName);
      StorageUploadTask  uploadTask = firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      /// update user details (PhotoURL)
      firebaseStorageRef.getDownloadURL().then((backgroundImage) async {  
        storeDetail.backgroundImage = backgroundImage;
        await StoreDatabaseService().updateStoreData(storeDetail);
      });
    }

Future uploadProductImage(File _image, Product product,Category category,StoreDetail storeDetail)async{
      String fileName =product.id;
      StorageReference firebaseStorageRef =  FirebaseStorage.instance.ref().child('stores').child(storeDetail.name).
      child('Categories').child(category.name).child(product.name).child(fileName);
      StorageUploadTask  uploadTask =  firebaseStorageRef.putFile( _image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

      /// update user details (PhotoURL)
    return  await firebaseStorageRef.getDownloadURL().then((backgroundImage)
     => backgroundImage );  
    }

     Future<File> getImage() async{
      File image ;
      try{
        image = await ImagePicker.pickImage(source:ImageSource.gallery);
      }catch(e){
        print(e);
      }
      if(image == null){
        return null;
      }else {
        return image;
      }
     // _image=image;
    }
      Uint8List imageFile; 

   Future<Uint8List> getProductImage(String  storeName,String categoryName,
   String productID ) async {
     print(storeName + ' ' + categoryName + ' ' + productID +"      jkkkkkkkkk");
      StorageReference photosreference =   FirebaseStorage.instance.ref().
      child('stores').child('hello').child('Categories').child('Drinks ');
      int maxSize = 7*1024*1024;
        return await photosreference.child(productID).getData(maxSize).then((data){
        imageFile = data;
      //  print(imageFile.toString() + "  RRRR");
        return imageFile;
      }).catchError((error){

      });
               //     print(imageFile.toString() + "  YREE E");

      //return imageFile;
    }
    Uint8List getmg(){
      getProductImage('hello','Drinks ','tr');
      print(imageFile.toString() + "  KLKLKLK");
      return imageFile;
    }
    
}