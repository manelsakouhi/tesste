import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(VisitTunis());
}

class VisitTunis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

     
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('76'.tr,textAlign: TextAlign.center,),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Image of Tunisia
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/tunisia.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Title with a distinct background and padding
          Container(
            color: Colors.blue[50],  // Light background color for contrast
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '78'.tr,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],  // Darker text color for contrast
              ),
            ),
          ),
          // Spacer between the title and the list
          SizedBox(height: 16.0),
          // List of destinations
          Expanded(
            child: ListView(
              children: <Widget>[
                DestinationCard(
                  name: '79'.tr,
                  description: '80'.tr,
                  imageUrl: 'assets/images/sidi_bou_said.jpg',
                ),
                DestinationCard(
                  name: '81'.tr,
                  description: '82'.tr,
                  imageUrl: 'assets/images/carthage.jpg',
                ),
                DestinationCard(
                  name: '83'.tr,
                  description: '84'.tr,
                  imageUrl: 'assets/images/matmataa.jpg',
                ),
                DestinationCard(
                  name: '85'.tr,
                  description: '86'.tr,
                  imageUrl: 'assets/images/kairouan.jpg',
                ),
                DestinationCard(
                  name: '101'.tr,
                  description: '101'.tr,
                  imageUrl: 'assets/images/douz.jpg',
                ),
                DestinationCard(
                  name: '87',
                  description: '88'.tr,
                  imageUrl: 'assets/images/hammamet.jpg',
                ),
                DestinationCard(
                  name: '89'.tr,
                  description: '90'.tr,
                  imageUrl: 'assets/images/tozeur.jpg',
                ),
                DestinationCard(
                  name: '91'.tr,
                  description: '92'.tr,
                  imageUrl: 'assets/images/bizerte.jpg',
                ),
                DestinationCard(
                  name: '93'.tr,
                  description: '94'.tr,
                  imageUrl: 'assets/images/sousse.jpg',
                ),
                DestinationCard(
                  name: '95'.tr,
                  description: '96'.tr,
                  imageUrl: 'assets/images/tunis.jpg',
                ),
                DestinationCard(
                  name: '97'.tr,
                  description: '98'.tr,
                  imageUrl: 'assets/images/el_kef.jpg',
                ),
                DestinationCard(
                  name: '99'.tr,
                  description: '100'.tr,
                  imageUrl: 'assets/images/sbeitla.jpg',
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DestinationCard extends StatelessWidget {
  final String name;
  final String description;
  final String imageUrl;

  DestinationCard({
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      elevation: 4.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Destination Image
          Image.asset(
            imageUrl,
            fit: BoxFit.cover,
            height: 250,
            width: double.infinity,
          ),
          // Destination Name
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Destination Description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Text(
              description,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
