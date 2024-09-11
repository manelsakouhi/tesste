import 'package:flutter/material.dart';

class inviteFriend extends StatelessWidget {
  const inviteFriend({super.key});

  @override
  Widget build(BuildContext context) {
    return                   Expanded(
                    child: InkWell(
                      onTap: () {
                        //Get.to(() => Inviteguest());
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            color: Colors.blue.withOpacity(0.9)),
                        child: Center(
                          child: Text(
                            "invite Friends",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
  }
}