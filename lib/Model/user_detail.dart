class UserDetail{
  final String email;
  final String userID;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String address;
  final String photoURL;
  final double budget;
  final String latitude;
  final String longitude;
  Map<String, String> phone;

  UserDetail({this.email,this.userID,this.firstName, this.lastName,
   this.phoneNumber, this.address,this.phone, this.photoURL,this.latitude,this.longitude,this.budget});
}