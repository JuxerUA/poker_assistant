import 'package:flutter/material.dart';
import 'package:poker_assistant/res/res.dart';
import 'package:poker_assistant/widgets/poker_page_scaffold.dart';

class BlindPage extends StatefulWidget {
  const BlindPage({Key? key}) : super(key: key);

  @override
  State<BlindPage> createState() => _BlindPageState();
}

class _BlindPageState extends State<BlindPage>
    with AutomaticKeepAliveClientMixin<BlindPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return PokerPageScaffold(
      title: 'Blinds',
      background: PokerColors.grey,
      body: Column(
        children: const [Text('in progress..')],
      ),
    );
  }
}
