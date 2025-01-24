import 'package:rest_api/model/user_dob.dart';
import 'package:rest_api/model/user_location.dart';
import 'package:rest_api/model/user_name.dart';
import 'package:rest_api/model/user_phone.dart';
import 'package:rest_api/model/user_picture.dart';

class User {
  final dynamic picture;
  final UserName name;
  final String gender;
  final String email;
  final String phone;
  final dynamic location;
  final String nat;

  User({
    required this.picture,
    required this.name,
    required this.gender,
    required this.email,
    required this.phone,
    required this.location,
    required this.nat,
  });

  factory User.fromMap(Map<String, dynamic> json) {
    return User(
      picture: json['picture'],
      name: UserName(
        title: json['name']['title'],
        first: json['name']['first'],
        last: json['name']['last'],
      ),
      gender: json['gender'],
      email: json['email'],
      phone: json['phone'],
      location: json['location'],
      nat: json['nat'],
    );
  }
}
