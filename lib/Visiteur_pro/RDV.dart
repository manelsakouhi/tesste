import 'package:flutter/material.dart';

class RDV extends StatelessWidget {
  const RDV({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("RDV"),
      ),
      body: const Text('hello', style: TextStyle(fontSize: 50),
      ),
    );
  }
}