import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:volc/User/Model/user_detail.dart';
class DatabaseService{
  final String uid;
  DatabaseService({this.uid});
  // collection refrence 
  final CollectionReference userCollection = Firestore.instance.collection('users');
  Future updateUserData({String email,String firstName,
        String lastName, String phoneNumber,
        String address,String photoURL, String latitude, String longitude}) async{
          //latitude: 12.960632, longitude: 77.641603
      return await userCollection.document(uid).setData({
       'email': email,
       'userID':uid,
       'first_name': firstName,
       'last_name': lastName,
       'phone_number': phoneNumber,
       'address': address,
       'photoURL':photoURL,
       'latitude':latitude,
      'longitude': longitude,

     });
  }
Future updateUserLocation({String lat, String long}) async{
      return await userCollection.document(uid).setData({
       'userID':uid,
       'address': '',
       'photoURL':'photoURL' ,
     });
  }

  UserDetail userDetail;
  UserDetail _userDetailFromSnapshot(QuerySnapshot snapshot){
    //UserDetail userDetail;
    snapshot.documents.map((doc) {
      if(uid == doc.data['userID']){
      userDetail =  UserDetail(
       email: doc.data['email'],
        userID: doc.data['userID'],
        firstName:doc.data['first_name'] ?? '',
        lastName: doc.data['last_name'] ?? '',
        photoURL: doc.data['photoURL'] ?? '',
        address: doc.data['address'] ?? '',
        phoneNumber: doc.data['phone_number'] ?? '',          
        latitude: doc.data['latitude'] ?? '', 
        longitude: doc.data['longitude'] ?? '', );
      return userDetail;
      }
    }).toList();
    return userDetail;
  }
  Stream<UserDetail> get user  {
    return userCollection.snapshots().map(_userDetailFromSnapshot);
  }
  static Future getUserInfo(String userID) async{
    UserDetail userInfo;
      await Firestore.instance.collection('users').
      document(userID).get()
          .then((doc) {
      userInfo = new  UserDetail(
       email: doc.data['email'],
        userID: doc.data['userID'],
        firstName:doc.data['first_name'] ?? '',
        lastName: doc.data['last_name'] ?? '',
        photoURL: doc.data['photoURL'] ?? '',
        address: doc.data['address'] ?? '',
        phoneNumber: doc.data['phone_number'] ?? '',          
        latitude: doc.data['latitude'] ?? '', 
        longitude: doc.data['longitude'] ?? '', );
      }).catchError((error) {
        print('Iam in getUserInfo ,in a function called  getUserInfo ');
        //check = false;
      });
      return userInfo;

  }

 
  Future registerTokens(String userID) async{
    // create a token 
 final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
 String token='';
    await _firebaseMessaging.getToken().then((tkn) {
      token = tkn;
       print("THe token is here: "+token);
    });

  final CollectionReference userCollection = Firestore.instance.collection('users').
  document(userID).collection('tokens');
  await userCollection.document(userID).setData({
    'token':  token,
  });
  }
}