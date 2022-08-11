import 'dart:math';

import 'package:flutter/material.dart';
import 'package:poker_assistant/res/res.dart';

class OverlayButton extends StatelessWidget {
  const OverlayButton({
    required this.image,
    required this.text,
    required this.onTap,
    this.isVertical = false,
    Key? key,
  }) : super(key: key);

  static const paddingSize = 16.0;

  final IconData image;
  final String text;
  final VoidCallback onTap;
  final bool isVertical;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final minSize = min(constraints.maxWidth, constraints.maxHeight);

      return InkWell(
        splashColor: PokerColors.orange,
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(paddingSize),
          decoration: const BoxDecoration(
            color: PokerColors.dark,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: isVertical
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Center(
                        child: Icon(
                          image,
                          size: minSize / 2,
                        ),
                      ),
                    ),
                    Text(
                      text,
                      style: PokerStyles(FontSize.s20, PokerColors.orange),
                    ),
                  ],
                )
              : Row(
                  children: [
                    SizedBox(
                      width: minSize - paddingSize * 2,
                      child: Center(child: Icon(image, size: minSize / 2)),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      text,
                      style: PokerStyles(FontSize.s20, PokerColors.lightBlack),
                    ),
                  ],
                ),
        ),
      );
    });
  }
}
