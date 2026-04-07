import 'package:cab_zing/Bloc/invoices/invoices_bloc.dart';
import 'package:cab_zing/Data/modals/invoices_model.dart';
import 'package:cab_zing/pages/filter_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InvoicesScreen extends StatefulWidget {
  const InvoicesScreen({super.key});

  @override
  State<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends State<InvoicesScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<InvoiceData> _allInvoices = [];
  List<InvoiceData> _filteredInvoices = [];

  @override
  void initState() {
    super.initState();
    context.read<InvoicesBloc>().add(GetInvoices());

    _searchController.addListener(_onSearch);
  }

  void _onSearch() {
    final query = _searchController.text.toLowerCase();

    setState(() {
      _filteredInvoices = _allInvoices.where((item) {
        return item.voucherNo.toLowerCase().contains(query) ||
            item.customerName.toLowerCase().contains(query);
      }).toList();
    });
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.red;
      case 'invoiced':
        return Colors.blue;
      case 'cancelled':
        return Colors.grey;
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        title: const Text('Invoices'),
        backgroundColor: isDark ? Colors.black : Colors.white,
        elevation: 0,
      ),
      body: BlocBuilder<InvoicesBloc, InvoicesState>(
        builder: (context, state) {
          if (state is InvoicesLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is InvoicesSuccess) {
            _allInvoices = state.data.data;

            // initialize filtered list first time
            if (_filteredInvoices.isEmpty) {
              _filteredInvoices = _allInvoices;
            }

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 45,
                          decoration: BoxDecoration(
                            color: isDark ? Colors.black : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(width: 1),
                          ),
                          child: TextField(
                            controller: _searchController,
                            decoration: const InputDecoration(
                              hintText: "Search",
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      // FILTER BUTTON
                      InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FiltersScreen(),
                          ),
                        ),
                        child: Container(
                          height: 45,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0F1A24),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: const [
                              Icon(Icons.tune, color: Colors.white, size: 18),
                              SizedBox(width: 6),
                              Text(
                                "Add Filters",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // 📋 LIST
                Expanded(
                  child: ListView.separated(
                    itemCount: _filteredInvoices.length,
                    separatorBuilder: (_, __) =>
                        Divider(color: Colors.grey.shade900, thickness: 1),
                    itemBuilder: (context, index) {
                      final item = _filteredInvoices[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // LEFT SIDE
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '#${item.voucherNo}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item.customerName,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  item.status,
                                  style: TextStyle(
                                    color: _getStatusColor(item.status),
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'SAR ${item.grandTotal.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
