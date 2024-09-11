import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final void Function() onTap;
  const ProfileWidget({
    super.key, required this.icon, required this.title, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        child: Row(
          mainAxisAlignment:MainAxisAlignment.spaceBetween ,
          children: [
            Row( 
        
              children: [
                Icon(icon, color: Colors.black.withOpacity(.5), size: 24.0,),
                const SizedBox(
                  width: 16.0,
                ),
                Text(title, style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600
                ),),
          Icon(Icons.arrow_forward_ios, color: Colors.black.withOpacity(.4), size: 16.0,),
    
              ],
            ),
          ],
        ),
    
      ),
    );
  }
}