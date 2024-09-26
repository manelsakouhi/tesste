import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Partenaire extends StatelessWidget {
  final List<Data> _photo = [
    Data(image: "assets/images/BCT.jpg", text: "104".tr),
    Data(image: "assets/images/UTICA.jpg", text: "UTICA"),
    Data(image: "assets/images/UTAP.jpg", text: "UTAP"),
    Data(image: "assets/images/tunisair.jpg", text: "105".tr),
    Data(image: "assets/images/CCIT.png", text: "CCIT"),
    Data(image: "assets/images/CTN.jpg", text: "CTN"),
    Data(image: "assets/images/GIZ.jpg", text: "106".tr),
    Data(image: "assets/images/GIPP.png", text: "107".tr),
    //Data(image: "assets/images/pavillon2.jpg", text: "pavillon Tunisia"),
    //Data(image: "assets/images/tunis_dubai.jpg", text: "pavillon Tunisia_dubai"),
  ];

  Partenaire({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:  Text(
          "103".tr,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        color: Colors.grey[200], // Light grey background for contrast
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: _photo.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemBuilder: (context, index) {
            return Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Container(
                      width: double.infinity,
                      height: 120.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(_photo[index].image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _photo[index].text,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class Data {
  final String image;
  final String text;

  Data({required this.image, required this.text});
}
