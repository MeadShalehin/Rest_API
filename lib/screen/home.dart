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
        title: const Text("Rest API Call"),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          final picture = user.picture;
          final fullName =
              '${user.name.title} ${user.name.first} ${user.name.last}';
          final color =
              user.gender == 'female' ? Colors.deepOrange : Colors.pinkAccent;
          final email = user.email;
          final phone = user.phone;
          final location = user.location;
          final nat = user.nat;

          return ListTile(
            title: Text(
              fullName,
              style: TextStyle(color: color),
            ),
            subtitle:
                Text(fullName), // Display the user's full name as a subtitle
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

// Move UserApi to a standalone class
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
          picture: e['picture'],
          name: e['name'],
          gender: e['gender'],
          email: e['email'],
          phone: e['phone'],
          //cell: e['cell'],
          //dob: e['dob'],
          location: e['location'],
          nat: e['nat'],
        );
      }).toList();
      return users;
    } else {
      throw Exception('Failed to load users');
    }
  }
}
