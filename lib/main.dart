import "dart:io";
import "package:flutter/material.dart";
import "package:firebase_core/firebase_core.dart";
import 'package:home/pages/favourite.dart';
import 'package:home/widgets/view/forgotpassword.view.dart';
import 'package:home/widgets/view/login.view.dart';
import 'package:home/widgets/view/register.view.dart';
import 'package:home/widgets/view/splash.view.dart';
import 'package:provider/provider.dart';
import '/models/theme_manager.dart';
import '/widgets/settings.dart';
import 'widgets/homePage/homePage.dart';
// import 'widgets/introductionScreen.dart';
import 'pages/profileAccount.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid ?
  await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyAw8yZ-EEAGgPBIRSDrncdrYZtuTfcAeFw", // current_key
        appId: "1:568501628949:android:d56087f8268cbad16ade1c", // mobilesdk_app_id
        messagingSenderId: "568501628949", // project_number
        projectId: "dog-wiki", // project_id
      )
  ) : await Firebase.initializeApp();
  runApp(
      ChangeNotifierProvider(
        create: (context) => ThemeManager(),
       child: MyApp(),
     ),
  );
}

// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => ThemeManager(),
//       child: MyApp(),
//     ),
//   );
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeManager.themeMode,
      // home: MyHomePage(),
      initialRoute: "/",
        routes: {
          "/": (context) => LoginView(),
          "/register": (context) => RegisterView(),
          "/login": (context) => LoginView(),
          "/forgotpassword": (context) => ForgotpasswordView(),
          "/favourite": (context) => FavoritePage(),
          "/homePage": (context) => HomePage(),
          "/introductionScreen": (context) => ProfileScreen(),
          "/settings": (context) => SettingsPage(),
          "/profile": (context) => ProfileScreen(),
        }
    );
  }
}
