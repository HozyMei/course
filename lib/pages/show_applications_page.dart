import 'dart:convert';

import 'package:course/models/aplication.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class ShowApplicationsPage extends StatelessWidget {
  const ShowApplicationsPage({super.key});
  Future<List<Application>> loadApplications() async {
  // Чтение содержимого файла JSON
  final String response = await rootBundle.loadString('assets/data_base/application.json');
  final List<dynamic> jsonList = json.decode(response);
  return jsonList.map((json) => Application.fromJson(json)).toList();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Заявки'),
      ),
      body: FutureBuilder<List<Application>>(
        future: loadApplications(), // Вызов асинхронного метода
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Нет доступных заявок.'));
          }

          final applications = snapshot.data!;

          return ListView.builder(
            itemCount: applications.length,
            itemBuilder: (context, index) {
              final application = applications[index];

              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(application.address),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Area: ${application.area}'),
                      Text('Floor: ${application.floor}'),
                      Text('Rooms: ${application.roomsNumber}'),
                      Text("Customer's Phone: ${application.phoneNumber}"),
                      Text('Type of Finish: ${application.typeOfFinish}'),
                    ],
                  ),
                  onTap: () {
                    // Здесь можно добавить логику для обработки нажатия на карточку
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
