import 'package:flutter/material.dart';

class Agenda extends StatelessWidget {
  const Agenda({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Agenda"),
      ),
      body: const Text('hello', style: TextStyle(fontSize: 50),
      ),
    );
  }
}