import 'package:volc/models/user_detail.dart';

class UserFunctions{
  final String userID;
  UserFunctions(this.userID);

   UserDetail getUserDetail(List<UserDetail> usersDetails){
    for (var item in usersDetails) {
      if(item.userID == userID)return item;
    }
    return null;
}


}