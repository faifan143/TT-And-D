import 'package:driver/core/constants/appTheme.dart';
import 'package:driver/core/services/sharedPreferences.dart';
import 'package:driver/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initialServices();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Driver-السائق',
      debugShowCheckedModeBanner: false,
      theme: arabicTheme,
      getPages: pages,
    );
  }
}
