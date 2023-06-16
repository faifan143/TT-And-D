import 'package:get/get.dart';

validator(String val, int min, int max, var type) {
  if (type == "username") {
    if (!GetUtils.isUsername(val)) {
      return "غير مقبول";
    }
  }
  if (type == "email") {
    if (!GetUtils.isEmail(val)) {
      return "غسر مقبول";
    }
  }
  if (type == "phone") {
    if (!GetUtils.isPhoneNumber(val)) {
      return "غير مقبول";
    }
  }

  if (val.isEmpty) {
    return "فارغ";
  }

  if (val.length < min) {
    return "$minلا يمكن ان يكون اصغر من ";
  }
  if (val.length > max) {
    return "$maxلا يمكن ان يكون اكبر من ";
  }
}
