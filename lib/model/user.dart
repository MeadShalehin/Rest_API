import 'package:rest_api/model/user_dob.dart';
import 'package:rest_api/model/user_location.dart';
import 'package:rest_api/model/user_name.dart';
import 'package:rest_api/model/user_phone.dart';
import 'package:rest_api/model/user_picture.dart';

class User {
  final String picture;
  final UserName name;
  final String gender;
  final String email;
  final String phone;
  //final String cell;
  //final UserDob dob;
  final UserLocation location;
  final String nat;

  User({
    required this.picture,
    required this.name,
    required this.gender,
    required this.email,
    required this.phone,
    //cell: e['cell'],
    //dob: e['dob'],
    required this.location,
    required this.nat,
  });

  factory User.fromMap(Map<String, dynamic> e) {
    final picture = UserPicture.fromMap(e['picture']);
    final name = UserName.fromMap(e['name']);
    final gender = e['gender'];
    final email = e['email'];
    final phone = UserPhone.fromMap(e['phone']);
   // final date = e['dob']['date'];
   // final dob = UserDob.fromMap(e['dob']);
    final location = UserLocation.fromMap(e['location']);
    final nat = e['nat'];


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
  }

  String get fullName {
    return '${name.title} ${name.first} ${name.last}';
  }
}
