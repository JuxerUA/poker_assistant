import 'package:flutter/material.dart';
import 'package:poker_assistant/res/res.dart';

class PokerPageScaffold extends StatelessWidget {
  const PokerPageScaffold({
    required this.title,
    required this.body,
    required this.background,
    Key? key,
  }) : super(key: key);

  final String title;
  final Widget body;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        color: background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                title,
                style: PokerStyles.headerDark,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(child: body),
          ],
        ),
      ),
    );
  }
}
