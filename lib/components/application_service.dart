import 'dart:io';
import 'dart:convert';
import 'package:course/models/aplication.dart';


class ApplicationService {
  Future<void> saveApplication(Application application) async {
    final file = File('assets/data_base/application.json');

    List<Application> applications = [];
    if (await file.exists()) {
      String contents = await file.readAsString();
      if (contents.isNotEmpty) {
        try {
          List<dynamic> jsonList = jsonDecode(contents);
          applications = jsonList.map((json) => Application.fromJson(json)).toList();
        } catch (e) {
          print("Ошибка при декодировании JSON: $e");
        }
      }
    }

    applications.add(application);

    String jsonString = jsonEncode(applications.map((app) => app.toJson()).toList());
    await file.writeAsString(jsonString);
  }
  
}
