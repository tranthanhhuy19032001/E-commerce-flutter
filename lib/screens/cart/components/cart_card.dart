import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../components/rounded_icon_btn.dart';
import '../../../constants.dart';
import '../../../models/Cart.dart';
import '../../../models/CartModel.dart';

class CartCard extends StatefulWidget {
  const CartCard({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _CartCardState createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
    final cartModel = Provider.of<CartModel>(context);
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(widget.cart.product.images[0]),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.cart.product.title,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                maxLines: 2,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      text: "\$${widget.cart.product.price}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, color: kPrimaryColor),
                      children: [
                        TextSpan(
                          text: " x${widget.cart.numOfItem}",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      RoundedIconBtn(
                        icon: Icons.remove,
                        press: () {
                          if (widget.cart.numOfItem > 1) {
                            setState(() {
                              cartModel.updateDecreaseQuantity(widget.cart);
                              widget.cart.numOfItem--;
                            });
                          }
                        },
                      ),
                      const SizedBox(width: 10),
                      RoundedIconBtn(
                        icon: Icons.add,
                        showShadow: true,
                        press: () {
                          setState(() {
                            cartModel.updateIncreaseQuantity(widget.cart);
                            widget.cart.numOfItem++;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
