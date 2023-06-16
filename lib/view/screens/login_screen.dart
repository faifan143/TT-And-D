import 'package:driver/controllers/login_controller.dart';
import 'package:driver/core/constants/appTheme.dart';
import 'package:driver/core/functions/validator.dart';
import 'package:driver/view/widgets/reusable_button.dart';
import 'package:driver/view/widgets/reusable_form_field.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/gradientBackground.jpg', // replace with your image path
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          GetBuilder<LoginController>(builder: (controller) {
            return ModalProgressHUD(
              inAsyncCall: controller.loading,
              child: Form(
                key: controller.formState,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          ListTile(
                            title: Text("تسجيل دخول",
                                textDirection: TextDirection.rtl,
                                style: arabicTheme.textTheme.headline1),
                            subtitle: Text("سجل دخولك الآن و استفد من خدماتنا",
                                textDirection: TextDirection.rtl,
                                style: arabicTheme.textTheme.headline2),
                          ),
                          const SizedBox(height: 100),
                          ReusableFormField(
                            checkValidate: (value) {
                              return validator(
                                  controller.phoneNumberController.text,
                                  10,
                                  10,
                                  "phone");
                            },
                            isPassword: false,
                            label: "رقم الهاتف",
                            controller: controller.phoneNumberController,
                            hint: "أدخل رقم الهاتف",
                            keyType: TextInputType.phone,
                            icon: const Icon(Icons.phone_enabled_outlined),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          DropdownButtonFormField2(
                            decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 3),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            isExpanded: true,
                            hint: const Text(
                              "اسم الشركة",
                              style: TextStyle(fontSize: 14),
                            ),
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black45,
                            ),
                            iconSize: 30,
                            buttonHeight: 60,
                            buttonPadding:
                                const EdgeInsets.only(left: 20, right: 10),
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            items: controller.availableCompanies
                                .map((String item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            validator: (value) {
                              if (value == null) {
                                return "الرجاء ادخال اسم الشركة";
                              }
                            },
                            onChanged: (value) async {
                              //Do something when changing the item if you want.
                              controller.selectedCompany = value!;
                            },
                            onSaved: (value) async {
                              controller.selectedCompany = value!;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ReusableFormField(
                            checkValidate: (value) {
                              return validator(
                                  controller.tripNumberController.text,
                                  1,
                                  9999,
                                  "number");
                            },
                            isPassword: false,
                            label: "رقم الرحلة",
                            controller: controller.tripNumberController,
                            hint: "أدخل رقم الرحلة",
                            keyType: TextInputType.number,
                            icon: const Icon(Icons.trip_origin_outlined),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          DropdownButtonFormField2(
                            decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 3),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            isExpanded: true,
                            hint: const Text(
                              "رقم المركبة",
                              style: TextStyle(fontSize: 14),
                            ),
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black45,
                            ),
                            iconSize: 30,
                            buttonHeight: 60,
                            buttonPadding:
                                const EdgeInsets.only(left: 20, right: 10),
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            items: controller.availableBuses
                                .map((String item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            validator: (value) {
                              if (value == null) {
                                return "الرجاء ادخال رقم المركبة";
                              }
                            },
                            onChanged: (value) async {
                              //Do something when changing the item if you want.
                              controller.selectedBus = value!;
                            },
                            onSaved: (value) async {
                              controller.selectedBus = value!;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ReUsableButton(
                            text: "تسجيل الدخول",
                            height: 10,
                            radius: 10,
                            onPressed: () async {
                              if (controller.formState.currentState!
                                  .validate()) {
                                controller.handleLoginButtonPressed(context);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
