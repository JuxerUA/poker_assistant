import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: DottedBorder(
        borderType: BorderType.RRect,
        color: Colors.orange,
        strokeWidth: 30,
        dashPattern: const <double>[20, 20],
        padding: const EdgeInsets.all(20),
        radius: const Radius.circular(40),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: Container(
            color: Colors.black,
            child: const Center(
              child: Text(
                'Poker',
                style: TextStyle(color: Colors.orange, fontSize: 40),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
