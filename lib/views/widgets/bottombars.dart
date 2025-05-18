import 'package:flutter/material.dart';
import 'package:four_in_a_row_super/views/widgets/power_up_containers.dart';
import 'package:four_in_a_row_super/views/widgets/reset_slider_auto.dart';
import '../styles/app_colors.dart';
import 'buttons.dart';

/*
  This file implements different "bottombars" (a widget used in the Scaffold widget,
  which is used throughly to structure the screen throughout the app).

  In general, a bottom bar consists of a set of predefined buttons that do specific
  actions (e.g. 'Back', or 'Rules').
  But it contains also bottom bars used when playing a game, hence containing powerups
  (custom game) or just a reset slider (classic game)
*/

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return (Container(
        height: 90,
        color: AppColors.darkBlue,
        child: SafeArea(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppBackButton(),
            const SizedBox(
              width: 20,
            ),
            AcceptButton(f: () => debugPrint("im f")),
          ],
        ))));
  }
}


/*
  This widget is the bottom bar that contains only a back button.
*/
class BackBottomBar extends StatelessWidget {
  const BackBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return (Container(
        height: 90,
        color: AppColors.darkBlue,
        child: const SafeArea(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: AppBackButton(),
            ),
          ],
        ))));
  }
}


/*
  This widget is the bottom bar that contains the back button
  and the rules button.
*/
class RulesBottomBar extends StatelessWidget {
  const RulesBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return (Container(
        height: 90,
        color: AppColors.darkBlue,
        child: const SafeArea(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: AppBackButton(),
            ),
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: RulesButton(),
            ),
          ],
        ))));
  }
}

/*
  This widget is the bottom bar that appears when playing a game.
  It contains only a reset slider. It is meant to be built for
  games that don't use power ups.
*/
class SimpleGameBottomBar extends StatelessWidget {
  final Function resetFunction;

  const SimpleGameBottomBar({
    super.key,
    required this.resetFunction,
  });

  @override
  Widget build(BuildContext context) {
    return (Container(
      height: 90,
      color: AppColors.darkBlue,
      child: ResetSliderAuto(onReset: resetFunction),
    ));
  }
}

/*
  This widget is the bottom bar that appears when playing a game.
  It contains a reset slider and the power up inventories.
  It is meant to be built for games that use power ups.
*/
class PowerUpGameBottomBar extends StatelessWidget {
  final Function resetFunction;

  const PowerUpGameBottomBar({
    super.key,
    required this.resetFunction,
  });

  @override
  Widget build(BuildContext context) {
    return (Container(
      height: 150,
      color: AppColors.darkBlue,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ResetSliderAuto(onReset: resetFunction),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PowerUpContainers(id: 0, player: 0),
                    PowerUpContainers(id: 1, player: 0),
                  ],
                ),
              ),
              const SizedBox(
                height: 80,
                child: VerticalDivider(
                  color: AppColors.transparentWhite,
                  thickness: 2.0,
                ),
              ),
              Container(
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PowerUpContainers(id: 0, player: 1),
                    PowerUpContainers(id: 1, player: 1),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
