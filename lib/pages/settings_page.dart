import 'package:flutter/material.dart';
import 'package:poker_assistant/pages/game/view_modes/view_modes.dart';
import 'package:poker_assistant/res/res.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  static const routeName = '/settings';

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PokerColors.grey,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text(
              'View mode',
              style: TextStyle(color: Colors.orange, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            Slider(
              value: settings.viewMode.value.index.toDouble() + 1,
              min: 1,
              max: ViewModes.values.length.toDouble() + 1,
              divisions: 2,
              onChanged: (value) {
                final index = value - 1;
                if (index >= 0 && index < ViewModes.values.length) {
                  setState(() {
                    settings.viewMode.value = ViewModes.values
                        .firstWhere((mode) => mode.index == index);
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
