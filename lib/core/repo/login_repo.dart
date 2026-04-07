import 'dart:developer';

import 'package:cab_zing/Data/modals/login_model.dart';
import 'package:cab_zing/core/api_helper.dart';
import 'package:cab_zing/core/injector.dart';

class LoginRepo {
  final api = getIt<ApiHelper>();
  Future<LoginModel> login(String username, String password) async {
    final response = await api.apiPost(
      "https://api.accounts.vikncodes.com/api/v1/users/login",
      {"username": username, "password": password, "is_mobile": true},
    );
    return LoginModel.fromJson(response);
  }
}
