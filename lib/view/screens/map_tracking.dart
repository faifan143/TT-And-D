import 'package:driver/controllers/main_screen_controller.dart';
import 'package:driver/core/constants/AppColors.dart';
import 'package:driver/core/constants/appTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MapTracking extends StatelessWidget {
  const MapTracking({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    Get.put(MainScreenController());
    return GetBuilder<MainScreenController>(builder: (controller) {
      return ModalProgressHUD(
        inAsyncCall: controller.isLoading,
        child: Scaffold(
          body: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(controller.currentLocation.latitude!,
                      controller.currentLocation.longitude!),
                  zoom: 13.5,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId("Bus Current Location"),
                    position: LatLng(controller.currentLocation.latitude!,
                        controller.currentLocation.longitude!),
                  ),
                },
                onMapCreated: (mapController) {
                  controller.gmapsController.complete(mapController);
                },
              ),
              Positioned(
                right: 0,
                left: 0,
                top: 0,
                child: Container(
                  height: 100,
                  color: Colors.black54,
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            if (controller.tripStarted) {
                              Alert(
                                context: context,
                                type: AlertType.warning,
                                title: "انهاء الرحلة",
                                desc:
                                    "وصلت الى الوجهة المطلوبة ؟\n في حال الوصول سيتم تسجيل الخروج \n تلقائياً من الرحلة خلال 5 ثواني",
                                buttons: [
                                  DialogButton(
                                    onPressed: () => Navigator.pop(context),
                                    gradient: const LinearGradient(colors: [
                                      Colors.pink,
                                      Colors.redAccent
                                    ]),
                                    child: const Text(
                                      "لا",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                                  DialogButton(
                                    onPressed: () {
                                      controller.updateTripStatus(
                                          context: context,
                                          finished: true,
                                          started: true);
                                    },
                                    gradient: const LinearGradient(colors: [
                                      Color.fromRGBO(0, 179, 134, 1.0),
                                      Colors.greenAccent,
                                    ]),
                                    child: const Text(
                                      "نعم",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                                ],
                              ).show();
                            }
                          },
                          style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(AppColors.buttonColor),
                          ),
                          child: Text(
                            "انهاء الرحلة",
                            style: arabicTheme.textTheme.headline2!
                                .copyWith(height: 5),
                          ),
                        ),
                      ),
                      Container(
                        width: 2,
                        height: 0,
                        color: Colors.white,
                      ),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () =>
                              controller.displayTextInputDialog(context),
                          style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(AppColors.buttonColor),
                          ),
                          child: Text(
                            "مشكلة",
                            style: arabicTheme.textTheme.headline2!
                                .copyWith(height: 5),
                          ),
                        ),
                      ),
                      Container(
                        width: 2,
                        height: 0,
                        color: Colors.white,
                      ),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            if (!controller.tripStarted) {
                              Alert(
                                context: context,
                                type: AlertType.warning,
                                title: "البدء",
                                desc: "هل تريد بدء الرحلة ؟",
                                buttons: [
                                  DialogButton(
                                    onPressed: () => Navigator.pop(context),
                                    gradient: const LinearGradient(colors: [
                                      Colors.pink,
                                      Colors.redAccent
                                    ]),
                                    child: const Text(
                                      "لا",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                                  DialogButton(
                                    onPressed: () {
                                      controller.tripStarted = true;
                                      controller.updateTripStatus(
                                          context: context,
                                          finished: false,
                                          started: true);
                                    },
                                    gradient: const LinearGradient(colors: [
                                      Color.fromRGBO(0, 179, 134, 1.0),
                                      Colors.greenAccent,
                                    ]),
                                    child: const Text(
                                      "نعم",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                                ],
                              ).show();
                            }
                          },
                          style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(AppColors.buttonColor),
                          ),
                          child: Text(
                            "بدأ الرحلة",
                            style: arabicTheme.textTheme.headline2!
                                .copyWith(height: 5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
