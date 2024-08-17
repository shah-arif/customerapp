import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'controllers/auth_controller.dart';
import 'controllers/customer_controller.dart';
import 'views/login_view.dart';
import 'views/customer_list_view.dart';

void main() async {
  await GetStorage.init();
  Get.put(AuthController());
  Get.put(CustomerController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Customer App',
      home: Obx(() {
        return authController.isLoggedIn.value ? CustomerListView() : LoginView();
      }),
    );
  }
}
