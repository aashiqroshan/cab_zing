import 'package:flutter/material.dart';

class SaleListScreen extends StatelessWidget {
  const SaleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(body: Center(child: Text('Sale list page')));
  }
}
