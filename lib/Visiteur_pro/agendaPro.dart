import 'package:flutter/material.dart';

class AgendaPro extends StatelessWidget {
  const AgendaPro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Agenda"),
      ),
      body: const Text('visiteur pro', style: TextStyle(fontSize: 50),
      ),
    );
  }
}