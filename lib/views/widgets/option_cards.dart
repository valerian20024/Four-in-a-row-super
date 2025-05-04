import 'package:flutter/material.dart';
import 'package:four_in_a_row_super/views/widgets/text_boxes.dart';
import '../styles/text_style.dart';

/*
  This file implements various classes that correspond to 
  Containers that can be tapped to perform an action in
  the menu of the application.
*/

// A clickable container with text written on it.
class SelectableCard extends StatelessWidget {
  final Function f;
  final Color color;
  final String text;
  final double size; // size = width = height of container

  const SelectableCard(
      {super.key,
      required this.f,
      required this.color,
      required this.text,
      required this.size});

  @override
  Widget build(BuildContext context) {
    return (GestureDetector(
        onTap: () => f(),
        child: Container(
            padding:
                const EdgeInsets.all(20.0), // between text and the boundary
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10.0),
            ),
            width: size,
            height: size,
            child: Center(
              child: Text(
                textAlign: TextAlign.center,
                text,
                style: HeadingTextStyle.mediumHeading,
              ),
            ))));
  }
}

// Contains a SelectableCard and a text description. Typically found
// in the Number Of Players View.
class OptionCard extends StatelessWidget {
  final double width;
  final double height;
  final String description;
  final String title;
  final Color color;
  final Function f;

  const OptionCard(
      {super.key,
      required this.width,
      required this.height,
      required this.description,
      required this.title,
      required this.color,
      required this.f});

  @override
  Widget build(BuildContext context) {
    return (SizedBox(
      width: width,
      height: height,
      child: Column(
        children: [
          SelectableCard(
            f: f,
            color: color,
            text: title,
            size: width,
          ),
          const SizedBox(
            height: 10,
          ),
          DescriptionBox(width: width - 10, text: description)
        ],
      ),
    ));
  }
}
