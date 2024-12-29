class Application {
  final String area;
  final String address;
  final int floor;
  final int roomsNumber;
  final String phoneNumber;
  final List<int> roomIds;
  final int id;
  final int roomNumber;
  final double square;
  final int floorNumber;
  final String typeOfFinish;
  final bool phone;
  final String customerNumber;

  Application({
    required this.area,
    required this.address, 
    required this.floor, 
    required this.roomsNumber, 
    required this.phoneNumber, 
    required this.roomIds, 
    required this.id, 
    required this.roomNumber, 
    required this.square, 
    required this.floorNumber, 
    required this.typeOfFinish, 
    required this.phone,
    required this.customerNumber
    });
   // Метод для сериализации в JSON
  Map<String, dynamic> toJson() {
    return {
      'area': area,
      'address': address,
      'floor': floor,
      'roomsNumber': roomsNumber,
      'phoneNumber': phoneNumber,
      'roomIds': roomIds,
      'id': id,
      'roomNumber': roomNumber,
      'square': square,
      'floorNumber': floorNumber,
      'typeOfFinish': typeOfFinish,
      'phone': phone,
      'customerNumber': customerNumber,
    };
  }

  // Метод для десериализации из JSON
  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      area: json['area'],
      address: json['address'],
      floor: json['floor'],
      roomsNumber: json['roomsNumber'],
      phoneNumber: json['phoneNumber'],
      roomIds: List<int>.from(json['roomIds']),
      id: json['id'],
      roomNumber: json['roomNumber'],
      square: json['square'],
      floorNumber: json['floorNumber'],
      typeOfFinish: json['typeOfFinish'],
      phone: json['phone'],
      customerNumber: json['customerNumber'],
    );
  }
} 
