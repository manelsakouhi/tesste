import 'package:flutter/material.dart';

class Maps extends StatelessWidget {
  const Maps({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Maps"),
      ),
      body: const Text('hello', style: TextStyle(fontSize: 50),
      ),
    );
  }
}