import 'package:flutter/material.dart';
import 'package:poker_assistant/widgets/poker_page_scaffold.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    return PokerPageScaffold(
      title: 'Statistics',
      background: Colors.yellow,
      body: Column(
        children: [Text('in progress..')],
      ),
    );
  }
}
