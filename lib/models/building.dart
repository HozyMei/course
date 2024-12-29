import 'dart:convert';

import 'package:flutter/services.dart';

class Building {
  final String area;
  final String adress;
  final int floor;
  final int roomsNumber;
  final String phoneNumber;
  final List<int> roomIds; 

  Building({
    required this.area,
    required this.adress,
    required this.floor,
    required this.roomsNumber,
    required this.phoneNumber,
    required this.roomIds, 
  });

  factory Building.fromJson(Map<String, dynamic> json) {
    return Building(
      area: json['area'],
      adress: json['adress'],
      floor: json['floor'],
      roomsNumber: json['roomsNumber'],
      phoneNumber: json['phoneNumber'],
      roomIds: List<int>.from(json['room']), 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'area': area,
      'adress': adress,
      'floor': floor,
      'roomsNumber': roomsNumber,
      'phoneNumber': phoneNumber,
      'room': roomIds, 
    };
  }

  static Future<List<Building>> parseBuildings(String path) async {
    final String response = await rootBundle.loadString(path);
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Building.fromJson(json)).toList();
  }
}
