import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poker_assistant/pages/blind_page.dart';
import 'package:poker_assistant/pages/game_page.dart';
import 'package:poker_assistant/pages/general_page.dart';
import 'package:poker_assistant/pages/settings_page.dart';
import 'package:poker_assistant/pages/statistics_page.dart';
import 'package:poker_assistant/res/res.dart';
import 'package:poker_assistant/res/settings.dart';
import 'package:poker_assistant/widgets/bottom_navigation_widget.dart';
import 'package:poker_assistant/widgets/game_overlay.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage>
    with AutomaticKeepAliveClientMixin<NavigationPage> {
  final PageController _gameController = PageController();
  final PageController _pagesController = PageController(initialPage: 1);

  var _isStatusBarEnabled = true;

  @override
  bool get wantKeepAlive => true;

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
    Game.instance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      backgroundColor: PokerColors.background,
      body: Stack(
        children: [
          PageView(
            controller: _gameController,
            scrollDirection: Axis.vertical,
            children: [
              Column(
                children: [
                  Expanded(
                    child: Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        PageView(
                          controller: _pagesController,
                          children: const [
                            StatisticsPage(),
                            GeneralPage(),
                            BlindPage(),
                          ],
                        ),

                        /// Settings button
                        IconButton(
                          iconSize: 42,
                          padding: const EdgeInsets.all(10),
                          onPressed: _openSettingsPage,
                          icon: const Icon(Icons.settings),
                        ),
                      ],
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
              Stack(
                children: const [
                  /// Game
                  GamePage(),

                  /// Game overlay
                  GameOverlay(),
                ],
              ),
            ],
          ),

          /// Pause border
          IgnorePointer(
            child: ValueListenableBuilder<bool>(
              valueListenable: Game.instance.pause,
              builder: (context, pause, child) {
                return Offstage(
                  offstage: !pause,
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border.fromBorderSide(
                        BorderSide(color: PokerColors.orange, width: 2),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
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

  void _openSettingsPage() {
    Navigator.of(context).pushNamed(SettingsPage.routeName);
  }
}
