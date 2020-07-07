class Calculations{

  static double productsSummation(List<double>productsPrices){
    double total = 0.0;

    for(int i = 0 ; i < productsPrices.length; i++ ){
total +=productsPrices[i];
print(productsPrices[i]);
    } 
    return total;
  }
}