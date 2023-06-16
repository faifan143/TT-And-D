import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver/core/constants/AppRoutes.dart';
import 'package:driver/core/functions/show_snackbar.dart';
import 'package:driver/core/services/sharedPreferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  bool loading = false;
  bool isPassword = true;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late TextEditingController phoneNumberController;
  late TextEditingController tripNumberController;
  changePassState() {
    isPassword = !isPassword;
    update();
  }

  changeLoadingState() {
    loading = !loading;
    update();
  }

  MyServices myServices = Get.find();
  Future<void> loginDriver(
      {required String phone,
      required String companyName,
      required String busNumber,
      required String tripNumber,
      required BuildContext context}) async {
    // Access the Firestore instance
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Create a document reference with the user's phone number as the document ID
    final Query<Map<String, dynamic>> driverDocRef = firestore
        .collection('trips')
        .where('companyName', isEqualTo: companyName)
        .where('busNumber', isEqualTo: busNumber)
        .where('tripNumber', isEqualTo: tripNumber)
        .where('driverNumber', isEqualTo: phone);

    try {
      // Check if the user document exists
      final QuerySnapshot<Map<String, dynamic>> driverDocSnapshot =
          await driverDocRef.get();

      if (driverDocSnapshot.docs.isNotEmpty) {
        // Check if the password matches

        if (!driverDocSnapshot.docs.first.get('started')) {
          print('Login successful');

          myServices.sharedPref.setString("driverNumber", phone);
          myServices.sharedPref.setString("companyName", companyName);
          myServices.sharedPref.setString("busNumber", busNumber);
          myServices.sharedPref.setString("tripNumber", tripNumber);

          changeLoadingState();

          Get.offAllNamed(AppRoutes.mainScreen);
        } else {
          showSnackBar(
            context: context,
            contentType: ContentType.failure,
            body: "تم تخديم هذه الرحلة",
            title: "خطأ !",
          );
        }
      } else {
        changeLoadingState();

        print('User not found');
        showSnackBar(
          context: context,
          contentType: ContentType.failure,
          body: "المعلومات المدخلة غير صحيحة",
          title: "خطأ !",
        );
      }
    } catch (e) {
      changeLoadingState();
      // Handle any errors that occur during the operation
      print('Error logging in: $e');
    }
  }

  void handleLoginButtonPressed(BuildContext context) async {
    changeLoadingState();
    String phoneNumber = phoneNumberController.text.trim();
    String companyName = selectedCompany;
    String busNumber = selectedBus;
    String tripNumber = tripNumberController.text.trim();
    loginDriver(
        phone: phoneNumber,
        companyName: companyName,
        busNumber: busNumber,
        tripNumber: tripNumber,
        context: context);
  }

  String selectedBus = "";
  List<String> availableBuses = [];
  Future<void> getAvailableBuses() async {
    // Access the Firestore instance
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Create a query for the 'busses' collection with the specified filters
    final Query<Map<String, dynamic>> busQuery =
        firestore.collection('busses').where('busy', isEqualTo: false);

    try {
      // Get all documents from the 'busses' collection that match the query
      final QuerySnapshot<Map<String, dynamic>> busQuerySnapshot =
          await busQuery.get();
      print(busQuerySnapshot.docs.length);
      // Map each document to a BusModel object and add it to a list
      availableBuses = busQuerySnapshot.docs.map((doc) {
        return doc.data()!['busNumber'].toString();
      }).toList();
      update();
      print(availableBuses);
    } catch (e) {
      // Handle any errors that occur during the operation
      print('Error getting all available buses: $e');
    }
  }

  String selectedCompany = "";
  List<String> availableCompanies = [];
  getCompanies() async {
    // Access the Firestore instance
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Create a query for the 'busses' collection with the specified filters
    final Query<Map<String, dynamic>> busQuery =
        firestore.collection('companies');

    try {
      // Get all documents from the 'busses' collection that match the query
      final QuerySnapshot<Map<String, dynamic>> busQuerySnapshot =
          await busQuery.get();
      print(busQuerySnapshot.docs.length);
      // Map each document to a BusModel object and add it to a list
      availableCompanies = busQuerySnapshot.docs.map((doc) {
        return doc.data()!['company-name'].toString();
      }).toList();
      update();
      print(availableCompanies);
    } catch (e) {
      // Handle any errors that occur during the operation
      print('Error getting all available buses: $e');
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    phoneNumberController = TextEditingController();
    tripNumberController = TextEditingController();
    getCompanies();
    getAvailableBuses();
  }
}
