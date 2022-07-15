import 'package:cube_transition_plus/cube_transition_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poker_assistant/pages/blind_page.dart';
import 'package:poker_assistant/pages/game_page.dart';
import 'package:poker_assistant/pages/general_page.dart';
import 'package:poker_assistant/pages/statistics_page.dart';
import 'package:poker_assistant/widgets/back_to_game_widget.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

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
      ..removeListener(_gameViewListener)
      ..dispose();
    _pagesController
      ..removeListener(_pagesViewListener)
      ..dispose();
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
          Column(
            children: [
              KeepAlive(
                keepAlive: true,
                child: Expanded(
                  child: CubePageView(
                    controller: _pagesController,
                    children: const [
                      StatisticsPage(),
                      GeneralPage(),
                      BlindPage(),
                    ],
                  ),
                ),
              ),
              BottomNavigationWidget(
                toLeft: () => _pagesController.previousPage(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                ),
                toRight: () => _pagesController.nextPage(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                ),
                toGame: () => _gameController.nextPage(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                ),
              ),
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
