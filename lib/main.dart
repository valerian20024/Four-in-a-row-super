import 'package:flutter/material.dart';
import 'package:four_in_a_row_super/controllers/player_controller.dart';
import 'package:four_in_a_row_super/controllers/scenario_controller.dart';
import 'package:four_in_a_row_super/views/pages/about.dart';
import 'package:four_in_a_row_super/views/pages/classic_game_choice.dart';
import 'package:four_in_a_row_super/views/pages/rules.dart';
import 'package:four_in_a_row_super/views/pages/scenario.dart';
import 'package:four_in_a_row_super/views/pages/settings.dart';
import 'views/pages/home.dart';
import 'package:provider/provider.dart';
import 'controllers/game_controller.dart';
import 'views/pages/gameboard.dart';
import 'views/pages/game_choice.dart';
import 'views/pages/number_players.dart';
import 'views/pages/difficulty_choice.dart';

/*
  This file contains the basic methods for flutter applications and
  contains routing.
*/

void main() {
  ScenarioController sc = ScenarioController();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => GameController(scenarioController: sc)),
        ChangeNotifierProvider(create: (_) => PlayerController()),
        ChangeNotifierProvider(create: (_) => sc),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Four-in-a-row',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // todo find better names for the routes
      initialRoute: '/home',
      routes: {
        '/home':                  (context) => const HomeView(),
        '/game':                  (context) => const GameBoardView(),
        '/playhome':              (context) => const PlayHomeView(),
        '/scenario':              (context) => const ScenarioView(),
        '/about':                 (context) => const AboutView(),
        '/settings':              (context) => const SettingsView(),
        '/classic_game_choice':   (context) => const ClassicalGameChoiceView(),
        '/number_players':        (context) => const NumberOfPlayersView(),
        '/rules':                 (context) => const RulesView(),
        '/difficulty':            (context) => const DifficultyChoiceView(),
      },
    );
  }
}
