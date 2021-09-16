import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './welcome/splashscreen.dart';

void main() => runApp(ChangeNotifierProvider(
      create: (_) => MYVMProvider(),
      child: MYVMApp(),
    ));

class MYVMApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "MY Voice App",
      theme: ThemeData(
        primaryColor: Color.fromRGBO(37, 150, 190, 1.0),
        fontFamily: "RobotoMono",
      ),
      home: MYVMASplashScreen(),
    );
  }
}

class MYVMProvider extends ChangeNotifier {
  double screenHeightAppbarless = 0;
  double screenWidth = 0;
  double buttonFontSize = 24;

  String userEmail = "";
  String userPassword = "";
}
