import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poker_assistant/pages/blind_page.dart';
import 'package:poker_assistant/pages/game_page.dart';
import 'package:poker_assistant/pages/general_page.dart';
import 'package:poker_assistant/pages/statistics_page.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final PageController _gameController = PageController();
  final PageController _pagesController = PageController(initialPage: 1);

  var _isStatusBarEnabled = true;

  @override
  void initState() {
    _gameController.addListener(_gameViewListener);
    _pagesController.addListener(_pagesViewListener);
    super.initState();
  }

  @override
  void dispose() {
    _gameController
      ..dispose()
      ..removeListener(_gameViewListener);
    _pagesController
      ..dispose()
      ..removeListener(_pagesViewListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _gameController,
        // physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: [
          PageView(
            controller: _pagesController,
            children: const [
              StatisticsPage(),
              GeneralPage(),
              BlindPage(),
            ],
          ),
          const GamePage(),
        ],
      ),
    );
  }

  void _gameViewListener() {
    if (_gameController.position.pixels ==
        _gameController.position.maxScrollExtent) {
      /// Disable status bar
      _isStatusBarEnabled = false;
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    } else {
      if (!_isStatusBarEnabled) {
        /// Enable status bar
        _isStatusBarEnabled = true;
        SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.manual,
          overlays: SystemUiOverlay.values,
        );
      }
    }
  }

  void _pagesViewListener() {}
}
