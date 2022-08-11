import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poker_assistant/res/res.dart';
import 'package:poker_assistant/widgets/poker_page_scaffold.dart';

class GeneralPage extends StatefulWidget {
  const GeneralPage({Key? key}) : super(key: key);

  @override
  State<GeneralPage> createState() => _GeneralPageState();
}

class _GeneralPageState extends State<GeneralPage>
    with AutomaticKeepAliveClientMixin<GeneralPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return PokerPageScaffold(
      title: 'General',
      background: PokerColors.grey,
      body: Column(
        children: [
          Row(
            children: [
              /// Number of players
              const RotatedBox(
                quarterTurns: 3,
                child: Text(
                  'Number of players',
                  style: TextStyle(color: Colors.orange, fontSize: 20),
                ),
              ),
              const SizedBox(width: 6),
              SizedBox(
                height: 100,
                width: 40,
                child: PageView(
                  scrollDirection: Axis.vertical,
                  padEnds: false,
                  controller: PageController(viewportFraction: 0.3),
                  children: List.generate(
                    kMaxPlayersCount - kMinPlayersCount,
                    (index) => Container(
                      width: 30,
                      height: 30,
                      color: PokerColors.orange,
                      child: Center(child: Text(index.toString())),
                    ),
                  ),
                ),
              ),
              const SizedBox.square(dimension: 10),
              SizedBox(
                width: 100,
                height: 500,
                child: CupertinoPicker(
                  diameterRatio: 1,
                  itemExtent: 50,
                  squeeze: 2,
                  useMagnifier: true,
                  looping: true,
                  onSelectedItemChanged: _onItemChanged,
                  children: List.generate(
                    kMaxPlayersCount - kMinPlayersCount,
                    (index) => Center(
                      child: Text((index + kMinPlayersCount).toString()),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onItemChanged(int _) {
    //TODO
  }
}
