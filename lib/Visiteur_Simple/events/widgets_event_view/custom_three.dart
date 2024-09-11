import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../Admin/utils/app_color.dart';

class custom_3 extends StatefulWidget {
 DocumentSnapshot eventData,user;

  custom_3(this.eventData,this.user);
  @override
  State<custom_3> createState() => _custom_3State();
}

class _custom_3State extends State<custom_3> {
  @override
  Widget build(BuildContext context) {
    return Row(
                children: [
                  Icon(
                    Icons.location_on_rounded,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '${widget.eventData.get('location')}',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.black,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              );
  }
}