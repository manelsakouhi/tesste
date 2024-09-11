import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../Admin/utils/app_color.dart';

class custom_2 extends StatefulWidget {
   DocumentSnapshot eventData,user;

  custom_2 (this.eventData,this.user);

  @override
  State<custom_2> createState() => _custom_2State();
}

class _custom_2State extends State<custom_2> {
  @override
  Widget build(BuildContext context) {
    return Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Color(0xff0000FF), width: 1.5),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Text(
                     '${widget.eventData.get('start_time')}',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "${widget.eventData.get('event_name')}",
                    style: TextStyle(
                        fontSize: 18,
                        color: AppColors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "${widget.eventData.get('date')}",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              );
  }
}