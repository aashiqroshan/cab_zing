import 'package:cab_zing/pages/dashboard.dart';
import 'package:cab_zing/pages/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  int currentIndex = 0;

  List<BottomNavigationBarItem> navbarItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.send), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
  ];

  List navBody = [Dashboard(), Dashboard(), Dashboard(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: navBody[currentIndex],
      bottomNavigationBar: _customBottomNav(isDark),
    );
  }

  /// 🔹 Reusable Card

  Widget _customBottomNav(bool isDark) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: isDark ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(4, (index) {
          return GestureDetector(
            onTap: () => setState(() => currentIndex = index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// 🔹 SVG ICON (Replace with your SVG)
                _navIcon(index),

                const SizedBox(height: 5),

                /// 🔵 Active Dot
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: currentIndex == index
                        ? Colors.white
                        : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _navIcon(int index) {
    final icons = [
      'assets/icons/home.svg',
      'assets/icons/send.svg',
      'assets/icons/notification.svg',
      'assets/icons/profile.svg',
    ];

    return SvgPicture.asset(
      icons[index],
      height: 22,
      color: currentIndex == index ? Colors.white : Colors.grey,
      placeholderBuilder: (context) =>
          const Icon(Icons.error, color: Colors.red),
    );
  }
}
