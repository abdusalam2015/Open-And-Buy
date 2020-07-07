import 'package:flutter/material.dart';
import 'package:OpenAndBuy/Model/product.dart';

class CartBloc with ChangeNotifier {
  Map<String, int> _cart = {};
  Map<String, Product> _cartInfo = {};
  double _total = 0.0;

  Map<String, int> get cart => _cart;
  Map<String, Product> get productInfo => _cartInfo;
  double get total => _total;

  void addToCart(index, product) {
    if (_cart.containsKey(index)) {
      _cart[index] += 1;
      
    } else {
      _cart[index] = 1;
    }
    _cartInfo[index] = product;
    _total += double.parse(_cartInfo[index].price).toDouble();

    notifyListeners();
  }

  void subToCart(index, product) {
    if (_cart.containsKey(index)) {
      _cart[index] -= 1;       
    } else {
      _cart[index] = 1;
    }
    _cartInfo[index] = product;
    _total -= double.parse(_cartInfo[index].price).toDouble();
    notifyListeners();
  }

  void clear(index) {
    if (_cart.containsKey(index) ) {
      _total -=
          (double.parse(_cartInfo[index].price).toDouble()) * _cart[index];
      _cart.remove(index);
      _cartInfo.remove(index);
      notifyListeners();
    }
    
  }

  //  void  productsSummation(List<double> productsPrices) {

  //   for (int i = 0; i < productsPrices.length; i++) {
  //     _total += productsPrices[i];
  //     print(productsPrices[i]);
  //   }
  //  // return _total;
  // }
}
