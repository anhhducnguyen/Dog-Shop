import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home/widgets/view/widgets/text.form.global.dart';
import '../../Firebase_Authentication/firebase_auth.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});
  FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repasswordController = TextEditingController();


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
                  'Đăng ký tài khoản',
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

                // Password Input
                TextFormGlobal(
                  controller: repasswordController,
                  text: 'Enter the password',
                  textInputType: TextInputType.text,
                  obscure: true,
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
                    String password = passwordController.text;
                    String repassword = repasswordController.text;
                    if(password == repassword) {
                      User? user = await _auth.registerUserWithEmailAndPassword(
                          emailController.text, passwordController.text
                      );

                      if (user != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Đã đăng ký thành công."),
                              backgroundColor: Colors.green,
                            ));

                        Navigator.pushNamed(context, "/login");
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Có lỗi đăng ký."),
                              backgroundColor: Colors.red,
                            ));
                      }
                    }
                    else
                    {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Mật khẩu phải giống nhau."),
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
                      "Đăng ký",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                const SizedBox( height: 40),

                // SocialLogin(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
