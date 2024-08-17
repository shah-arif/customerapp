import 'package:flutter/material.dart';
import '../models/customer.dart';

class CustomerDetailsView extends StatelessWidget {
  final Customer customer;

  CustomerDetailsView({required this.customer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Details'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 20),
            _buildSectionTitle('General Information'),
            _buildDetailCard([
              _buildDetailRow(Icons.account_circle, 'ID', customer.id?.toString() ?? 'N/A'),
              _buildDetailRow(Icons.email, 'Email', customer.email ?? 'N/A'),
              _buildDetailRow(Icons.home, 'Primary Address', customer.primaryAddress ?? 'N/A'),
              _buildDetailRow(Icons.home_work, 'Secondary Address', customer.secondaryAddress ?? 'N/A'),
              _buildDetailRow(Icons.note, 'Notes', customer.notes ?? 'N/A'),
              _buildDetailRow(Icons.phone, 'Phone', customer.phone ?? 'N/A'),
              _buildDetailRow(Icons.people, 'Customer Type', customer.custType ?? 'N/A'),
              _buildDetailRow(Icons.supervisor_account, 'Parent Customer', customer.parentCustomer ?? 'N/A'),
            ]),
            const SizedBox(height: 20),
            _buildSectionTitle('Financial Information'),
            _buildDetailCard([
              _buildDetailRow(Icons.attach_money, 'Total Balance', customer.balance?.toStringAsFixed(2) ?? 'N/A'),
              _buildDetailRow(Icons.calendar_today, 'Last Sales Date', customer.lastSalesDate == "" ? 'N/A' : customer.lastSalesDate.toString()),
              _buildDetailRow(Icons.receipt, 'Last Invoice No', customer.lastInvoiceNo == "" ? 'N/A' : customer.lastInvoiceNo.toString()),
              _buildDetailRow(Icons.shopping_cart, 'Last Sold Product', customer.lastSoldProduct == "" ? 'N/A' : customer.lastSoldProduct.toString()),
              _buildDetailRow(Icons.money, 'Total Sales Value', customer.totalSalesValue?.toStringAsFixed(2) ?? 'N/A'),
              _buildDetailRow(Icons.undo, 'Total Sales Return Value', customer.totalSalesReturnValue?.toStringAsFixed(2) ?? 'N/A'),
              _buildDetailRow(Icons.arrow_back, 'Total Amount Back', customer.totalAmountBack?.toStringAsFixed(2) ?? 'N/A'),
              _buildDetailRow(Icons.collections, 'Total Collection', customer.totalCollection?.toStringAsFixed(2) ?? 'N/A'),
              _buildDetailRow(Icons.calendar_today, 'Last Transaction Date', customer.lastTransactionDate ?? 'N/A'),
              _buildDetailRow(Icons.business, 'Client Company Name', customer.clientCompanyName ?? 'N/A'),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        customer.imageUrl != null
            ? CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage('https://www.pqstec.com/InvoiceApps/${customer.imageUrl}'),
        )
            : const CircleAvatar(
          radius: 50,
          child: Icon(Icons.person, size: 50),
        ),
        const SizedBox(height: 10),
        Text(
          customer.name,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
    );
  }

  Widget _buildDetailCard(List<Widget> children) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: children,
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(color: Colors.black54,fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
