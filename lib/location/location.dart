import 'dart:math';

   class  Location{

  static String  calculateDistance(double lat1, double lon1, double lat2, double lon2){
    print("Inseide calcualtion ");
    print(lat1);
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 + 
          c(lat1 * p) * c(lat2 * p) * 
          (1 - c((lon2 - lon1) * p))/2;
  //  return 
    var result = (12742 * asin(sqrt(a))).toInt();
    if(result == 0 ){
      return "less than 1 km";
    }else{
      return result.toString() + 'km away';
    }
  
  }
}