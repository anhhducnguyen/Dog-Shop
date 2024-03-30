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

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? getCurrentUser() {
    try {
      return _firebaseAuth.currentUser;
    } catch (error) {
      print('Lỗi khi lấy người dùng hiện tại: $error');
      return null;
    }
  }
}

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);
  FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  Future<void> _saveUserInfoToFirestore(String userId) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'name': nameController.text,
        'phone': phoneController.text,
        'address': addressController.text,
        'email': emailController.text,
      }, SetOptions(merge: true));
    } catch (error) {
      print('Lỗi không lưu được thông tin: $error');
    }
  }

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
        foregroundColor: Colors.black,
        title: const Text(
          "Sửa thông tin tài khoản",
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
                backgroundImage: AssetImage('assets/images/avatar2.jpg'),
              ),
              const SizedBox(height: 20),
              TextFormGlobal(
                controller: nameController,
                text: 'Name',
                obscure: false,
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 20),
              TextFormGlobal(
                controller: phoneController,
                text: 'Phone',
                obscure: false,
                textInputType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              TextFormGlobal(
                controller: addressController,
                text: 'Address',
                obscure: false,
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 20),
              TextFormGlobal(
                controller: emailController,
                text: 'Email',
                obscure: false,
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 70),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final currentUser = _auth.getCurrentUser();
                    if (currentUser != null) {
                      await _saveUserInfoToFirestore(currentUser.uid);
                      Navigator.pop(context, true);
                      Navigator.of(context).pop();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                    primary: getLogoutButtonColor(context, isDarkMode),
                  ),
                  child: const Text(
                    'Lưu thông tin',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
