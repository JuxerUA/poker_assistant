import 'package:flutter/material.dart';
import 'package:poker_assistant/pages/navigation_page.dart';
import 'package:poker_assistant/pages/settings_page.dart';
import 'package:poker_assistant/res/res.dart';
import 'package:poker_assistant/storage.dart';

Future<void> main() async {
  await Storage.instance.init();

  runApp(
    MaterialApp(
      title: 'Poker Assistant',
      routes: {
        SettingsPage.routeName : (_) => const SettingsPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.orange,
        backgroundColor: PokerColors.background,
        fontFamily: 'Bitter',
      ),
      home: const NavigationPage(),
    ),
  );
}
