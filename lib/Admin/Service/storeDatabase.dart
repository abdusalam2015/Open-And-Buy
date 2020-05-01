import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:volc/SharedModels/product/product.dart';
import 'package:volc/SharedModels/store/category.dart';
import 'package:volc/SharedModels/store/store.dart';
import 'package:volc/SharedWidgets/shared_functions.dart';

class StoreDatabaseService{
 String sid;
StoreDatabaseService({this.sid});
final CollectionReference storeCollection = Firestore.instance.collection('stores');
Future updateStoreData(StoreDetail storeDetail) async{
        await storeCollection.document(storeDetail.sid).setData({
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
// register  store token ! 
  await registerStoreTokens(storeDetail.sid);
  }
Future addProduct( img, Product product,String sid,Category selectedCategory,StoreDetail storeDetail)async{
    final SharedFunctions sharedfun = new SharedFunctions();
 product.imgPath = (img != '' && img != null)? await sharedfun.uploadProductImage(img,product, selectedCategory, storeDetail):'';
final DocumentReference addProductCollection = Firestore.instance.collection('stores').
document(sid).collection('categories').document(selectedCategory.categoryID).collection('products').document();
   await addProductCollection.setData({
        'name':  product.name ,
        'price': product.price,
        'ProductInfo':  product.info ,
        'productID':  addProductCollection.documentID,
       'image':  product.imgPath,
     });
     print(')))'+ product.name);

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
Future<List<StoreDetail>> getAllStores() async {
  try{
   QuerySnapshot qn =  await  Firestore.instance.collection('stores').getDocuments();
   return  qn.documents.map((doc){
      return StoreDetail(doc.data['sid'],doc.data['name'],doc.data['email'],doc.data['password'],doc.data['location'],
      doc.data['backgroundImage'],doc.data['coveredArea'],doc.data['storeType'],doc.data['phoneNumber']
     );
    }).toList();
  }catch(e){


    print('Iam inside getStoreInfo funciton ' + e.toString());
    return null;
  }
}

Future getStoreInfo(String userID) async {
  //  var firestore = Firestore.instance;
  try{
    StoreDetail storeDetail = new StoreDetail('', '', '', '', '', '', '', '', '') ;
    await  Firestore.instance.collection('stores').
    document(userID).get().then((onValue){
      storeDetail.name =  onValue['name'] ?? '';
      storeDetail.email = onValue['email'];
      storeDetail.sid= onValue['sid'];
      storeDetail.phoneNumber = onValue['phoneNumber'];
      storeDetail.location = onValue['location'];
      storeDetail.backgroundImage = onValue['backgroundImage'] ?? '';
      storeDetail.password = onValue['password'];
      storeDetail.storeType = onValue['storeType'];
      storeDetail.coveredArea = onValue['coveredArea'];
    }).catchError((error) {
      print('Iam in StoreDatabasefile ,in a function called  getStoreInfo ');
      throw error;
    });
    return storeDetail;
  }catch(e){
    print('Iam inside getStoreInfo funciton ' + e.toString());
    return '';
  }
}

Future getStoreProducts(String storeID,String categoryID ) async {
    try{
    var firestore = Firestore.instance;
  QuerySnapshot qn = await  firestore.collection('stores').
    document(storeID).collection('categories').document(categoryID).
    collection('products').getDocuments();
     return qn.documents.map((doc) {
       return Product(
         id:doc.data['productID'],
         name:doc.data['name'],
         imgPath: doc.data['image'],
         price: doc.data['price'],
         info: doc.data['ProductInfo']
         );
      }).toList(); 
    }catch(e){
      print(e.toString()+ 'Iam inside getStoreProducts function');
      return ;
    }
}

//  Uint8List getProductImages(String  storeName,String categoryName,String productID ){
//      print(storeName + ' ' + categoryName + ' ' + productID);
//       Uint8List imageFile; 
//       StorageReference photosreference = FirebaseStorage.instance.ref().
//       child('stores').child(storeName).child(categoryName);
//       int maxSize = 10*1024*1024;
//       photosreference.child(productID).getData(maxSize).then((data){
//         imageFile = data;
//         return imageFile;
//       }).catchError((error){

//       });
//     }

// var document = await Firestore.instance.collection('COLLECTION_NAME').document('TESTID1');
// document.get() => then(function(document) {
//     print(document('name'));
// }

// return await storeCollection.document(userID).get()({
//         'name':  storeDetail.name ,
//         'email':  storeDetail.email ,
//         'sid':  storeDetail.sid ,
//        'phoneNumber':  storeDetail.phoneNumber,
//        'location':  storeDetail.location,
//        'backgroundImage':  storeDetail.backgroundImage,
//        'password':  storeDetail.password ,
//        'storeType'  :  storeDetail.storeType ,
//        'coveredArea'  :  storeDetail.coveredArea ,
//      });

//   }
  Future getcategories(String userID) async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await  firestore.collection('stores').
    document(userID).collection('categories').getDocuments();
      //Mapping ....
      try{
        return qn.documents.map((doc) {
      return Category(
        categoryID: doc.data['categoryID'],
        productNumbers: doc.data['productNumber'],
        name: doc.data['name']);
      }).toList();
      } catch(e){
        print(e + 'Iam here inside getcategories funciton ');
      }

  }
  // List<Category> getAllCategories(String userID) { 
  //     List<Category> _categoriesList = new List<Category>();
  //     Future<dynamic> _list =  getcategories(userID); 
  //     var x = getcategories(userID);
   
  //  // return _categoriesList;
  // }


  
  Future registerStoreTokens(String storeID) async{
    // create a token 
 final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
 String token='';
    await _firebaseMessaging.getToken().then((tkn) {
      token = tkn;
       print("THe token is here: "+token);
    });

  final CollectionReference userCollection = Firestore.instance.collection('stores').
  document(storeID).collection('tokens');
  await userCollection.document(storeID).setData({
    'token':  token,
  });
 

  }

}


