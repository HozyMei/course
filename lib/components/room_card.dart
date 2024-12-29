import 'package:course/components/application_service.dart';
import 'package:course/models/aplication.dart';
import 'package:flutter/material.dart';
import 'package:course/models/room.dart';
import 'package:course/models/building.dart';
import 'package:course/components/phone_number_validator.dart';


class RoomCard extends StatelessWidget {
  final Room room;
  final Building building;

  const RoomCard({Key? key, required this.room, required this.building}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text('Room Number: ${room.roomNumber}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Square: ${room.square} m²'),
            Text('Floor: ${room.floorNumber}'),
            Text('Type of Finish: ${room.typeOfFinish}'),
            Text('Phone: ${room.phone ? "Yes" : "No"}'),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: () {
            TextEditingController phoneController = TextEditingController();

            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Заявка на комнату ${room.roomNumber}'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Введите номер телефона для оформления заявки:'),
                      TextField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          labelText: 'Номер телефона',
                          hintText: 'Введите номер телефона',
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Отмена'),
                    ),
                    TextButton(
                      onPressed: () async {
                        String phoneNumber = phoneController.text;
                        PhoneNumberValidator validator = PhoneNumberValidator();

                        if (phoneNumber.isNotEmpty) {
                          bool isValid = await validator.isPhoneNumberValid(phoneNumber);
                          if (isValid) {
                            Application application = Application(
                              area: building.area,
                              address: building.adress,
                              floor: building.floor,
                              roomsNumber: building.roomsNumber,
                              phoneNumber: phoneNumber,
                              roomIds: building.roomIds,
                              id: room.id,
                              roomNumber: room.roomNumber,
                              square: room.square,
                              floorNumber: room.floorNumber,
                              typeOfFinish: room.typeOfFinish,
                              phone: room.phone,
                              customerNumber: phoneNumber,
                            );

                            // Сохраняем заявку
                            await ApplicationService().saveApplication(application);

                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Заявка на комнату ${room.roomNumber} оформлена!')),
                            );

                            print('Заявка создана: ${application.phoneNumber}, ${application.roomNumber}, ${application.address}');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Номер телефона не найден.')),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Пожалуйста, введите номер телефона.')),
                          );
                        }
                      },
                      child: Text('Оформить'),
                    ),
                  ],
                );
              },
            );
          },
          child: Text('Оформить заявку'),
        ),
      ),
    );
  }
}
