import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/customer.dart';
import 'auth_controller.dart';

class CustomerController extends GetxController {
  var customers = <Customer>[].obs;
  var isLoading = false.obs;
  var isMoreDataAvailable = true.obs;
  int currentPage = 1;
  final int pageSize = 20;

  final AuthController authController = Get.find<AuthController>();

  @override
  void onInit() {
    if(authController.isLoggedIn.value == true){
      fetchCustomers();
    }
    super.onInit();
  }

  Future<void> fetchCustomers({bool loadMore = false}) async {
    if (!isMoreDataAvailable.value && loadMore) return;

    isLoading.value = true;

    if (loadMore) {
      currentPage++;
    } else {
      currentPage = 1;
      customers.clear();
    }

    final url = 'https://www.pqstec.com/InvoiceApps/Values/GetCustomerList?searchquery=&pageNo=$currentPage&pageSize=$pageSize&SortyBy=Balance';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': authController.token.value,
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> customerList = data['CustomerList'] ?? [];

      if (customerList.isNotEmpty) {
        customers.addAll(customerList.map((jsonItem) => Customer.fromJson(jsonItem)).toList());
        isMoreDataAvailable.value = customerList.length == pageSize;
      } else {
        isMoreDataAvailable.value = false;
      }
    } else {
      Get.snackbar('Error', 'Failed to fetch customers');
    }

    isLoading.value = false;
  }
}
