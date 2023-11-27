import 'dart:io';

import 'package:flutter/material.dart';

import '../../models/CartModel.dart';
import './components/checkout_page.dart';

class PaymentScreen extends StatefulWidget {
  static String routeName = "/payment";

  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    final PaymentArguments args =
        ModalRoute.of(context)!.settings.arguments as PaymentArguments;

    List<PriceItem> priceItems = [];
    for (var cart in args.cart.demoCarts) {
      priceItems.add(PriceItem(
          name: cart.product.title,
          quantity: cart.numOfItem,
          totalPriceCents:
              (cart.product.price * cart.numOfItem * 100).toInt()));
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: null,
        body: CheckoutPage(
          priceItems: priceItems,
          payToName: 'Payment',
          displayNativePay: true,
          onNativePay: () => print('Native Pay Clicked'),
          displayCashPay: true,
          isApple: Platform.isIOS,
          onBack: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}

class PaymentArguments {
  final CartModel cart;

  PaymentArguments({required this.cart});
}
