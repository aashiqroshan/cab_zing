import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static List<ListViewItems> list = [
    ListViewItems(title: 'Help', icon: Icons.help_outline),
    ListViewItems(title: 'FAQ', icon: Icons.question_answer_outlined),
    ListViewItems(title: 'Invite friends', icon: Icons.share_outlined),
    ListViewItems(title: 'Terms of service', icon: Icons.description_outlined),
    ListViewItems(title: 'Privacy policy', icon: Icons.privacy_tip_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            /// 🔹 PROFILE CARD
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: isDark ? Colors.grey[900] : Colors.grey.shade200,
              ),
              child: Column(
                children: [
                  /// 👤 TOP ROW
                  Row(
                    children: [
                      /// Avatar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: Image.asset(
                          'assets/avatar.png',
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      ),

                      const SizedBox(width: 15),

                      /// Name + Email
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'David Arnold',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'David012@cabzing',
                              style: TextStyle(
                                color: isDark ? Colors.white70 : Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// Edit Icon
                      SvgPicture.asset(
                        'assets/icons/edit.svg',
                        height: 20,
                        color: isDark ? Colors.white : Colors.black,
                        placeholderBuilder: (context) => const Icon(Icons.edit),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// 📊 STATS
                  Row(
                    children: [
                      Expanded(
                        child: _statCard(
                          isDark,
                          title: "Bookings",
                          value: "123",
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _statCard(
                          isDark,
                          title: "Invoices",
                          value: "10,232",
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// 🔘 BUTTON
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black,
                    ),
                    child: const Center(
                      child: Text(
                        "Logout",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// 📋 MENU LIST
            ...List.generate(
              list.length,
              (index) => ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                leading: Icon(list[index].icon, color: Colors.blue),
                title: Text(
                  list[index].title,
                  style: TextStyle(color: isDark ? Colors.white : Colors.black),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 STAT CARD
  Widget _statCard(
    bool isDark, {
    required String title,
    required String value,
  }) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isDark ? Colors.black.withOpacity(0.6) : Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 5),
          Text(title, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}

class ListViewItems {
  final String title;
  final IconData icon;

  ListViewItems({required this.title, required this.icon});
}
