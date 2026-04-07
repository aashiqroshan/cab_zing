class InvoicesModel {
  final int statusCode;
  final List<InvoiceData> data;
  final int totalCount;

  InvoicesModel({
    required this.statusCode,
    required this.data,
    required this.totalCount,
  });

  factory InvoicesModel.fromJson(Map<String, dynamic> json) {
    return InvoicesModel(
      statusCode: json['StatusCode'],
      data: List<InvoiceData>.from(
        json['data'].map((x) => InvoiceData.fromJson(x)),
      ),
      totalCount: json['total_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'StatusCode': statusCode,
      'data': data.map((x) => x.toJson()).toList(),
      'total_count': totalCount,
    };
  }

  bool get isSuccess => statusCode == 6000;
}

class InvoiceData {
  final int index;
  final String id;
  final String voucherNo;
  final String date;
  final String ledgerName;
  final double totalGrossAmtRounded;
  final double totalTaxRounded;
  final double grandTotalRounded;
  final String customerName;
  final double totalTax;
  final String status;
  final double grandTotal;
  final bool isBillwised;
  final String billwiseStatus;

  InvoiceData({
    required this.index,
    required this.id,
    required this.voucherNo,
    required this.date,
    required this.ledgerName,
    required this.totalGrossAmtRounded,
    required this.totalTaxRounded,
    required this.grandTotalRounded,
    required this.customerName,
    required this.totalTax,
    required this.status,
    required this.grandTotal,
    required this.isBillwised,
    required this.billwiseStatus,
  });

  factory InvoiceData.fromJson(Map<String, dynamic> json) {
    return InvoiceData(
      index: json['index'],
      id: json['id'],
      voucherNo: json['VoucherNo'],
      date: json['Date'],
      ledgerName: json['LedgerName'],
      totalGrossAmtRounded:
          (json['TotalGrossAmt_rounded'] ?? 0).toDouble(),
      totalTaxRounded:
          (json['TotalTax_rounded'] ?? 0).toDouble(),
      grandTotalRounded:
          (json['GrandTotal_Rounded'] ?? 0).toDouble(),
      customerName: json['CustomerName'],
      totalTax: (json['TotalTax'] ?? 0).toDouble(),
      status: json['Status'],
      grandTotal: (json['GrandTotal'] ?? 0).toDouble(),
      isBillwised: json['is_billwised'],
      billwiseStatus: json['billwise_status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'index': index,
      'id': id,
      'VoucherNo': voucherNo,
      'Date': date,
      'LedgerName': ledgerName,
      'TotalGrossAmt_rounded': totalGrossAmtRounded,
      'TotalTax_rounded': totalTaxRounded,
      'GrandTotal_Rounded': grandTotalRounded,
      'CustomerName': customerName,
      'TotalTax': totalTax,
      'Status': status,
      'GrandTotal': grandTotal,
      'is_billwised': isBillwised,
      'billwise_status': billwiseStatus,
    };
  }
}