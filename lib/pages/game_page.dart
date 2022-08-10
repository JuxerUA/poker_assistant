import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:poker_assistant/res/res.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage>
    with AutomaticKeepAliveClientMixin<GamePage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      color: PokerColors.black,
      child: DottedBorder(
        borderType: BorderType.RRect,
        color: PokerColors.yellow,
        strokeWidth: 30,
        dashPattern: const <double>[20, 20],
        padding: const EdgeInsets.all(20),
        radius: const Radius.circular(40),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: Container(
            color: PokerColors.black,
            child: const Center(
              child: Text('Poker', style: PokerStyles.headerYellow),
            ),
          ),
        ),
      ),
    );
  }
}
