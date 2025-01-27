import 'package:flutter/material.dart';
import 'package:flutter_currency_today/pages/home_page.dart';

void main() async {
  runApp(AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(hintColor: Colors.blue, primaryColor: Colors.white),
    );
  }
}
