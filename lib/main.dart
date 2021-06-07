import 'package:flutter/material.dart';
import 'package:fullstack_chat_app/theme.dart';
import 'package:fullstack_chat_app/ui/pages/onboarding/onboarding.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      theme: lightTheme(context),
      darkTheme: darkTheme(context),
      home: Onboarding()
    );
  }
}
