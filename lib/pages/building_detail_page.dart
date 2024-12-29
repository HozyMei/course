import 'package:flutter/material.dart';
import 'package:course/models/building.dart';
import 'package:course/models/room.dart';
import 'package:course/components/building_info.dart';
import 'package:course/components/room_card.dart';

class BuildingDetailPage extends StatelessWidget {
  final Building building;
  final List<Room> rooms;

  const BuildingDetailPage({Key? key, required this.building, required this.rooms}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(building.adress),
      ),
      body: Column(
        children: [
          BuildingInfo(building: building), // Используем новый виджет для информации о здании
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: building.roomIds.length,
              itemBuilder: (context, index) {
                final roomId = building.roomIds[index];
                final room = rooms.firstWhere((room) => room.id == roomId);
                return RoomCard(room: room, building: building); // Используем новый виджет для комнаты
              },
            ),
          ),
        ],
      ),
    );
  }
}
