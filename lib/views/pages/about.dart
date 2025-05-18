import 'package:flutter/material.dart';
import 'package:four_in_a_row_super/views/widgets/appbars.dart';
import 'package:four_in_a_row_super/views/widgets/text_boxes.dart';
import '../styles/app_colors.dart';
import '../widgets/bottombars.dart';

/*
  This page is mostly text about the app itself.
*/

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: SimpleAppBar(title: 'About'),
      backgroundColor: AppColors.lightBlue,
      bottomNavigationBar: BackBottomBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DescriptionBox(
                  width: 300,
                  text:
                      'This software is part of the course “OOP on Mobile devices” taught in ULiege.'),
              SizedBox(height: 20.0),
              DescriptionBox(
                width: 300,
                text:
                    'The developers team is composed of:\nAudric\nValérian\nSpecial thanks to Nyota Buduli Masirika for her help.',
              ),
              SizedBox(height: 20.0),
              DescriptionBox(
                width: 300,
                text: 'Buy us a coffee to support the app!',
              ),
              SizedBox(
                height: 20.0,
              ),
              DescriptionBox(
                  width: 300,
                  text:
                      '''If you want to know the rules, check out the Rules button when choosing a way to play.'''),
            ],
          ),
        ),
      ),
    );
  }
}
