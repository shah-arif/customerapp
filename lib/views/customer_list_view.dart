import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../controllers/auth_controller.dart';
import '../controllers/customer_controller.dart';
import 'customer_details_view.dart';

class CustomerListView extends StatelessWidget {
  final CustomerController customerController = Get.find<CustomerController>();
  final AuthController authController = Get.find<AuthController>();

   CustomerListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          'Customer List',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              authController.logout(context);
            },
          ),
        ],
      ),
      body: Obx(() {
        if (customerController.isLoading.value && customerController.customers.isEmpty) {
          return _buildShimmerLoading();
        } else if (customerController.customers.isEmpty) {
          return Center(
            child: Text(
              'No customers found',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          );
        } else {
          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
                  customerController.isMoreDataAvailable.value &&
                  !customerController.isLoading.value) {
                customerController.fetchCustomers(loadMore: true);
              }
              return true;
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: customerController.customers.length + 1,
              itemBuilder: (context, index) {
                if (index == customerController.customers.length) {
                  return customerController.isMoreDataAvailable.value
                      ? const Center(child: CircularProgressIndicator())
                      : const SizedBox.shrink();
                }
                final customer = customerController.customers[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: customer.imageUrl == null
                        ? const Icon(Icons.person, size: 40, color: Colors.blueAccent)
                        : ClipOval(
                      child: Image.network(
                        'https://www.pqstec.com/InvoiceApps/${customer.imageUrl}',
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      customer.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      'Balance: \$${customer.balance.toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.black54),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, color: Colors.blueAccent, size: 16),
                    onTap: () {
                      Get.to(() => CustomerDetailsView(customer: customer));
                    },
                  ),
                );
              },
            ),
          );
        }
      }),
    );
  }

  Widget _buildShimmerLoading() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.circle,
                ),
              ),
              title: Container(
                width: double.infinity,
                height: 10,
                color: Colors.grey[300],
              ),
              subtitle: Container(
                width: 150,
                height: 10,
                color: Colors.grey[300],
              ),
            ),
          ),
        );
      },
    );
  }
}
