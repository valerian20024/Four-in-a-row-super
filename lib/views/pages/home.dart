import 'package:flutter/material.dart';
import 'package:four_in_a_row_super/views/widgets/falling_checkers.dart';
import '../styles/app_colors.dart';
import '../styles/text_style.dart';
import '../widgets/buttons.dart';
import '../styles/button_style.dart';
import '../../models/other/exit_application.dart';

/*
  This page is the Homepage of the app, hence from where everything begins.
  User can choose to play a game, go to settings, see the about page, or exit the app.
*/

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlue,
      body: Stack(children: [
        FallingCheckerAnimation(),
        FallingCheckerAnimation(),
        FallingCheckerAnimation(),
        FallingCheckerAnimation(),
        FallingCheckerAnimation(),
        FallingCheckerAnimation(),
        FallingCheckerAnimation(),
        FallingCheckerAnimation(),
        FallingCheckerAnimation(),
        FallingCheckerAnimation(),
        Center(
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Text(
                        'Four-in-a-row',
                        style: MainAppTextStyle.appTitle,
                      ),
                    ),
                    Positioned(
                      left: 260,
                      top: 45,
                      child: Transform.rotate(
                        angle: -0.25, // [radians]
                        child: const Text(
                          'super',
                          style: MainAppTextStyle.appSubTitle,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40.0),

                // * Play button
                Button(
                  f: () => Navigator.pushNamed(context, '/playhome'),
                  style: MainMenuButtonStyles.playButton,
                  text: 'Play',
                  textStyle: ButtonsTextStyle.homepageButton,
                ),

                const SizedBox(height: 10.0),

                // * Settings button
                Button(
                  f: () => Navigator.pushNamed(context,
                      '/settings'), // Navigator.pushNamed(context, '/settings'),
                  style: MainMenuButtonStyles.settingsButton,
                  text: 'Settings',
                  textStyle: ButtonsTextStyle.homepageButton,
                ),

                const SizedBox(height: 10.0),

                // * About button
                Button(
                  f: () => Navigator.pushNamed(context, '/about'),
                  style: MainMenuButtonStyles.aboutButton,
                  text: 'About',
                  textStyle: ButtonsTextStyle.homepageButton,
                ),

                const SizedBox(height: 10.0),

                // * Exit button
                Button(
                  f: () => AppExitManager.confirmExitApp(context),
                  style: MainMenuButtonStyles.exitButton,
                  text: 'Exit',
                  textStyle: ButtonsTextStyle.homepageButton,
                ),

                const SizedBox(height: 20.0),

                const Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    'Build version 1.0.0+1',
                    style: WhiteTextStyle.homepageBuildText,
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
