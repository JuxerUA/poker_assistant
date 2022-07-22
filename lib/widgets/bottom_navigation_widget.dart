import 'package:flutter/material.dart';

class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({
    required this.toLeft,
    required this.toRight,
    required this.toGame,
    Key? key,
  }) : super(key: key);

  final VoidCallback toLeft;
  final VoidCallback toRight;
  final VoidCallback toGame;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: SizedBox(
            height: 50,
            width: 50,
            child: ElevatedButton(
              onPressed: toLeft,
              child: const Icon(Icons.arrow_back),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              height: 58,
              child: ElevatedButton(
                onPressed: toGame,
                child: const Icon(Icons.arrow_downward),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: SizedBox(
            height: 50,
            width: 50,
            child: ElevatedButton(
              onPressed: toRight,
              child: const Icon(Icons.arrow_forward),
            ),
          ),
        ),
      ],
    );
  }
}
