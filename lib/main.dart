import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/models/theme_manager.dart';
import '/widgets/settings.dart';
import 'widgets/homePage/homePage.dart';
// import 'widgets/introductionScreen.dart';
import 'pages/profileAccount.dart';
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeManager(),
      child: MyApp(),
    ),
  );
}

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
          "/": (context) =>  HomePage(),
          "/homePage": (context) => HomePage(),
          "/introductionScreen": (context) => const ProfileScreen(),
          "/settings": (context) => SettingsPage(),
          "/profile": (context) => const ProfileScreen(),
        }
    );
  }
}
