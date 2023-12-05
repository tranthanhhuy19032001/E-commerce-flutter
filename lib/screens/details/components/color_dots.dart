import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/Product.dart';

class ColorDots extends StatefulWidget {
  const ColorDots({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  _ColorDotsState createState() => _ColorDotsState();
}

class _ColorDotsState extends State<ColorDots> {
  int selectedColor = 3; // Default selected color index
  int numOfItem = 1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...List.generate(
            widget.product.colors.length,
            (index) => ColorDot(
              color: widget.product.colors[index],
              isSelected: index == selectedColor,
              onTap: () {
                setState(() {
                  selectedColor = index; // Update the selected color index
                });
              },
            ),
          ),
          // const Spacer(),
          // RoundedIconBtn(
          //   icon: Icons.remove,
          //   press: () {},
          // ),
          // const SizedBox(width: 20),
          // RoundedIconBtn(
          //   icon: Icons.add,
          //   showShadow: true,
          //   press: () {},
          // ),
        ],
      ),
    );
  }
}

class ColorDot extends StatelessWidget {
  const ColorDot({
    Key? key,
    required this.color,
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);

  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Invoke the onTap function when the dot is tapped
      child: Container(
        margin: const EdgeInsets.only(right: 2),
        padding: const EdgeInsets.all(8),
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
              color: isSelected ? kPrimaryColor : Colors.transparent),
          shape: BoxShape.circle,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
