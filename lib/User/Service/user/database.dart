import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:volc/User/Model/user_detail.dart';
class DatabaseService{
  final String uid;
  DatabaseService({this.uid});
  // collection refrence 
  final CollectionReference userCollection = Firestore.instance.collection('users');
  Future updateUserData(String email,String first_name,
        String last_name, String phone_number,
        String address,String photoURL) async{
      return await userCollection.document(uid).setData({
        'email': email,
       'userID':uid,
       'first_name': first_name,
       'last_name': last_name,
       'phone_number': phone_number,
       'address': address,
       'photoURL':photoURL  
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
        first_name:doc.data['first_name'] ?? '',
        last_name: doc.data['last_name'] ?? '',
        photoURL: doc.data['photoURL'] ?? '',
        address: doc.data['address'] ?? '',
        phone_number: doc.data['phone_number'] ?? '', 
      );
      return userDetail;
      }
    }).toList();
    return userDetail;
  }
  Stream<UserDetail> get user  {
    return userCollection.snapshots().map(_userDetailFromSnapshot);

  }

 
}