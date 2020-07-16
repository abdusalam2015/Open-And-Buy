import 'package:flutter/material.dart';
import 'package:OpenAndBuy/Model/product.dart';

class CartBloc with ChangeNotifier {
  Map<String, Map<String, int>> _cart = {};
  Map<dynamic, Map<dynamic, dynamic>> _cartInfo = {};
  Map<String, double> _total = {};

  Map<String, Map<String, int>> get cart => _cart;
  Map<dynamic, Map<dynamic, dynamic>> get productInfo => _cartInfo;
  Map<String, double> get total => _total;

  void addToCart(index, product, storeID) {
    if (_cart[storeID] == null) _cart[storeID] = {};
        if (total[storeID] == null) total[storeID] = 0.0;


    if (_cart[storeID].containsKey(index)) {
      _cart[storeID][index] += 1;
      // _cart[index] += 1;
    } else {
      _cart[storeID][index] = 1;
      // _cart[index] = 1;
    }
    if (_cartInfo[storeID] == null) _cartInfo[storeID] = {};
    _cartInfo[storeID][index] = product;
    _total[storeID] += double.parse(_cartInfo[storeID][index].price).toDouble();

    notifyListeners();
  }

  void subToCart(index, product, storeID) {
    if (_cart[storeID].containsKey(index)) {
      _cart[storeID][index] -= 1;
      // _cart[index] -= 1;
    } else {
      _cart[storeID][index] = 1;
      //_cart[index] = 1;
    }
    _cartInfo[storeID][index] = product;
    _total[storeID] -= double.parse(_cartInfo[storeID][index].price).toDouble();
    notifyListeners();
  }

  void clear(index, storeID) {
    if (_cart[storeID].containsKey(index)) {
      _total[storeID] -=
          (double.parse(_cartInfo[storeID][index].price).toDouble()) *
              _cart[storeID][index];
      _cart[storeID].remove(index);
      _cartInfo[storeID].remove(index);
      notifyListeners();
    }
  }

  void clearTotal(storeID) {
    _total[storeID] = 0.0;
    notifyListeners();
  }

  //  void  productsSummation(List<double> productsPrices) {

  //   for (int i = 0; i < productsPrices.length; i++) {
  //     _total += productsPrices[i];
  //     print(productsPrices[i]);
  //   }
  //  // return _total;
  // }
}
