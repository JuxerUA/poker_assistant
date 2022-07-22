import 'package:flutter/material.dart';
import 'package:poker_assistant/widgets/poker_page_scaffold.dart';

class BlindPage extends StatefulWidget {
  const BlindPage({Key? key}) : super(key: key);

  @override
  State<BlindPage> createState() => _BlindPageState();
}

class _BlindPageState extends State<BlindPage> {
  @override
  Widget build(BuildContext context) {
    return PokerPageScaffold(
      title: 'Blinds',
      background: Colors.red,
      body: Column(
        children: [Text('in progress..')],
      ),
    );
  }
}
