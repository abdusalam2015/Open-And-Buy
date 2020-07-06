import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:OpenAndBuy/Model/user.dart';
import 'package:OpenAndBuy/Service/database.dart';

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

  Future registerWithEmailAndPassword(String firstName, String lastName,String email, String password, LocationResult myLocation,Map<String, String> phone)async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      // Get the location/address
        
        String latitude = myLocation.latLng.latitude.toString();
        String longitude = myLocation.latLng.longitude.toString();
        String address = myLocation.address;
        
        
      // Create a new document for the user with the uid 
      await DatabaseService (uid: user.uid).updateUserData(
        email:email,firstName:firstName,lastName: lastName,
       phoneNumber:'', address:address, photoURL:'', 
       latitude:latitude,longitude:longitude,phone:phone
       );
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  static Future changePassword(
      String _newPassword, String _currentPassword, String email) async {
    //Create an instance of the current user.
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    AuthCredential credential = EmailAuthProvider.getCredential(
      email: email,
      password: _currentPassword,
    );
    try {
      await user.reauthenticateWithCredential(credential).then((v) async {
        if (v.user == null) {
          print("NULL");
          return false;
        } else {
          try {
            await user.updatePassword(_newPassword).then((value) {
              print("Succesfull changed password");
              return true;
            });
          } catch(e) {
            print("not changed password");
          }
        }
      });
    } on PlatformException  catch (e) {
      print('Catched');
    }
 
    return false;
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