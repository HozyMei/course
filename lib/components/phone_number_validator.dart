
import 'package:course/models/legal_entity.dart';
import 'package:course/models/natural_person.dart';


class PhoneNumberValidator {
  Future<bool> isPhoneNumberValid(String phoneNumber) async {
  try {
    // Загрузка данных о юридических лицах
    List<LegalEntity> legalEntities = await LegalEntity.parseBuildings('assets/data_base/legal_entity.json');
    
    // Загрузка данных о физических лицах
    List<NaturalPerson> naturalPersons = await NaturalPerson.parseBuildings('assets/data_base/natural_person.json');

    // Проверяем номер телефона среди юридических лиц
    for (var entity in legalEntities) {
      if (entity.phoneNumber == phoneNumber) {
        return true;
      }
    }

    // Проверяем номер телефона среди физических лиц
    for (var person in naturalPersons) {
      if (person.phoneNumber == phoneNumber) {
        return true;
      }
    }

    return false; // Номер не найден
  } catch (e) {
    print("Ошибка при проверке номера телефона: $e");
    return false; // Возвращаем false в случае ошибки
  }
}
}
