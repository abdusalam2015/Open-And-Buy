import 'package:flutter/material.dart';
import 'package:shopping_now/pages/product/product.dart';

class CartBloc with ChangeNotifier {
  Map<String, int> _cart = {};
  Map<String , Product> _cartInfo = {};

  Map<String, int> get cart => _cart;
  Map<String, Product> get productInfo => _cartInfo;
 
  void addToCart(index,product) {
    if (_cart.containsKey(index)) {
      _cart[index] += 1;
    } else {
      _cart[index] = 1;
    }
    _cartInfo[index]=product;
    notifyListeners();
  }

  void clear(index) {
    if (_cart.containsKey(index)) {
      _cart.remove(index);
      notifyListeners();
    }
  }
}
