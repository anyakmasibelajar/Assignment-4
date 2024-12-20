import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PigeonUserDetails {
  final String name;
  final String email;

  PigeonUserDetails({required this.name, required this.email});

  factory PigeonUserDetails.fromMap(Map<String, dynamic> data) {
    return PigeonUserDetails(
      name: data['name'] as String,
      email: data['email'] as String,
    );
  }
}

class UserListScreen extends StatelessWidget {
  Future<List<PigeonUserDetails>> getUsers() async {
    final snapshot = await FirebaseFirestore.instance.collection('users').get();
    
    return snapshot.docs.map((doc) {
      return PigeonUserDetails.fromMap(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body: FutureBuilder<List<PigeonUserDetails>>(
        future: getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No users found.'));
          } else {
            final users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(users[index].name),
                  subtitle: Text(users[index].email),
                );
              },
            );
          }
        },
      ),
    );
  }
}
