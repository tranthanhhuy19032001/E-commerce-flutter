import 'package:flutter/material.dart';

import 'Product.dart';

class Cart extends ChangeNotifier {
  final Product product;
  int numOfItem;
  Cart({required this.product, required this.numOfItem});
}
