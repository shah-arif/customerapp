import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../views/customer_list_view.dart';
import '../views/login_view.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  var token = ''.obs;
  var isLoading = false.obs;
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    if (storage.read('token') != null) {
      token.value = storage.read('token');
      isLoggedIn.value = true;
    }
  }

  Future<void> login(String username, String password, int comId) async {
    isLoading.value = true;

    final url = 'https://www.pqstec.com/InvoiceApps/Values/LogIn?UserName=$username&Password=$password&ComId=$comId';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['Token'] != null) {
        token.value = data['Token'];
        storage.write('token', token.value);
        isLoggedIn.value = true;
        Get.offAll(() => CustomerListView());
      } else {
        Get.snackbar('Error', 'Invalid credentials');
      }
    } else {
      Get.snackbar('Error', 'Failed to login');
    }

    isLoading.value = false;
  }

  void logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            "Are you sure?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.blueGrey[700],
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Text(
                "Do you really want to log out?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      token.value = '';
                      isLoggedIn.value = false;
                      storage.erase();
                      Get.offAll(() => LoginView());
                    },
                    child: const Text(
                      "Yes",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text(
                      "No",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
