import 'package:flutter/material.dart';
import 'package:four_in_a_row_super/controllers/game_controller.dart';
import 'package:four_in_a_row_super/views/styles/app_colors.dart';
import 'package:provider/provider.dart';

/*
  This widget is the box containing the power up image
  in the gameboard.
*/

class PowerUpContainers extends StatelessWidget {
  final int id; // its id in the row
  final int player; // the player it belongs to

  const PowerUpContainers({
    super.key,
    required this.id,
    required this.player,
  });

  String _getAsset(GameController gc) {
    String bombAssetPath = "assets/images/bomb.png";
    String playTwiceAssetPath = "assets/images/coins.png";
    String blankAssetPath = "assets/images/blank.png";

    int powerUpId = gc.getPowerUpId(player, id);
    switch (powerUpId) {
      case -1: // empty power up
        return blankAssetPath;
      case 0: // bomb
        return bombAssetPath;
      case 1: // play twice
        return playTwiceAssetPath;
      default:
        throw Exception("_getAsset: no such id is possible");
    }
  }

  void _handleTap(GameController gc) {
    gc.selectPowerUp(id, player);
    return;
  }

  Color _borderColor(GameController gc) {
    int selectedPowerUpId = gc.getSelectedPowerUp(player);

    if (selectedPowerUpId == id) {
      return AppColors.white;
    }
    return AppColors.transparentWhite;
  }

  @override
  Widget build(BuildContext context) {
    GameController gc = Provider.of<GameController>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => _handleTap(gc),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.invisibleBlack,
            border: Border.all(
              color: _borderColor(gc),
              width: 3.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              _getAsset(gc),
              width: 40,
              height: 40,
            ),
          ),
        ),
      ),
    );
  }
}
