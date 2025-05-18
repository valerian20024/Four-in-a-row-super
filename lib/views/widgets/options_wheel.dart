import 'package:flutter/material.dart';
import 'package:four_in_a_row_super/controllers/game_controller.dart';
import 'package:four_in_a_row_super/views/styles/app_colors.dart';
import 'package:provider/provider.dart';

/*
  This widget is the cogwheel we find when playing a game.
  The players can push it to display a popup menu.
*/

class OptionsWheel extends StatefulWidget {
  const OptionsWheel({super.key});

  @override
  State<OptionsWheel> createState() => _OptionsWheelState();
}

class _OptionsWheelState extends State<OptionsWheel> {
  @override
  Widget build(BuildContext context) {
    final gameController = Provider.of<GameController>(context);

    return (Align(
      alignment: Alignment.topRight,
      child: PopupMenuButton<int>(
        icon: const Icon(
          Icons.settings,
          color: AppColors.lightGrey,
          size: 40,
        ),
        onSelected: (value) {
          switch (value) {
            case 0:
              gameController.resetGame(); // Reset the game
              break;
            case 1:
              gameController
                  .resetGame(); // Otherwise, we will have the game state saved
              Navigator.popUntil(context, ModalRoute.withName('/home'));
              break;
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 0,
            child: Text("Reset Game"), //todo improve look of drop down menu
          ),
          const PopupMenuItem(
            value: 1,
            child: Text("Back to Menu"),
          ),
        ],
      ),
    ));
  }
}
