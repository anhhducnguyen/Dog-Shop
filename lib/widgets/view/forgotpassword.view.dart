import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home/widgets/view/widgets/text.form.global.dart';

class ForgotpasswordView extends StatelessWidget {
  ForgotpasswordView({super.key});
  final TextEditingController emailController = TextEditingController();


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
                  'Nhập Email của bạn',
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

                const SizedBox( height: 25),

                MaterialButton(
                  // alignment: Alignment.center,
                  height: 55,
                  minWidth: double.infinity,
                  elevation: 0,
                  color: const Color(0xFF1E319D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  onPressed: (){
                    FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text).then((value) => Navigator.of(context).pop('/'));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    child: Text(
                      "Lấy lại mật khẩu",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ]
            ),
          ),
        ),
      ),

    );
  }
}
