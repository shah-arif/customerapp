import 'package:customerapp/views/widgets/detail_card.dart';
import 'package:customerapp/views/widgets/detail_row.dart';
import 'package:flutter/material.dart';
import '../models/customer.dart';

class CustomerDetailsView extends StatelessWidget {
  final Customer customer;

  const CustomerDetailsView({super.key, required this.customer});

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
            DetailCard(children: [
              DetailRow(icon: Icons.account_circle, label: 'ID', value: customer.id.toString()),
              DetailRow(icon: Icons.email, label: 'Email', value: customer.email ?? 'N/A'),
              DetailRow(icon: Icons.home, label: 'Primary Address', value: customer.primaryAddress ?? 'N/A'),
              DetailRow(icon: Icons.home_work, label: 'Secondary Address', value: customer.secondaryAddress ?? 'N/A'),
              DetailRow(icon: Icons.note, label: 'Notes', value: customer.notes ?? 'N/A'),
              DetailRow(icon: Icons.phone, label: 'Phone', value: customer.phone ?? 'N/A'),
              DetailRow(icon: Icons.people, label: 'Customer Type', value: customer.custType ?? 'N/A'),
              DetailRow(icon: Icons.supervisor_account, label: 'Parent Customer', value: customer.parentCustomer ?? 'N/A'),
            ]),
            const SizedBox(height: 20),
            _buildSectionTitle('Financial Information'),
            DetailCard(children: [
              DetailRow(icon: Icons.attach_money, label: 'Total Balance', value: customer.balance.toStringAsFixed(2)),
              DetailRow(icon: Icons.calendar_today, label: 'Last Sales Date', value: customer.lastSalesDate == "" ? 'N/A' : customer.lastSalesDate.toString()),
              DetailRow(icon: Icons.receipt, label: 'Last Invoice No', value: customer.lastInvoiceNo == "" ? 'N/A' : customer.lastInvoiceNo.toString()),
              DetailRow(icon: Icons.shopping_cart, label: 'Last Sold Product', value: customer.lastSoldProduct == "" ? 'N/A' : customer.lastSoldProduct.toString()),
              DetailRow(icon: Icons.money, label: 'Total Sales Value', value: customer.totalSalesValue?.toStringAsFixed(2) ?? 'N/A'),
              DetailRow(icon: Icons.undo, label: 'Total Sales Return Value', value: customer.totalSalesReturnValue?.toStringAsFixed(2) ?? 'N/A'),
              DetailRow(icon: Icons.arrow_back, label: 'Total Amount Back', value: customer.totalAmountBack?.toStringAsFixed(2) ?? 'N/A'),
              DetailRow(icon: Icons.collections, label: 'Total Collection', value: customer.totalCollection?.toStringAsFixed(2) ?? 'N/A'),
              DetailRow(icon: Icons.calendar_today, label: 'Last Transaction Date', value: customer.lastTransactionDate ?? 'N/A'),
              DetailRow(icon: Icons.business, label: 'Client Company Name', value: customer.clientCompanyName ?? 'N/A'),
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
}

