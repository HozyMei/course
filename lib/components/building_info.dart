import 'package:flutter/material.dart';
import 'package:course/models/building.dart';

class BuildingInfo extends StatelessWidget {
  final Building building;

  const BuildingInfo({Key? key, required this.building}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Area: ${building.area}', style: TextStyle(fontSize: 18)),
          Text('Floors: ${building.floor}', style: TextStyle(fontSize: 18)),
          Text('Rooms: ${building.roomsNumber}', style: TextStyle(fontSize: 18)),
          Text('Phone: ${building.phoneNumber}', style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
