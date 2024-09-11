import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste/Admin/RDV/user_details.dart';

class UsersListView extends StatefulWidget {
  const UsersListView({super.key});

  @override
  _UsersListViewState createState() => _UsersListViewState();
}

class _UsersListViewState extends State<UsersListView> {
  bool _showActive = true; // Toggle to switch between active and disabled users
  String _searchQuery = ''; // Search query to filter users
  final TextEditingController _searchController = TextEditingController();

  Future<List<Map<String, dynamic>>> _fetchUsers() async {
    try {
      // Fetch data from the 'users' collection
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').get();

      // Convert the QuerySnapshot to a List of Map with document IDs
      final users = querySnapshot.docs
          .map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            // Add document ID to the data map
            data['id'] = doc.id;
            return data;
          })
          .where((user) => user['role'] != 'admin') // Filter out users with role 'admin'
          .where((user) => _showActive ? user['states'] == 'active' : user['states'] == 'notActive') // Filter based on _showActive
          .where((user) {
            // Filter based on search query
            final fullName = '${user['firstName']} ${user['lastName']}'.toLowerCase();
            final email = user['email']?.toLowerCase() ?? '';
            return fullName.contains(_searchQuery.toLowerCase()) || email.contains(_searchQuery.toLowerCase());
          })
          .toList();
      
      return users;
    } catch (e) {
      // Handle any errors that occur during the fetch
      throw Exception('Failed to load users: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users List"),
        actions: [
          Switch(
            value: _showActive,
            onChanged: (value) {
              setState(() {
                _showActive = value;
              });
            },
            activeColor: Colors.green,
            inactiveThumbColor: Colors.red,
            inactiveTrackColor: Colors.red[300],
            activeTrackColor: Colors.green[300],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search by Name or Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _fetchUsers(),
              builder: (context, snapshot) {
                // Handle the different states of the Future
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text('Chargement des utilisateurs...'),
                      ],
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.error, color: Colors.red, size: 50),
                        SizedBox(height: 16),
                        Text(
                          'Erreur lors du chargement des utilisateurs.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.red, fontSize: 18),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Veuillez vérifier votre connexion ou réessayer plus tard.',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      'Aucun utilisateur trouvé.',
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                }

                final users = snapshot.data!;

                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    final firstName = user['firstName'] ?? 'Non défini';
                    final lastName = user['lastName'] ?? 'Non défini';
                    final email = user['email'] ?? 'Non défini';
                    final role = user['role'] ?? 'Non défini';
                    final location = user['location'] ?? '';
                    final image = user['image'] ?? "";
                    final createdAt = user['createdAt'] as Timestamp?;
                    final documentId = user['id'] ?? 'Non défini';

                    return GestureDetector(
                      onTap: () {
                        Get.to(UserDetails(
                          firstName: firstName,
                          lastName: lastName,
                          email: email,
                          role: role,
                          image: image,
                          createdAt: createdAt ?? Timestamp.now(),
                          documentId: documentId,
                          location: location,
                        ));
                      },
                      child: Card(
                        child: ListTile(
                          title: Text("$firstName $lastName"),
                          subtitle: Text(email),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
