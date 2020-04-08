import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:volc/Admin/Controller/store_home_pages/store_home_page.dart';
import 'package:volc/SharedModels/store/category.dart';
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


  // add new category
  //final CollectionReference categoryCollection = Firestore.instance.collection('stores');
  Future addCategory(StoreDetail storeDetail, Category category, String userID)async{
      final DocumentReference categoryCollection = Firestore.instance.collection('stores')
      .document(userID).collection('categories').document();
    try{
        return await categoryCollection.setData({
          'name' : category.name,
          'categoryID' : categoryCollection.documentID,
          'productsNumber' : category.productNumbers,
        });
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future getcategories(String userID) async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await  firestore.collection('stores').
    document(userID).collection('categories').getDocuments();

      //Mapping ....
       return qn.documents.map((doc) {
       return Category(
        categoryID: doc.data['categoryID'],
        productNumbers: doc.data['productNumber'],
        name: doc.data['name']);
      }).toList();

  }
  // List<Category> getAllCategories(String userID) { 
  //     List<Category> _categoriesList = new List<Category>();
  //     Future<dynamic> _list =  getcategories(userID); 
  //     var x = getcategories(userID);
   
  //  // return _categoriesList;
  // }

}


