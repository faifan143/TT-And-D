import 'package:driver/core/classes/bus_type.dart';

String enumToString(BusType busType) {
  return busType.toString().split('.').last;
}

BusType stringToEnum(String value) {
  return BusType.values
      .firstWhere((e) => e.toString().split('.').last == value);
}

String stringToArabic(String value) {
  switch (value) {
    case 'normal':
      return 'عادي';
    case 'vip':
      return 'ممتاز';
    case 'mini':
      return 'ميني';
    default:
      return '';
  }
}
