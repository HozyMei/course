import 'package:course/forms/legal_entity_form.dart';
import 'package:course/forms/natural_person_form.dart';
import 'package:flutter/material.dart';

class ApplicationPage extends StatefulWidget {
  const ApplicationPage({super.key});

  @override
  State<ApplicationPage> createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Форма для ввода данных'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Физическое лицо'),
            Tab(text: 'Юридическое лицо'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          NaturalPersonForm(), // Используем новый виджет формы
          LegalEntityForm(),   // Используем новый виджет формы
        ],
      ),
    );
  }
}
