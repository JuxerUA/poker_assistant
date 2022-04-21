import 'package:flutter/material.dart';
import 'package:poker_assistant/my_home_page.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Poker Assistant',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        backgroundColor: Colors.black,
      ),
      home: const MyHomePage(),
    ),
  );
}
