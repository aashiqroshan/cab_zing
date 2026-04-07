import 'package:cab_zing/Data/local_storage.dart';
import 'package:cab_zing/Data/modals/invoices_model.dart';
import 'package:cab_zing/core/api_helper.dart';
import 'package:cab_zing/core/constants.dart';
import 'package:cab_zing/core/injector.dart';

class InvoicesRepo {
  final api = getIt<ApiHelper>();
  final storage = LocalStorage();
  Future<InvoicesModel> getInvoices() async {
    final userid = await storage.read(userId);
    final response = await api.apiPost(
      'https://www.api.viknbooks.com/api/v10/sales/sale-list-page/',
      {
        "BranchID": 1,
        "CompanyID": "1901b825-fe6f-418d-b5f0-7223d0040d08",
        "CreatedUserID": int.parse(userid),
        "PriceRounding": 2,
        "page_no": 1,
        "items_per_page": 10,
        "type": "Sales",
        "WarehouseID": 1,
      },
    );
    return InvoicesModel.fromJson(response);
  }
}
