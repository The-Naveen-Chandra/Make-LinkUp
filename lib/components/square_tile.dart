import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imgPath;
  final Function()? onTap;

  const SquareTile({
    super.key,
    required this.imgPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey[200],
        ),
        child: Image.asset(
          imgPath,
          height: 35,
        ),
      ),
    );
  }
}
