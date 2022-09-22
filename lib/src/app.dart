import 'package:flutter/material.dart';
import 'pages/lista.dart';
import 'pages/login_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (BuildContext context) {
          switch (settings.name) {
            case "/":
              return const LoginPage();
            case "/home":
              return const Lista();
            default:
              return MyApp();
          }
        });
      },
    );
  }
}
