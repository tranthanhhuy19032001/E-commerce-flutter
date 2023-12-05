import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:shop_app/models/Cart.dart';

class CartModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  final List<Cart> demoCarts = [];
  double totalPrice = 0.0;

  /// An unmodifiable view of the items in the cart.
  // UnmodifiableListView<Cart> get items => UnmodifiableListView(demoCarts);

  void add(Cart item) {
    int existingItemIndex = -1;
    for (int i = 0; i < demoCarts.length; i++) {
      if (demoCarts[i].product == item.product) {
        existingItemIndex = i;
        break;
      }
    }
    if (existingItemIndex != -1) {
      demoCarts[existingItemIndex].numOfItem++;
      totalPrice += demoCarts[existingItemIndex].product.price;
    } else {
      demoCarts.add(item);
      totalPrice += demoCarts[demoCarts.length - 1].product.price;
    }
    notifyListeners();
  }

  void removeAll() {
    demoCarts.clear();
    totalPrice = 0.0;
    notifyListeners();
  }

  void removeAtIndex(int index) {
    totalPrice -= demoCarts[index].product.price * demoCarts[index].numOfItem;
    demoCarts.removeAt(index);
    notifyListeners();
  }

  void updateDecreaseQuantity(Cart cart) {
    for (int i = 0; i < demoCarts.length; i++) {
      if (demoCarts[i].product == cart.product) {
        demoCarts[i].numOfItem = cart.numOfItem;
        totalPrice -= demoCarts[i].product.price;
      }
    }
    notifyListeners();
  }

  void updateIncreaseQuantity(Cart cart) {
    for (int i = 0; i < demoCarts.length; i++) {
      if (demoCarts[i].product == cart.product) {
        demoCarts[i].numOfItem = cart.numOfItem;
        totalPrice += demoCarts[i].product.price;
      }
    }
    notifyListeners();
  }
}
