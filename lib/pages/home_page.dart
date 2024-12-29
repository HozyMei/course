import 'package:course/pages/show_applications_page.dart';
import 'package:flutter/material.dart';
import 'package:course/models/room.dart';
import 'package:course/models/building.dart';
import 'application_page.dart';
import 'building_detail_page.dart'; 


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Building>> futureBuildings;
  late Future<List<Room>> futureRooms;
  int _selectedIndex = 0; // Индекс выбранной страницы

  @override
  void initState() {
    super.initState();
    futureBuildings = Building.parseBuildings("assets/data_base/buildings.json");
    futureRooms = Room.parseRooms("assets/data_base/rooms.json");
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Обновляем выбранный индекс
    });

    // Переход на соответствующую страницу при нажатии на элемент
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ApplicationPage()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ShowApplicationsPage()), // Переход на страницу заявок
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buildings'),
      ),
      body: FutureBuilder<List<Building>>(
        future: futureBuildings,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No buildings found.'));
          }

          final buildings = snapshot.data!;

          return FutureBuilder<List<Room>>(
            future: futureRooms,
            builder: (context, roomSnapshot) {
              if (roomSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (roomSnapshot.hasError) {
                return Center(child: Text('Error: ${roomSnapshot.error}'));
              } else if (!roomSnapshot.hasData || roomSnapshot.data!.isEmpty) {
                return const Center(child: Text('No rooms found.'));
              }

              final rooms = roomSnapshot.data!;

              return ListView.builder(
                itemCount: buildings.length,
                itemBuilder: (context, index) {
                  final building = buildings[index];

                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(building.adress),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Area: ${building.area}'),
                          Text('Floors: ${building.floor}'),
                          Text('Rooms: ${building.roomsNumber}'),
                          Text('Phone: ${building.phoneNumber}'),
                        ],
                      ),
                      onTap: () {
                        // Переход на страницу деталей здания
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BuildingDetailPage(
                              building: building,
                              rooms: rooms,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Основная страница',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Регистрация',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Заявки', // Новый элемент для заявок
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
