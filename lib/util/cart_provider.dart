import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<Map<String, String>> _cartItems = [];

  List<Map<String, String>> get cartItems => _cartItems;

  void addToCart(Map<String, String> product) {
    _cartItems.add(product);
    notifyListeners(); // カートに商品が追加されたことを通知
  }

  void removeFromCart(Map<String, String> product) {
    _cartItems.remove(product);
    notifyListeners(); // カートから商品が削除されたことを通知
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners(); // カートをクリアしたことを通知
  }
}
