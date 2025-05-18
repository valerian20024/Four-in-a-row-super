import 'package:flutter/material.dart';
import 'package:four_in_a_row_super/controllers/player_controller.dart';
import 'package:four_in_a_row_super/views/styles/app_colors.dart';
import 'package:four_in_a_row_super/views/styles/text_style.dart';
import 'package:four_in_a_row_super/views/widgets/buttons.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

/*
  This widget allows the user to change the name of the players
  in the settings page.
*/

class PlayerNameTextfield extends StatelessWidget {
  final int playerID;
  final String text;
  final int maxLength;

  const PlayerNameTextfield({
    super.key,
    required this.playerID,
    this.text = '',
    this.maxLength = 10, // max length for name
  });

  @override
  Widget build(BuildContext context) {
    final PlayerController playerController =
        Provider.of<PlayerController>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: (TextField(
        decoration: const InputDecoration(
          filled: true,
          fillColor: AppColors.white,
          border: OutlineInputBorder(),
          //hintText: 'Enter a search term',
          labelText: 'Change Name',
        ),
        maxLength: maxLength,
        style: BlackTextStyle.mediumText,
        onSubmitted: (String value) {
          playerController.setPlayerName(playerID, value);
        },
      )),
    );
  }
}

/*
  This widget contains the settings for a player, i.e. its name
  and color.
*/

class PlayerSettings extends StatelessWidget {

  Color _darkenColor(Color color, [double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1, 'Amount must be between 0 and 1');

    final hsl = HSLColor.fromColor(color);
    final darkened =
        hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return darkened.toColor();
  }

  void _changePlayerColor(PlayerController playerController, int id) {
    Color newColor =
        Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    playerController.setPlayerColor(id, newColor);
  }

  final int playerID;

  const PlayerSettings({
    super.key,
    required this.playerID,
  });

  @override
  Widget build(BuildContext context) {
    final PlayerController playerController =
        Provider.of<PlayerController>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: (Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: playerController.getPlayerColor(playerID),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'Player ${playerID + 1}',
                style: HeadingTextStyle.smallHeading,
              ),
            ),
            PlayerNameTextfield(playerID: playerID),
            Button(
              f: () => _changePlayerColor(playerController, playerID),
              style: ElevatedButton.styleFrom(
                backgroundColor: _darkenColor(
                    playerController.getPlayerColor(playerID), 0.2),
                textStyle: HeadingTextStyle.mediumHeading,
              ),
              text: 'Change player ${playerID + 1} color!',
              textStyle: HeadingTextStyle.mediumHeading,
            ),
          ],
        ),
      )),
    );
  }
}
