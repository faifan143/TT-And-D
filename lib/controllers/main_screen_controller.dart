import 'dart:async';
import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver/core/constants/AppAssets.dart';
import 'package:driver/core/constants/AppRoutes.dart';
import 'package:driver/core/functions/show_snackbar.dart';
import 'package:driver/core/services/sharedPreferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:location/location.dart';

MyServices myService = Get.find();

class MainScreenController extends GetxController {
  MyServices myServices = Get.find();
  late TextEditingController reportController;
  String reportField = "";
  late String companyName;
  late String driverNumber;
  late String busNumber;
  late String tripNumber;
  bool tripStarted = false;
  bool tripFinished = false;
  bool isLoading = false;
  changeLoadingState() {
    isLoading = !isLoading;
    update();
  }

  LocationData currentLocation = LocationData.fromMap({
    "latitude": 36.16571412472137,
    "longitude": 37.1262037238395,
  });
  Completer<GoogleMapController> gmapsController = Completer();
  void getCurrentLocation() async {
    Location location = Location();
    location.changeSettings(accuracy: LocationAccuracy.high);
    location.getLocation().then((location) => currentLocation = location);
    print(currentLocation);

    final Query<Map<String, dynamic>> tripDocRef = FirebaseFirestore.instance
        .collection('trips')
        .where('busNumber', isEqualTo: busNumber)
        .where('driverNumber', isEqualTo: driverNumber)
        .where('companyName', isEqualTo: companyName)
        .where('tripNumber', isEqualTo: tripNumber);

    try {
      QuerySnapshot<Map<String, dynamic>> tripSnapshot = await tripDocRef.get();
      if (tripSnapshot.docs.isNotEmpty) {
        final List<DocumentSnapshot<Map<String, dynamic>>> trips =
            await tripDocRef.get().then((querySnapshot) => querySnapshot.docs);
        for (final trip in trips) {
          final tripDocRef = trip.reference;
          await tripDocRef.update({'locationData': '$currentLocation'});
        }
      } else {}
    } catch (e) {
      print("Catch Error : $e");
    }

    GoogleMapController googleMapController = await gmapsController.future;
    location.onLocationChanged.listen((newLoc) {
      currentLocation = newLoc;
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(newLoc.latitude!, newLoc.longitude!),
            zoom: 13.5,
          ),
        ),
      );
      update();
    });
  }

  Future<void> updateTripStatus({
    required BuildContext context,
    required bool started,
    required bool finished,
  }) async {
    final Query<Map<String, dynamic>> tripDocRef = FirebaseFirestore.instance
        .collection('trips')
        .where('busNumber', isEqualTo: busNumber)
        .where('driverNumber', isEqualTo: driverNumber)
        .where('companyName', isEqualTo: companyName)
        .where('tripNumber', isEqualTo: tripNumber);

    try {
      QuerySnapshot<Map<String, dynamic>> tripSnapshot = await tripDocRef.get();
      if (tripSnapshot.docs.isNotEmpty) {
        final List<DocumentSnapshot<Map<String, dynamic>>> trips =
            await tripDocRef.get().then((querySnapshot) => querySnapshot.docs);
        for (final trip in trips) {
          final tripDocRef = trip.reference;
          await tripDocRef.update({
            'started': started,
            'finished': finished,
          });
        }

        finished
            ? ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("تم انهاء الرحلة")))
            : ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("تم بدء الرحلة")));

        if (finished) {
          updateBusStatus(busNumber, false);
          Navigator.pop(context);
          tripFinished = true;
          await Future.delayed(const Duration(seconds: 5));
          myServices.sharedPref.setString("logged", "0");
          Get.offAllNamed(AppRoutes.login);
        } else if (started) {
          updateBusStatus(busNumber, true);
          Navigator.pop(context);
        }
      } else {
        showSnackBar(
            context: context,
            contentType: ContentType.failure,
            title: "فشل",
            body: finished ? "فشل انهاء الرحلة" : "فشل بدأ الرحلة");
      }
    } catch (e) {
      print("Catch Error : $e");
    }
  }

  Future<void> updateBusStatus(String busNumber, bool isBusy) async {
    await FirebaseFirestore.instance
        .collection('busses')
        .doc(busNumber)
        .update({'busy': isBusy});
  }

  Future<void> sendNotification(BuildContext context) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm:ss').format(now);
    await http
        .post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=${AppImgAsset.fcmServerKey}',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': "خطر",
            'title': "حدثت مشكلة"
          },
          'priority': 'high',
          'data': {
            "alertTime": formattedDate,
            "location": currentLocation.toString(),
            "tripNumber": tripNumber,
            "busNumber": busNumber,
            "driverNumber": driverNumber,
            "report-content": reportField,
          },
          'to': "/topics/$companyName",
        },
      ),
    )
        .then((value) async {
      print(value.statusCode);
      print("=========done=========");
      if (value.statusCode == 200) {
      } else {
        print("=========false=========");
      }
    }).catchError((onError) {
      print(onError);
    });
    changeLoadingState();
    reportController.clear();
  }

  Future<void> displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('هل تريد ارسال اشعار الى المركز ؟'),
            content: TextField(
              onChanged: (value) {
                reportField = value;
              },
              controller: reportController,
              decoration:
                  const InputDecoration(hintText: "اكتب محتوى الابلاغ هنا"),
            ),
            actions: <Widget>[
              MaterialButton(
                onPressed: () => Navigator.pop(context),
                color: Colors.redAccent,
                child: const Text(
                  "لا",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                  changeLoadingState();
                  sendNotification(context);
                },
                color: Colors.green,
                child: const Text(
                  "نعم",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          );
        });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    myServices.sharedPref.setString("logged", "1");
    companyName = myServices.sharedPref.getString("companyName").toString();
    driverNumber = myServices.sharedPref.getString("driverNumber").toString();
    busNumber = myServices.sharedPref.getString("busNumber").toString();
    tripNumber = myServices.sharedPref.getString("tripNumber").toString();
    reportController = TextEditingController();
    getCurrentLocation();
  }
}
