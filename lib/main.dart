import 'package:flutter/material.dart';
import 'package:poker_assistant/pages/navigation_page.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Poker Assistant',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        backgroundColor: Colors.black,
        fontFamily: 'Bitter',
      ),
      home: const NavigationPage(),
    ),
  );
}
