import 'package:flutter/material.dart';
import 'package:four_in_a_row_super/views/widgets/player_turn_panel.dart';
import '../styles/app_colors.dart';
import '../styles/text_style.dart';

/*
  This widget is an appbard that simply displays a title.
*/

class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const SimpleAppBar({super.key, required this.title});

  // this is required is order to call an appbar from somewhere else
  @override
  Size get preferredSize =>
      const Size.fromHeight(50); // basically modifies appbar's height

  @override
  Widget build(BuildContext context) {
    return (AppBar(
      title: Text(
        title,
        style: HeadingTextStyle.mediumHeading,
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.darkBlue,
      foregroundColor: AppColors.white,
    ));
  }
}

/*
  This widget is an appbar with a title and a subtitle.
*/

class DoubleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subTitle;

  const DoubleAppBar({super.key, required this.title, required this.subTitle});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return (AppBar(
      title: Column(
        children: [
          Text(
            title,
            style: HeadingTextStyle.mediumHeading,
          ),
          Text(
            subTitle,
            style: HeadingTextStyle.smallHeading,
          ),
        ],
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.darkBlue,
      foregroundColor: AppColors.white,
    ));
  }
}


/*
  This widget is an upper bar displayed in the gameboard.
  It contains the players' turn.
  It's not properly an appbar but behaves the same way.
*/
class SimpleGameBoardUpperBar extends StatelessWidget
    implements PreferredSizeWidget {
  const SimpleGameBoardUpperBar({super.key});

  @override
  Widget build(BuildContext context) {
    return (Container(
      color: AppColors.darkBlue,
      child: const Column(children: [
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            PlayerTurnPanel(player: 0),
            PlayerTurnPanel(player: 1),
          ],
        ),
        SizedBox(
          height: 20,
        )
      ]),
    ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

/*
  This upper bar (a pseudo appbar) will contain data of players (name, color, points) when using
  a scoring point rule. Will talk to playerController and GameController. Is instantiated by the
  gameboard.
*/
class PointsGameBoardUpperBar extends StatelessWidget
    implements PreferredSizeWidget {
  const PointsGameBoardUpperBar({super.key});

  @override
  Widget build(BuildContext context) {
    return (Container(
      color: AppColors.darkBlue,
      child: const Column(children: [
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            PlayerScorePanel(player: 0),
            PlayerScorePanel(player: 1),
          ],
        ),
        SizedBox(
          height: 20,
        )
      ]),
    ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(110);
}
