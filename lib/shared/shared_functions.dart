import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:volc/services/database.dart';

class SharedFunctions{
  // File _image;
 // final AuthService _auth = new AuthService();
Future uploadPic(File _image, String uid) async{
      String fileName =uid;
      StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask  uploadTask = firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

      /// update user details (PhotoURL)
      firebaseStorageRef.getDownloadURL().then((fileURL) async {  
        await DatabaseService(uid: uid).updateUserData('Abdulsalam', 'Fadhel',
       '0735517944', 'distancegatan 21', fileURL);
       
      });


     // StorageReference imageLink = storage.ref().child('giftShopItems').child(documentSnapshot['imageName']);
        //  final imageUrl = await firebaseStorageRef.;
        //  print('imageUrl: $imageUrl');


         // getDownloadUrl();
        // Image.network(imageUrl.toString());
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
      File image =  await ImagePicker.pickImage(source:ImageSource.gallery);
      if(image == null){
      }else {
        return image;
      }
     // _image=image;
    }
}