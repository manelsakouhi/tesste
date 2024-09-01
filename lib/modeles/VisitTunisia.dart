import 'package:flutter/material.dart';

class VisitTunis extends StatelessWidget {
  const VisitTunis({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Visit Tunisia"),
      ),
      body: const Text('hello', style: TextStyle(fontSize: 50),
      ),
    );
  }
}