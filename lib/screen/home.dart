import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rest_api/model/user_name.dart';

import 'package:flutter/material.dart';
import 'package:rest_api/model/user.dart';
import 'package:rest_api/services/user_api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
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
          // final email = user.email;
          final color =
              user.gender == 'male' ? Colors.black12 : Colors.pinkAccent;
          return ListTile(
            title: Text(user.fullName),
            subtitle: Text(user.location.state),
            tileColor: color,
          );
        },
      ),
    );
  }

  Future<void> fetchUsers() async {
    final response = await UserApi.fetchUsers();
    setState(() {
      users = response;
    });
  }
}
