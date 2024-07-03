import 'package:flutter/material.dart';

class Chapter extends StatelessWidget {
  final String chapterText;
  final TextStyle _style;
  const Chapter(this.chapterText, this._style, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      child: Text(
        chapterText,
        style: _style,
        textAlign: TextAlign.center,
      ),
    );
  }
}
