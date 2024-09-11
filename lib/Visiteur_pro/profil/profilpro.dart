import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:teste/Screens/login.dart';

class ProfilPagepro extends StatefulWidget {
  const ProfilPagepro({super.key});

  @override
  State<ProfilPagepro> createState() => _ProfilPageproState();
}

class _ProfilPageproState extends State<ProfilPagepro> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  String? firstName;
  String? lastName;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    // Replace 'users' with your Firestore collection where you store user data
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get();

    if (userDoc.exists) {
      setState(() {
        firstName = userDoc['firstName'];
        lastName = userDoc['lastName'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile Page",
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            icon: const Icon(
              Icons.logout,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                const SizedBox(
                  width: 170,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.transparent,
                    backgroundImage: ExactAssetImage('assets/images/profil.jpg'),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.amber,
                    ),
                    child: const Icon(
                      LineAwesomeIcons.pencil_alt_solid,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Display the fetched name from Firestore
            SizedBox(
              width: size.width * .3,
              child: Text(
                firstName != null && lastName != null
                    ? '$firstName $lastName'
                    : 'Loading...',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            Text(
              currentUser.email!,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black.withOpacity(.3),
              ),
            ),
            const SizedBox(height: 30.0),
            SizedBox(
              height: size.height * .7,
              width: size.width,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ProfilClasspro(
                    icon: Icons.person,
                    title: 'My Profile',
                  ),
                  ProfilClasspro(
                    icon: Icons.settings,
                    title: 'Settings',
                  ),
                  ProfilClasspro(
                    icon: Icons.notifications,
                    title: 'Notifications',
                  ),
                  ProfilClasspro(
                    icon: Icons.logout,
                    title: 'Log Out',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilClasspro extends StatelessWidget {
  final IconData icon;
  final String title;

  const ProfilClasspro({Key? key, required this.icon, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, size: 28),
          const SizedBox(width: 20),
          Text(
            title,
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
