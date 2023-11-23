import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/CartModel.dart';

import '../../cart/cart_screen.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(builder: (context, cart, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(child: SearchField()),
            const SizedBox(width: 16),
            IconBtnWithCounter(
              svgSrc: "assets/icons/Cart Icon.svg",
              numOfitem: cart.demoCarts.length,
              press: () => Navigator.pushNamed(context, CartScreen.routeName),
            ),
            const SizedBox(width: 8),
            IconBtnWithCounter(
              svgSrc: "assets/icons/Bell.svg",
              numOfitem: 3,
              press: () {},
            ),
          ],
        ),
      );
    });
  }
}
