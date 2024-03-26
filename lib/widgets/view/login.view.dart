import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home/widgets/homePage/homePage.dart';
import 'package:home/widgets/view/widgets/social.login.dart';
import 'package:home/widgets/view/widgets/text.form.global.dart';
import '../../Firebase_Authentication/firebase_auth.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _saveUserIdToFirestore(String userId) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'userid': userId,
      });
    } catch (error) {
      print('Error saving userId to Firestore: $error');
    }
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
                const SizedBox( height: 20),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Dog Wiki',
                    style: TextStyle(
                      color: Color(0xFF1E319D),
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox( height: 50),

                Text(
                  'Đăng nhập tài khoản của bạn',
                  style: TextStyle(
                    color: Color(0xFF4F4F4F),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox( height: 15),

                // Email Input
                TextFormGlobal(
                    controller: emailController,
                    text: 'Email',
                    obscure: false,
                    textInputType: TextInputType.emailAddress
                ),

                const SizedBox( height: 10),

                // Password Input
                TextFormGlobal(
                  controller: passwordController,
                  text: 'Password',
                  textInputType: TextInputType.text,
                  obscure: true,
                ),

                const SizedBox( height: 10),

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
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Color(0xFF1E319D),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox( height: 50),

                MaterialButton(
                  // alignment: Alignment.center,
                  height: 55,
                  minWidth: double.infinity,
                  elevation: 0,
                  color: const Color(0xFF1E319D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  onPressed: () async {
                    User? user = await _auth.loginUserWithEmailAndPassword(
                        emailController.text, passwordController.text
                    );

                    if (user != null) {
                      await _saveUserIdToFirestore(user.uid);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Đã đăng nhập thành công."),
                        backgroundColor: Colors.green,
                      ));

                      // Navigator.pushNamed(context, "/homePage");
                      Navigator.pushReplacement( 
                        context,
                         MaterialPageRoute(builder: (context) => HomePage())); // chuyển trang không cho phép quay lại login từ trang chủ
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Có lỗi đăng nhập."),
                        backgroundColor: Colors.red,
                      ));
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

                const SizedBox( height: 40),

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
            Text(
              'Chưa có tài khoản?'
            ),
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

    