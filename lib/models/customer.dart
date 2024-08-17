class Customer {
  final int id;
  final String name;
  final String? email;
  final String? primaryAddress;
  final String? secondaryAddress;
  final String? notes;
  final String? phone;
  final String? custType;
  final String? parentCustomer;
  final String? imageUrl;
  final double balance;
  final String? lastSalesDate;
  final String? lastInvoiceNo;
  final String? lastSoldProduct;
  final double? totalSalesValue;
  final double? totalSalesReturnValue;
  final double? totalAmountBack;
  final double? totalCollection;
  final String? lastTransactionDate;
  final String? clientCompanyName;

  Customer({
    required this.id,
    required this.name,
    this.email,
    this.primaryAddress,
    this.secondaryAddress,
    this.notes,
    this.phone,
    this.custType,
    this.parentCustomer,
    required this.imageUrl,
    required this.balance,
    this.lastSalesDate,
    this.lastInvoiceNo,
    this.lastSoldProduct,
    this.totalSalesValue,
    this.totalSalesReturnValue,
    this.totalAmountBack,
    this.totalCollection,
    this.lastTransactionDate,
    this.clientCompanyName,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['Id'] ?? 0,
      name: json['Name'] ?? 'N/A',
      email: json['Email'],
      primaryAddress: json['PrimaryAddress'],
      secondaryAddress: json['SecondaryAddress'],
      notes: json['Notes'],
      phone: json['Phone'],
      custType: json['CustType'],
      parentCustomer: json['ParentCustomer'],
      imageUrl: json['ImagePath'],
      balance: json['TotalDue']?.toDouble(),
      lastSalesDate: json['LastSalesDate'],
      lastInvoiceNo: json['LastInvoiceNo'],
      lastSoldProduct: json['LastSoldProduct'],
      totalSalesValue: json['TotalSalesValue']?.toDouble(),
      totalSalesReturnValue: json['TotalSalesReturnValue']?.toDouble(),
      totalAmountBack: json['TotalAmountBack']?.toDouble(),
      totalCollection: json['TotalCollection']?.toDouble(),
      lastTransactionDate: json['LastTransactionDate'],
      clientCompanyName: json['ClientCompanyName'],
    );
  }
}
