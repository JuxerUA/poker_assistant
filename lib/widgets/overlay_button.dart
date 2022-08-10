import 'dart:math';

import 'package:flutter/material.dart';
import 'package:poker_assistant/res/res.dart';

class OverlayButton extends StatelessWidget {
  const OverlayButton({
    required this.image,
    required this.text,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final IconData image;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(builder: (context, constraints) {
        final isVertical = constraints.maxWidth > constraints.maxHeight * 1.5;
        final minSize = min(constraints.minWidth, constraints.minHeight);

        return InkWell(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: PokerColors.dark,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: isVertical
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: Center(child: Icon(image, size: 100))),
                      const SizedBox(width: 16),
                      Text(
                        text,
                        style: PokerStyles(FontSize.s20, PokerColors.orange),
                      ),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: Center(child: Icon(image, size: 100))),
                      const SizedBox(width: 16),
                      Text(
                        text,
                        style: PokerStyles(FontSize.s20, PokerColors.orange),
                      ),
                    ],
                  ),
          ),
        );
      }),
    );
  }
}
