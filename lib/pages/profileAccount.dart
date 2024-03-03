import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '/models/theme_manager.dart';
import '/widgets/components/myBottom.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  
  Color getLogoutButtonColor(BuildContext context, bool isDarkMode) {
    return isDarkMode ? Colors.purple.shade800 : Colors.blue.shade400;
  }


  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final isDarkMode = themeManager.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: themeManager.appBarColor,
        // foregroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          "Thông tin tài khoản",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: 2,
        onTabTapped: (int index) {
          if (index == 0) {
            Navigator.pushNamed(context, "/homePage"); // Navigate to the home page
          } else if (index == 1) {
            Navigator.pushNamed(context, "/newpage"); // Navigate to the profile page
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
                backgroundImage: AssetImage('assets/images/user.png'),
              ),
              const SizedBox(height: 20),
              itemProfile('Name', 'Nguyễn Đức Anh', CupertinoIcons.person, isDarkMode),
              const SizedBox(height: 10),
              itemProfile('Position', 'Manager', CupertinoIcons.briefcase, isDarkMode),
              const SizedBox(height: 10),
              itemProfile('Phone', '0981402765', CupertinoIcons.phone, isDarkMode),
              const SizedBox(height: 10),
              itemProfile('Address', 'Hà Đông', CupertinoIcons.location, isDarkMode),
              const SizedBox(height: 10),
              itemProfile('Email', '21012478@st.phenikaa-uni.edu.vn', CupertinoIcons.mail, isDarkMode),
              const SizedBox(height: 20,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                    primary: getLogoutButtonColor(context, isDarkMode), // Sử dụng màu chủ đề
                  ),
                  child: const Text('Đăng xuất', style: TextStyle(color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget itemProfile(String title, String subtitle, IconData iconData, bool isDarkMode) {
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
        trailing: Icon(Icons.arrow_forward, color: isDarkMode ? Colors.grey.shade400 : Colors.black54),
        tileColor: isDarkMode ? Colors.grey[900] : Colors.white,
      ),
    );
  }
}
