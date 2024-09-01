import 'package:flutter/material.dart';

class Favoris extends StatefulWidget {
  const Favoris({super.key});

  @override
  State<Favoris> createState() => _FavorisState();
}

class _FavorisState extends State<Favoris> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Favorite"),
      ),
      body: const Text('hello', style: TextStyle(fontSize: 50),
      ),
    );
  }
}