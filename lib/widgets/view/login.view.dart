import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home/widgets/homePage/homePage.dart';
import 'package:home/widgets/view/widgets/social.login.dart';
import 'package:home/widgets/view/widgets/text.form.global.dart';
import '../../Firebase_Authentication/firebase_auth.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _saveUserIdToFirestore(String userId) async {
    try {
      final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
      final snapshot = await userRef.get();
      if (!snapshot.exists) {
        await userRef.set({'userid': userId});
      }
    } catch (error) {
      print('Lỗi không lưu được ID: $error');
    }
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Dog Wiki',
                    style: TextStyle(
                      color: Color(0xFF1E319D),
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 50),

                const Text(
                  'Đăng nhập tài khoản của bạn',
                  style: TextStyle(
                    color: Color(0xFF4F4F4F),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 15),

                // Email Input
                TextFormGlobal(
                  controller: emailController,
                  text: 'Email',
                  obscure: false,
                  textInputType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 10),

                // Password Input
                TextFormGlobal(
                  controller: passwordController,
                  text: 'Password',
                  textInputType: TextInputType.text,
                  obscure: true,
                ),

                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/forgotpassword');
                      },
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Color(0xFF1E319D),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 50),

                MaterialButton(
                  height: 55,
                  minWidth: double.infinity,
                  elevation: 0,
                  color: const Color(0xFF1E319D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  onPressed: () async {
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();
                    if (email.isEmpty || password.isEmpty) {
                      _showSnackBar(context, 'Vui lòng điền đầy đủ thông tin.', Colors.red);
                      return;
                    }

                    final user = await _auth.loginUserWithEmailAndPassword(email, password);
                    if (user != null) {
                      await _saveUserIdToFirestore(user.uid);
                      _showSnackBar(context, 'Đã đăng nhập thành công.', Colors.green);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    } else {
                      _showSnackBar(context, 'Có lỗi đăng nhập.', Colors.red);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    child: Text(
                      "Đăng nhập",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                SocialLogin(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        color: Colors.white,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Chưa có tài khoản?'),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text(
                ' Đăng ký',
                style: TextStyle(
                  color: Color(0xFF1E319D),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
