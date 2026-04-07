import 'package:cab_zing/Data/local_storage.dart';
import 'package:cab_zing/core/constants.dart';
import 'package:cab_zing/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  static List<ListViewItems> list = [
    ListViewItems(title: 'Help', icon: Icons.help_outline),
    ListViewItems(title: 'FAQ', icon: Icons.question_answer_outlined),
    ListViewItems(title: 'Invite friends', icon: Icons.share_outlined),
    ListViewItems(title: 'Terms of service', icon: Icons.description_outlined),
    ListViewItems(title: 'Privacy policy', icon: Icons.privacy_tip_outlined),
  ];

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final storage = LocalStorage();

  String? username;
  String? useremail;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final name = await storage.read(userName);
    final email = await storage.read(userEmail);

    setState(() {
      username = name;
      useremail = email;
    });
  }

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
                              username ?? '',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              useremail ?? '',
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

                  Row(
                    children: [
                      Expanded(
                        child: _statCard(
                          isDark: isDark,
                          icon: Icons.star,
                          title: "4.3",
                          subtitle: "2211 rides",
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: _statCard(
                          isDark: isDark,
                          icon: Icons.verified_user,
                          title: "KYC",
                          subtitle: "Verified",
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  InkWell(
                    onTap: () {
                      storage.clear();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: isDark ? Colors.black : Colors.white,
                      ),
                      child: const Center(
                        child: Text(
                          "Logout",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// 📋 MENU LIST
            ...List.generate(
              ProfileScreen.list.length,
              (index) => ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                leading: Icon(
                  ProfileScreen.list[index].icon,
                  color: Colors.blue,
                ),
                title: Text(
                  ProfileScreen.list[index].title,
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

  Widget _statCard({
    required bool isDark,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final bgColor = isDark ? Colors.black : Colors.white;

    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 60,
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF1C2A35)
                  : Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              icon,
              color: isDark ? Colors.lightBlueAccent : Colors.blue,
              size: 20,
            ),
          ),

          const SizedBox(width: 12),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.star, color: Colors.orange, size: 16),
                ],
              ),

              const SizedBox(height: 4),

              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? Colors.white70 : Colors.black54,
                ),
              ),
            ],
          ),
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
