import 'package:flutter/material.dart';
import './chapter.dart';

// ignore: must_be_immutable
class Story extends StatelessWidget {
  final List<Map<String, Object>> story;
  final int storyIndex;
  final Function advanceStory;
  bool _canShowQuestions = false;

  Story(this._canShowQuestions,
      {required this.advanceStory,
      required this.story,
      required this.storyIndex,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Chapter(story[storyIndex]['storyTitle'].toString(),
            const TextStyle(fontSize: 32)),
        const SizedBox(
          height: 50,
        ),
        Chapter(story[storyIndex]['storyText'].toString(),
            const TextStyle(fontSize: 20)),
        const SizedBox(
          height: 100,
        ),
        ElevatedButton(
          onPressed: () => advanceStory(),
          style: ButtonStyle(
              textStyle:
                  WidgetStateProperty.all(const TextStyle(color: Colors.white)),
              backgroundColor:
                  WidgetStateProperty.all(const Color(0xFFef7c29))),
          child: Text(
            _canShowQuestions ? 'To the questions' : 'Next Chapter',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
