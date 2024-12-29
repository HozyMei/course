import 'dart:convert';
import 'package:flutter/services.dart';

class Room {
  final int id;
  final int roomNumber;
  final double square;
  final int floorNumber;
  final String typeOfFinish;
  final bool phone;

  Room({
    required this.id,
    required this.roomNumber,
    required this.square,
    required this.floorNumber,
    required this.typeOfFinish,
    required this.phone,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      roomNumber: json['roomNumber'],
      square: json['square'],
      floorNumber: json['floorNumber'],
      typeOfFinish: json['typeOfFinish'],
      phone: json['phone'],
    );
  }

  static Future<List<Room>> parseRooms(String path) async {
    final String response = await rootBundle.loadString(path);
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Room.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'roomNumber': roomNumber,
      'square': square,
      'floorNumber': floorNumber,
      'typeOfFinish': typeOfFinish,
      'phone': phone,
    };
  }
}
