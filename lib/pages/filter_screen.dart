import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  String selectedStatus = "Pending";
  DateTime? fromDate;
  DateTime? toDate;
  String? selectedCustomer = "savad farooque";

  Future<void> _pickDate(bool isFrom) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        if (isFrom) {
          fromDate = picked;
        } else {
          toDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = isDark ? Colors.black : Colors.white;
    final cardColor = isDark ? const Color(0xFF0F1A24) : Colors.grey.shade200;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text("Filters"),
        backgroundColor: bgColor,
        elevation: 0,
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.remove_red_eye, color: Colors.blue),
            label: const Text("Filter", style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text("This Month"),
                    Icon(Icons.keyboard_arrow_down),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(child: _dateBox(isDark, fromDate, true)),
                const SizedBox(width: 10),
                Expanded(child: _dateBox(isDark, toDate, false)),
              ],
            ),

            const SizedBox(height: 20),
            Divider(color: Colors.grey.shade800),

            const SizedBox(height: 20),

            Row(
              children: [
                _statusButton("Pending", isDark),
                const SizedBox(width: 10),
                _statusButton("Invoiced", isDark),
                const SizedBox(width: 10),
                _statusButton("Cancelled", isDark),
              ],
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: 50,
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isDark ? Colors.grey.shade800 : Colors.grey,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Customer", style: TextStyle(color: textColor)),
                  const Icon(Icons.keyboard_arrow_down),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// 🏷 Selected Customer Chip
            if (selectedCustomer != null)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(selectedCustomer!, style: TextStyle(color: textColor)),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCustomer = null;
                        });
                      },
                      child: const Icon(Icons.close, size: 16),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _dateBox(bool isDark, DateTime? date, bool isFrom) {
    final cardColor = isDark ? const Color(0xFF0F1A24) : Colors.grey.shade200;

    return GestureDetector(
      onTap: () => _pickDate(isFrom),
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today, size: 18),
            const SizedBox(width: 8),
            Text(
              date == null
                  ? "Select Date"
                  : "${date.day}/${date.month}/${date.year}",
            ),
          ],
        ),
      ),
    );
  }

  Widget _statusButton(String title, bool isDark) {
    final isSelected = selectedStatus == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedStatus = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.blue
              : isDark
              ? const Color(0xFF1E2A33)
              : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          title,
          style: TextStyle(color: isSelected ? Colors.white : null),
        ),
      ),
    );
  }
}
