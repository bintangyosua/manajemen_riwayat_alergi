import 'package:flutter/material.dart';
import 'package:manajemen_riwayat_alergi/helpers/user_info.dart';
import 'package:manajemen_riwayat_alergi/ui/login_page.dart';
import 'package:manajemen_riwayat_alergi/ui/alergi_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = const CircularProgressIndicator();
  @override
  void initState() {
    super.initState();
    isLogin();
  }

  void isLogin() async {
    var token = await UserInfo().getToken();
    if (token != null) {
      setState(() {
        page = const AlergiPage();
      });
    } else {
      setState(() {
        page = const LoginPage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toko Kita',
      debugShowCheckedModeBanner: false,
      home: page,
      theme: ThemeData(
          fontFamily: 'Calibri',
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
              backgroundColor: Color.fromRGBO(120, 157, 188, 1),
              foregroundColor: Colors.white,
              elevation: 4.0),
          scaffoldBackgroundColor: const Color(0xFFF5F5F7)),
    );
  }
}
