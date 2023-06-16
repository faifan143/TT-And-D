import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyServices extends GetxService {
  late SharedPreferences sharedPref;

  // Initialize the shared preferences instance
  Future<MyServices> init() async {
    sharedPref = await SharedPreferences.getInstance();
    return this;
  }
}

// Initialize the MyServices instance and add it to GetX
initialServices() async {
  await Get.putAsync(() => MyServices().init());
}
