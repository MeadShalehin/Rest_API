import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api/model/user.dart';
import 'package:rest_api/model/user_name.dart';
import 'package:rest_api/services/user_api.dart';
import 'package:rest_api/model/user_phone.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> users = [];

  Future<void> fetchUsers() async {
    try {
      final userApi = UserApi(); // Instantiate UserApi
      final fetchedUsers =
      await userApi.fetchUsers(); // Fetch users using UserApi
      setState(() {
        users = fetchedUsers;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch users: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text("Rest API Call")),
      ),
      body: users.isEmpty
          ? const Center(
          child: Text("No data available. Tap the button to load users."))
          : ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          final picture =
          user.picture['large']; // Changed: Access picture properly
          final fullName =
              '${user.name.title} ${user.name.first} ${user.name.last}'; // Changed: Use user.name fields
          final color = user.gender == 'female'
              ? Colors.deepOrange
              : Colors.pinkAccent;
          final email = user.email;
          final phone = user.phone;
          final location =
              '${user.location['city']}, ${user.location['country']}'; // Changed: Access location as map
          final nat = user.nat;

          return ListTile(
            leading: CircleAvatar(
              backgroundImage:
              NetworkImage(picture), // Changed: Use profile picture
            ),
            title: Text(
              fullName,
              style: TextStyle(color: color),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Email: $email'), // Added: Display email
                Text('Phone: $phone'), // Added: Display phone
                Text('Location: $location'), // Added: Display location
              ],
            ),
            isThreeLine: true, // Changed: Enable multi-line subtitle
          );
        },
      ),



      floatingActionButton: FloatingActionButton(
        onPressed: fetchUsers,
        child: const Icon(Icons.download),
      ),


    );
  }
}

// Changes in UserApi
class UserApi {
  Future<List<User>> fetchUsers() async {
    const url = 'https://randomuser.me/api/?results=20';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final body = response.body;
      final json = jsonDecode(body);
      final results = json['results'] as List<dynamic>;
      final users = results.map((e) {
        return User(
          picture: e['picture'], // No change
          name: UserName(
            title: e['name']['title'], // Changed: Parse UserName correctly
            first: e['name']['first'], // Changed: Parse UserName correctly
            last: e['name']['last'], // Changed: Parse UserName correctly
          ),
          gender: e['gender'],
          email: e['email'],
          phone: e['phone'],
          location: e['location'], // No change (assume it's parsed as a Map)
          nat: e['nat'],
        );
      }).toList();
      return users;
    } else {
      throw Exception('Failed to load users');
    }
  }
}