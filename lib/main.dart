import 'package:changarro/src/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(Changarro());

class Changarro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.orange.shade50,
        statusBarBrightness: Brightness.light,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarColor: Colors.orange.shade50,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Abarrotes Doña Brisia',
      theme: ThemeData(
        primaryColor: Colors.pink.shade200,
        accentColor: Colors.pink.shade100,
        backgroundColor: Colors.orange.shade50,
        fontFamily: 'Karla',
        appBarTheme: AppBarTheme(elevation: 0.0),
      ),
      home: Home(),
    );
  }
}
