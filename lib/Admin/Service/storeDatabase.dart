import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:volc/SharedModels/store/store.dart';

class StoreDatabaseService{
String sid;
StoreDatabaseService({this.sid});
  final CollectionReference storeCollection = Firestore.instance.collection('stores');
Future updateStoreData(StoreDetail storeDetail,String uid) async{
       return await storeCollection.document(uid).setData({
        'name':  storeDetail.name ,
        'email':  storeDetail.email ,
        'sid':  storeDetail.sid ,
       'phoneNumber':  storeDetail.phoneNumber,
       'location':  storeDetail.location,
       'backgroundImage':  storeDetail.backgroundImage,
       'password':  storeDetail.password ,
       'storeType'  :  storeDetail.storeType ,
       'coveredArea'  :  storeDetail.coveredArea ,
     });
  }



StoreDetail initStore(StoreDetail storeDetail) => StoreDetail(
  storeDetail.sid??'',storeDetail.name??'',storeDetail.email??''
  ,storeDetail.password??'',storeDetail.location??'',storeDetail.backgroundImage??'',
  storeDetail.coveredArea??'',storeDetail.storeType??'',storeDetail.phoneNumber??'');



  // register with email and password
  Future registerNewStore(StoreDetail storeDetail)async{
    try{
        // final FirebaseAuth _auth  = FirebaseAuth.instance;
        // String x =  _auth.currentUser().toString();
        // print("userID: $x");
      // AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      // FirebaseUser user = result.user;
      // Create a new document for the user with the uid 
      // await StoreDatabaseService (sid:' user.uid').updateStoreData(email,'', '',
      //  '', '','' ,'','','');
      // return x;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

final CollectionReference testCollection = Firestore.instance.collection('stores');
Future test(String uid) async{
       return await testCollection.document(uid).collection('Category #3').
       document().collection('Product #4').document().setData({
        'product Name':  'juce2' ,
        'product price':  '60' ,
     });
  }







}


