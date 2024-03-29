import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:home/widgets/view/widgets/text.form.global.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import '../Firebase_Authentication/firebase_auth.dart';
import '/models/theme_manager.dart';
import '/widgets/components/myBottom.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  FirebaseAuthService _auth = FirebaseAuthService();

  Color getLogoutButtonColor(BuildContext context, bool isDarkMode) {
    return isDarkMode ? Colors.purple.shade800 : Colors.blue.shade400;
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final isDarkMode = themeManager.themeMode == ThemeMode.dark;
    final currentUser = FirebaseAuth.instance.currentUser;

    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('users').doc(currentUser!.uid).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Hiển thị tiêu đề đang tải nếu cần
        }

        if (snapshot.hasError) {
          return Text('Có lỗi xảy ra: ${snapshot.error}');
        }

        final userData = snapshot.data!.data() as Map<String, dynamic>;

        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 50,
            backgroundColor: themeManager.appBarColor,
            foregroundColor: Colors.black,
            title: const Text(
              "Thông tin tài khoản",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Ionicons.create_outline, size: 28),
                onPressed: () {
                  Navigator.pushNamed(context, "/eprofile");
                },
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigation(
            currentIndex: 2,
            onTabTapped: (int index) {
              if (index == 0) {
                Navigator.pushNamed(context, "/homePage");
              } else if (index == 1) {
                Navigator.pushNamed(context, "/favourite");
              }
            },
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  const CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage('assets/images/avata.jpg'),
                  ),
                  const SizedBox(height: 20),
                  itemProfile(
                      'Name',
                      userData['name'] ?? '',
                      CupertinoIcons.person,
                      isDarkMode
                  ),
                  const SizedBox(height: 10),
                  itemProfile(
                      'Phone',
                      userData['phone'] ?? '',
                      CupertinoIcons.phone,
                      isDarkMode
                  ),
                  const SizedBox(height: 10),
                  itemProfile(
                      'Address',
                      userData['address'] ?? '',
                      CupertinoIcons.location,
                      isDarkMode
                  ),
                  const SizedBox(height: 10),
                  itemProfile(
                      'Email',
                      userData['email'] ?? '',
                      CupertinoIcons.mail,
                      isDarkMode
                  ),
                  const SizedBox(height: 70,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        await _auth.signOut();
                        Navigator.of(context).popAndPushNamed("/");
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(15),
                        primary: getLogoutButtonColor(
                            context, isDarkMode),
                      ),
                      child: const Text(
                          'Đăng xuất', style: TextStyle(color: Colors.white)),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget itemProfile(String title, String subtitle, IconData iconData,
      bool isDarkMode) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            color: isDarkMode
                ? Colors.black.withOpacity(0.3)
                : const Color.fromARGB(255, 173, 167, 165).withOpacity(.2),
            spreadRadius: 2,
            blurRadius: 10,
          )
        ],
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: isDarkMode ? Colors.grey : Colors.black87),
        ),
        leading: Icon(iconData, color: isDarkMode ? Colors.grey : Colors.black),
        tileColor: isDarkMode ? Colors.grey[900] : Colors.white,
      ),
    );
  }
}
