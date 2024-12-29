import 'dart:convert';
import 'dart:io';
import 'package:course/models/legal_entity.dart';
import 'package:flutter/material.dart';

class LegalEntityForm extends StatefulWidget {
  const LegalEntityForm({Key? key}) : super(key: key);

  @override
  _LegalEntityFormState createState() => _LegalEntityFormState();
}

class _LegalEntityFormState extends State<LegalEntityForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _legalNameController = TextEditingController();
  final TextEditingController _adressController = TextEditingController();
  final TextEditingController _legalPhoneNumberController = TextEditingController();
  final TextEditingController _bankController = TextEditingController();
  final TextEditingController _paymentAccountController = TextEditingController();
  final TextEditingController _innController = TextEditingController();

  Future<void> _saveLegalEntity() async {
    if (_formKey.currentState!.validate()) {
      final entity = LegalEntity(
        title: _titleController.text,
        name: _legalNameController.text,
        adress: _adressController.text,
        phoneNumber: _legalPhoneNumberController.text,
        bank: _bankController.text,
        paymentAccount: int.parse(_paymentAccountController.text),
        inn: _innController.text,
      );

      final jsonString = jsonEncode(entity.toJson());
      
      final file = File('assets/data_base/legal_entity.json');

      await file.writeAsString(jsonString);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Данные юридического лица сохранены в ${file.path}')),
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
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Название'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Пожалуйста, введите название';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _legalNameController,
              decoration: const InputDecoration(labelText: 'Имя'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Пожалуйста, введите имя';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _adressController,
              decoration: const InputDecoration(labelText: 'Адрес'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Пожалуйста, введите адрес';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _legalPhoneNumberController,
              decoration: const InputDecoration(labelText: 'Номер телефона'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Пожалуйста, введите номер телефона';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _bankController,
              decoration: const InputDecoration(labelText: 'Банк'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Пожалуйста, введите банк';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _paymentAccountController,
              decoration: const InputDecoration(labelText: 'Расчетный счет'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Пожалуйста, введите расчетный счет';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _innController,
              decoration: const InputDecoration(labelText: 'ИНН'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Пожалуйста, введите ИНН';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveLegalEntity,
              child: const Text('Сохранить'),
            ),
          ],
        ),
      ),
    );
  }
}
