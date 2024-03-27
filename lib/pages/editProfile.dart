import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:home/widgets/view/widgets/text.form.global.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import '../Firebase_Authentication/firebase_auth.dart';
import '/models/theme_manager.dart';
import '/widgets/components/myBottom.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);
  FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addresController = TextEditingController();
  final TextEditingController emailController = TextEditingController();


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
          "Sửa thông tin tài khoản",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Ionicons.create_outline, size: 28),
        //     onPressed: () {
        //       // Xử lý khi người dùng nhấn vào nút chỉnh sửa ở đây
        //     },
        //   ),
        // ],
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: 2,
        onTabTapped: (int index) {
          if (index == 0) {
            Navigator.pushNamed(context, "/homePage"); // Navigate to the home page
          } else if (index == 1) {
            Navigator.pushNamed(context, "/favourite"); // Navigate to the profile page
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
                backgroundImage: AssetImage('assets/images/avatar2.jpg'),
              ),
              const SizedBox(height: 20),
              // itemProfile('Name', 'Nguyễn Đức Anh', CupertinoIcons.person, isDarkMode),
              TextFormGlobal(
                    controller: nameController,
                    text: 'Name',
                    obscure: false,
                    textInputType: TextInputType.emailAddress
              ),
              const SizedBox(height: 20),
              // itemProfile('Phone', '0981402765', CupertinoIcons.phone, isDarkMode),
              TextFormGlobal(
                    controller: phoneController,
                    text: 'Phone',
                    obscure: false,
                    textInputType: TextInputType.emailAddress
              ),
              const SizedBox(height: 20),
              // itemProfile('Address', 'Hà Đông', CupertinoIcons.location, isDarkMode),
              TextFormGlobal(
                    controller: addresController,
                    text: 'Address',
                    obscure: false,
                    textInputType: TextInputType.emailAddress
              ),
              const SizedBox(height: 20),
              // itemProfile('Email', '21012478@st.phenikaa-uni.edu.vn', CupertinoIcons.mail, isDarkMode),
              TextFormGlobal(
                    controller: emailController,
                    text: 'Email',
                    obscure: false,
                    textInputType: TextInputType.emailAddress
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
                    primary: getLogoutButtonColor(context, isDarkMode), // Sử dụng màu chủ đề
                  ),
                  child: const Text('Lưu thông tin', style: TextStyle(color: Colors.white)),
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
        // trailing: Icon(Icons.arrow_forward, color: isDarkMode ? Colors.grey.shade400 : Colors.black54),
        tileColor: isDarkMode ? Colors.grey[900] : Colors.white,
      ),
    );
  }
}
