import 'package:flutter/material.dart';
import 'package:poker_assistant/res/res.dart';
import 'package:poker_assistant/widgets/poker_page_scaffold.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage>
    with AutomaticKeepAliveClientMixin<StatisticsPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return PokerPageScaffold(
      title: 'Statistics',
      background: PokerColors.grey,
      body: Column(
        children: const [Text('in progress..')],
      ),
    );
  }
}
