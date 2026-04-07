import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const String refreshToken = 'refreshToken';
const String accessToken = 'accessToken';
const String userName = 'userName';
const String userEmail = 'userEmail';
const String userId = 'userId';
const String loginBody = 'loginBody';

void toast(String message, {Color backgroundColor = Colors.black}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: backgroundColor,
    textColor: Colors.white,
    fontSize: 14,
  );
}
