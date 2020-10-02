// import 'package:NodeWithFlutter/Blog/addBlog.dart';
import 'package:NodeWithFlutter/Api/network_handler.dart';
import 'package:NodeWithFlutter/Blog/addBlog.dart';
import 'package:NodeWithFlutter/Pages/HomePage.dart';
// import 'package:NodeWithFlutter/Profile/MainProfile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'Pages/LoadingPage.dart';
import 'Pages/WelcomePage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //Widget page = LoadingPage();
  final isLogin = NetworkHandler();

  Widget page = WelcomePage();
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    String token = await storage.read(key: "token");
    final isAuth = await isLogin.get('/api/users/auth');
    print('check is auth $isAuth');
    print(token);

    if (isAuth['isAuth'] == false) {
      setState(() {
        page = WelcomePage();
      });
    } else {
      setState(() {
        page = HomePage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.openSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: page,
    );
  }
}
