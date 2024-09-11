import 'package:flutter/material.dart';

class CustomIconWithTitle extends StatelessWidget {
  const CustomIconWithTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      //Icon(Icons.event),
      SizedBox(width: 5),
      Text("Create an Event" , style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),),
    ],);
  }
}
