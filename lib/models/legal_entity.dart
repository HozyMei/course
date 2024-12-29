import 'dart:convert';

import 'package:flutter/services.dart';

class LegalEntity {
  final String title;
  final String name;
  final String adress;
  final String phoneNumber;
  final String bank;
  final int paymentAccount;
  final String inn;

  LegalEntity({
    required this.title,
    required this.name,
    required this.adress,
    required this.phoneNumber,
    required this.bank,
    required this.paymentAccount,
    required this.inn
  });

  factory LegalEntity.fromJson(Map<String, dynamic> json) {
    return LegalEntity(
      title: json['title'],
      name: json['name'],
      adress: json['adress'],
      phoneNumber: json['phoneNumber'],
      bank: json['bank'],
      paymentAccount: json['paymentAccount'],
      inn:json['inn'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'name': name,
      'adress': adress,
      'phoneNumber': phoneNumber,
      'bank': bank,
      'paymentAccount': paymentAccount,
       'inn': inn
    };
  }

  static Future<List<LegalEntity>> parseBuildings(String path) async {
    final String response = await rootBundle.loadString(path);
    final List<dynamic> data = json.decode(response);
    return data.map((json) => LegalEntity.fromJson(json)).toList();
  }
}