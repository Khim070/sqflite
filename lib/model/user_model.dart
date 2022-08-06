//import 'package:flutter/material.dart';

class User {
  int id;
  String name;
  User({required this.id, required this.name});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  User.FromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"];
}
