import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:quizzie/api-service/api_service.dart';
import 'package:quizzie/features/home/screens/home_page_screen.dart';

class LoginController extends GetxController {
  final loginFormKey = GlobalKey<FormBuilderState>();
  final registerFormKey = GlobalKey<FormBuilderState>();
  final RxList _tabs = ['Login', 'Register'].obs;
  var formData = <String, dynamic>{}.obs;

  //getter
  List get tabs => _tabs;

  void updateFormData(String key, dynamic value) {
    formData[key] = value;
  }

  Future<void> loginUser() async {
    RESTExecutor(
      domain: 'users',
      label: 'login',
      method: 'POST',
      successCallback: (res) {
        print('Raw login response: $res');
        final token = res['token'];

        var box = Hive.box('authBox');
        box.put('token', token);
        print("TOKEN SAVED: $token");

        // Set token in RESTExecutor for future requests
        RESTExecutor.setToken(token.toString());

        print('Successfully logged in: ${res['message']}');
        // Get.snackbar('Success', res['message'],
            // backgroundColor: Colors.green, colorText: Colors.white);
        Get.offAll(() => HomePageScreen());
      },
      errorCallback: (err) {
        // print('Error: ${err['message']}');
        // Get.snackbar('Error', err['message'],
        //     backgroundColor: Colors.red, colorText: Colors.white);
      },
    ).execute(
        data: {'email': formData['email'], 'password': formData['password']});
  }

  Future<void> registerUser() async {
    RESTExecutor(
        domain: 'users',
        label: 'register',
        method: 'POST',
        successCallback: (res) {
          print('Success: ${res['message']}');
          Get.snackbar('Success', res['message'],
              backgroundColor: Colors.green, colorText: Colors.white);
          formData.clear();
        },
        errorCallback: (err) {
          print('Error: ${err['message']}');
          Get.snackbar('Error', err['message'],
              backgroundColor: Colors.red, colorText: Colors.white);
        }).execute(data: {
      'name': formData['name'],
      'email': formData['email'],
      'password': formData['password']
    });
  }
}
