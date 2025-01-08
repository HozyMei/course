import 'dart:convert';
import 'dart:io';
import 'package:course/models/aplication.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShowApplicationsPage extends StatefulWidget {
  const ShowApplicationsPage({super.key});

  @override
  _ShowApplicationsPageState createState() => _ShowApplicationsPageState();
}

class _ShowApplicationsPageState extends State<ShowApplicationsPage> {
  late Future<List<Application>> applicationsFuture;
  List<bool> checkedStatus = [];

  @override
  void initState() {
    super.initState();
    applicationsFuture = loadApplications();
  }

  Future<List<Application>> loadApplications() async {
    // Чтение содержимого файла JSON
    final String response = await rootBundle.loadString('assets/data_base/application.json');
    final List<dynamic> jsonList = json.decode(response);
    return jsonList.map((json) => Application.fromJson(json)).toList();
  }

  void toggleCheck(int index) {
    setState(() {
      checkedStatus[index] = !checkedStatus[index];
    });
  }

  Future<void> saveApplications() async {
    final applications = await applicationsFuture;

    // Обновляем состояние checked для каждого приложения
    for (int i = 0; i < applications.length; i++) {
      applications[i] = applications[i].copyWith(checked: checkedStatus[i]);
    }

    // Сериализация в JSON
    final String jsonString = jsonEncode(applications.map((app) => app.toJson()).toList());
    
    // Убедитесь, что у вас есть правильный путь для записи файла
    final file = File('assets/data_base/application.json');
    await file.writeAsString(jsonString);
  }

  void saveAllApplications() async {
    await saveApplications();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Все заявки обновлены!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Заявки'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: saveAllApplications,
            tooltip: 'Сохранить все изменения',
          ),
        ],
      ),
      body: FutureBuilder<List<Application>>(
        future: applicationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Нет доступных заявок.'));
          }

          final applications = snapshot.data!;
          // Инициализация состояния для чекбоксов
          if (checkedStatus.length != applications.length) {
            checkedStatus = applications.map((app) => app.checked).toList();
          }

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
                  trailing: Checkbox(
                    value: checkedStatus[index],
                    onChanged: (value) {
                      toggleCheck(index);
                    },
                  ),
                  onTap: () {
                    // Действие при нажатии на элемент списка
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
