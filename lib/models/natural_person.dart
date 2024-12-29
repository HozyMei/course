import 'dart:convert';

import 'package:flutter/services.dart';

class NaturalPerson {
  final String name;
  final String phoneNumber;
  final String passportNumber;
  final String date;
  final String issued;

  NaturalPerson({
    required this.name,
    required this.phoneNumber,
    required this.passportNumber,
    required this.date,
    required this.issued
  });

  factory NaturalPerson.fromJson(Map<String, dynamic> json) {
    return NaturalPerson(
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      passportNumber: json['passportNumber'],
      date: json['date'],
      issued: json['issued']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'passportNumber': passportNumber,
      'date': date,
      'issued': issued
    };
  }

  static Future<List<NaturalPerson>> parseBuildings(String path) async {
    final String response = await rootBundle.loadString(path);
    final List<dynamic> data = json.decode(response);
    return data.map((json) => NaturalPerson.fromJson(json)).toList();
  }
}
