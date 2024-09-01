import 'package:flutter/material.dart';
class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureTexte;

  const MyTextField({super.key,
  required this.controller,
  required this.hintText,
  required this.obscureTexte});

  @override
  Widget build(BuildContext context) {
    return  Padding(
              padding: const EdgeInsets.symmetric(horizontal:25.0),
              child: TextField(
                controller: controller,
                obscureText: obscureTexte,
                decoration: InputDecoration(
                  enabledBorder:const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white
            
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black
            
                    ),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                 hintText: hintText,
                ),
              ),
            );
  }
}