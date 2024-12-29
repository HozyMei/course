import 'dart:convert';
import 'dart:io';
import 'package:course/models/natural_person.dart';
import 'package:flutter/material.dart';

class NaturalPersonForm extends StatefulWidget {
  const NaturalPersonForm({Key? key}) : super(key: key);

  @override
  _NaturalPersonFormState createState() => _NaturalPersonFormState();
}

class _NaturalPersonFormState extends State<NaturalPersonForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passportNumberController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _issuedController = TextEditingController();

  Future<void> _saveNaturalPerson() async {
    if (_formKey.currentState!.validate()) {
      final person = NaturalPerson(
        name: _nameController.text,
        phoneNumber: _phoneNumberController.text,
        passportNumber: _passportNumberController.text,
        date: _dateController.text,
        issued: _issuedController.text,
      );

      final jsonString = jsonEncode(person.toJson());
      
      final file = File('assets/data_base/natural_person.json');

      await file.writeAsString(jsonString);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Данные физического лица сохранены в ${file.path}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Имя'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Пожалуйста, введите имя';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _phoneNumberController,
              decoration: const InputDecoration(labelText: 'Номер телефона'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Пожалуйста, введите номер телефона';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passportNumberController,
              decoration: const InputDecoration(labelText: 'Номер паспорта'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Пожалуйста, введите номер паспорта';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _dateController,
              decoration: const InputDecoration(labelText: 'Дата выдачи'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Пожалуйста, введите дату';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _issuedController,
              decoration: const InputDecoration(labelText: 'Кем выдан'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Пожалуйста, введите, кем выдан';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveNaturalPerson,
              child: const Text('Сохранить'),
            ),
          ],
        ),
      ),
    );
  }
}
