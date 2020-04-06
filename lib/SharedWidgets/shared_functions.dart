import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:volc/Admin/Service/storeDatabase.dart';
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
        await StoreDatabaseService().updateStoreData(storeDetail,uid);
      });
    }
// Future<Widget> _getImage(BuildContext context, String image) async {
//   Image m;
//   await FireStorageService.loadImage(context, image).then((downloadUrl) {
//     m = Image.network( downloadUrl.toString(),
//       fit: BoxFit.scaleDown,
//     );
//   });
// return m;
// }
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
}