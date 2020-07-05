import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:OpenAndBuy/Model/user_detail.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  // collection refrence
  final CollectionReference userCollection =
      Firestore.instance.collection('users');
  Future updateUserData(
      {String email,
      String firstName,
      String lastName,
      String phoneNumber,
      String address,
      String photoURL,
      String latitude,
      String longitude,
      Map<String, String> phone}) async {
    //latitude: 12.960632, longitude: 77.641603
    return await userCollection.document(uid).setData({
      'email': email,
      'userID': uid,
      'first_name': firstName,
      'last_name': lastName,
      'budget': 0.0,
      'phone_number': phoneNumber,
      'address': address,
      'photoURL': photoURL,
      'latitude': latitude,
      'longitude': longitude,
       'phone': phone
      
    });
  }

  // Future updateUserLocation({String lat, String long}) async {
  //   return await userCollection.document(uid).setData({
  //     'userID': uid,
  //     'address': '',
  //     'photoURL': 'photoURL',
  //   });
  // }

  UserDetail userDetail;
  UserDetail _userDetailFromSnapshot(QuerySnapshot snapshot) {
    //UserDetail userDetail;
    snapshot.documents.map((doc) {
      if (uid == doc.data['userID']) {
        userDetail = UserDetail(
          email: doc.data['email'],
          userID: doc.data['userID'],
          firstName: doc.data['first_name'] ?? '',
          lastName: doc.data['last_name'] ?? '',
          photoURL: doc.data['photoURL'] ?? '',
          budget: doc.data['budget'] ?? 0.0,
          address: doc.data['address'] ?? '',
          phoneNumber: doc.data['phone_number'] ?? '',
          latitude: doc.data['latitude'] ?? '0.0',
          longitude: doc.data['longitude'] ?? '0.0',
        );
        return userDetail;
      }
    }).toList();
    return userDetail;
  }

  Stream<UserDetail> get user {
    return userCollection.snapshots().map(_userDetailFromSnapshot);
  }

  static Future getUserInfo(String userID) async {
    UserDetail userInfo;
    Map<String, String> phone_number = {};
    await Firestore.instance
        .collection('users')
        .document(userID)
        .get()
        .then((doc) {
      userInfo = new UserDetail (
        email: doc.data['email'],
        userID: doc.data['userID'],
        firstName: doc.data['first_name'] ?? '',
        lastName: doc.data['last_name'] ?? '',
        photoURL: doc.data['photoURL'] ?? '',
        budget: doc.data['budget'] ?? 0.0,
        address: doc.data['address'] ?? '',
        phoneNumber: doc.data['phone_number'] ?? '',
        latitude: doc.data['latitude'] ?? '0.0',
        longitude: doc.data['longitude'] ?? '0.0',
        phone : Map.from( doc.data['phone']),
      );
    }).catchError((error) {
      print('Iam in getUserInfo ,in a function called  getUserInfo .....');
      //check = false;
    });
    return userInfo;
  }

  Future registerTokens(String userID) async {
    // create a token
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    String token = '';
    await _firebaseMessaging.getToken().then((tkn) {
      token = tkn;
      print("The token is here: " + token);
    });

    final CollectionReference userCollection = Firestore.instance
        .collection('users')
        .document(userID)
        .collection('tokens');
    await userCollection.document(userID).setData({
      'token': token,
    });
  }
   static Future updatePhoneData(
     
      String feildName, Map<String, String> newValue, String storeID) async {
        final CollectionReference user =
      Firestore.instance.collection('users');
    await user.document(storeID).updateData({
      feildName: newValue,
    });
  }
    static Future updateFirstName( String firstName, String userID) async {
        final CollectionReference user =
      Firestore.instance.collection('users');
    await user.document(userID).updateData({
      'first_name': firstName,
    });
  }
   static Future updateLastName( String lastName, String userID) async {
        final CollectionReference user =
      Firestore.instance.collection('users');
    await user.document(userID).updateData({
      'last_name': lastName,
    });
  }
  static Future updateProfilePic( String photoURL, String userID) async {
        final CollectionReference user =
      Firestore.instance.collection('users');
    await user.document(userID).updateData({
      'photoURL': photoURL,
    });
  }

   static Future updateUserLocation(
      String lat, String long, String address, String userID) async {
      final CollectionReference user =
      Firestore.instance.collection('users');
    await user.document(userID).updateData({
      'address': address,
      'latitude': lat,
      'longitude': long,
    });
  }

  
}
