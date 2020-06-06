import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:volc/User/Model/user.dart';
import 'package:volc/User/Service/user/database.dart';

class AuthService {
  final FirebaseAuth _auth  = FirebaseAuth.instance;
  // create user obj based on FirebaseUser
  User _userFromFirebaseUser (FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }
  // auth change user stream
  Stream<User> get user{
    return _auth.onAuthStateChanged
   .map(_userFromFirebaseUser);
  }
  // sign in anon
  Future signInAnon() async {
    try{
     AuthResult result =  await _auth.signInAnonymously();
     FirebaseUser user = result.user;
     return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return  null;
    }
  }

  // sing in with email and password
    Future signInWithEmailAndPassword(String email, String password)async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      print('HEIII: '+ user.uid);

      // register the device token!!
    DatabaseService _obj = new DatabaseService(uid: user.uid);
    await _obj.registerTokens(user.uid);

    // return the userID
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  // register with email and password
  Future registerWithEmailAndPassword(String email, String password, LocationResult myLocation)async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      // Get the location/address
        
        String latitude = myLocation.latLng.latitude.toString();
        String longitude = myLocation.latLng.longitude.toString();
        String address = myLocation.address;
        
        
      // Create a new document for the user with the uid 
      await DatabaseService (uid: user.uid).updateUserData(
        email:email,firstName:'',lastName: '',
       phoneNumber:'', address:address, photoURL:'', 
       latitude:latitude,longitude:longitude,
       );
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
       return null;
    }
  }


  


}