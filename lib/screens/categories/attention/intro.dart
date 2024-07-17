import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Intro extends StatelessWidget {
  final Function advanceIntro;

  const Intro({required this.advanceIntro, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Instructions', style: TextStyle(fontSize: 32)),
        const SizedBox(
          height: 50,
        ),
        Card(
          color: const Color(0xFFef7c29),
          shadowColor: Colors.black,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Pay attention to the following story. After you finish reading a chapter press the button to advance to the next one.\n\nThere is no turning back.\nQuestions await.\nRead carefully.\nGood luck!',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        const SizedBox(
          height: 100,
        ),
        ElevatedButton(
          onPressed: () => advanceIntro(),
          style: ButtonStyle(
              textStyle:
                  WidgetStateProperty.all(const TextStyle(color: Colors.white)),
              backgroundColor:
                  WidgetStateProperty.all(const Color(0xFFef7c29))),
          child: const Text(
            'To the story!',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
