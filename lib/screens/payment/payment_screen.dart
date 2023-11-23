import 'dart:io';

import 'package:flutter/material.dart';
import 'package:checkout_screen_ui/checkout_page.dart';
import 'package:checkout_screen_ui/credit_card_form.dart';
import 'package:checkout_screen_ui/validation.dart';

class PaymentScreen extends StatefulWidget {
  static String routeName = "/payment";

  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  /// Build a list of what the user is buying
  final List<PriceItem> _priceItems = [
    PriceItem(name: 'Product A', quantity: 1, totalPriceCents: 5200),
    PriceItem(name: 'Product B', quantity: 2, totalPriceCents: 8599),
    PriceItem(name: 'Product C', quantity: 1, totalPriceCents: 2499),
    PriceItem(name: 'Delivery Charge', quantity: 1, totalPriceCents: 1599),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: null,
          body: CheckoutPage(
            priceItems: _priceItems,
            payToName: 'Vendor Name Here',
            displayNativePay: true,
            onNativePay: () => print('Native Pay Clicked'),
            displayCashPay: true,
            isApple: Platform.isIOS,
            onCardPay: (results) =>
                print('Credit card form submitted with results: $results'),
            onBack: () => Navigator.of(context).pop(),
          ),
        ));
  }
}
