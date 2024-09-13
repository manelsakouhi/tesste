import 'package:flutter/material.dart';

class CustomIconWithTitle extends StatelessWidget {
  const CustomIconWithTitle({
    super.key, required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return  Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      //Icon(Icons.event),
      const SizedBox(width: 5),
      Text(title , style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),),
    ],);
  }
}
