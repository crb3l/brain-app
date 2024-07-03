import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './quiz.dart';
import './result.dart';
import './story.dart';

class AttentionScreen extends StatefulWidget {
  const AttentionScreen({super.key});

  @override
  State<AttentionScreen> createState() => _AttentionScreenState();
}

class _AttentionScreenState extends State<AttentionScreen> {
  final _story = const [
    {
      'storyTitle': 'Escape',
      'storyText':
          'A lion named Sultan, escaped from its cage, by the door badly closed by a careless guard'
    },
    {
      'storyTitle': 'Sway in the crowd',
      'storyText':
          'The crowd of the visitors numerous on Sunday runs away towards the nearby buildings'
    },
    {
      'storyTitle': 'Woman and child',
      'storyText':
          'A woman, dressed in blue which held in her arms her one-year-old child dropped him.\nThe lion takes it'
    },
    {
      'storyTitle': 'Deal',
      'storyText':
          'The woman retraced his steps, and begged the lion to return her young'
    },
    {
      'storyTitle': 'Escape',
      'storyText':
          'The animal looked at her for a long time, fixedly, and finally released the child without having made for him the slightest evil'
    },
  ];

  final _questions = const [
    {
      'questionText': 'What was the lion\u0027s name?',
      'answers': [
        {'text': 'Szoltan', 'score': -2},
        {'text': 'Sean', 'score': -2},
        {'text': 'Sultan', 'score': 10},
        {'text': 'Singh', 'score': -2},
      ],
    },
    {
      'questionText': 'How was the door closed?',
      'answers': [
        {'text': 'Fixedly', 'score': -2},
        {'text': 'Tightly', 'score': -2},
        {'text': 'Snugly', 'score': -2},
        {'text': 'Badly', 'score': 10},
      ],
    },
    {
      'questionText': 'What day of the week is it?',
      'answers': [
        {'text': 'Saturday', 'score': -2},
        {'text': 'Sunday', 'score': 10},
        {'text': 'Friday', 'score': -2},
        {'text': 'Wednesday', 'score': -2},
      ],
    },
    {
      'questionText': 'Where did the crowd run to?',
      'answers': [
        {'text': 'Towards the buildings', 'score': 10},
        {'text': 'From the buildings', 'score': -2},
        {'text': 'To the market', 'score': -2},
        {'text': 'Towards the lion', 'score': -2},
      ],
    },
    {
      'questionText': 'What color was the woman\u0027s dress?',
      'answers': [
        {'text': 'Red', 'score': -2},
        {'text': 'Blue', 'score': 10},
        {'text': 'Green', 'score': -2},
        {'text': 'Purple', 'score': -2},
      ],
    },
    {
      'questionText': 'How old is the baby?',
      'answers': [
        {'text': 'One month old', 'score': -2},
        {'text': 'One week old', 'score': -2},
        {'text': 'One year old', 'score': 10},
        {'text': 'Two years old', 'score': -2},
      ],
    },
    {
      'questionText': 'What did the woman do to the lion?',
      'answers': [
        {'text': 'Beat him', 'score': -2},
        {'text': 'Yelled at him', 'score': -2},
        {'text': 'Ignored him', 'score': -2},
        {'text': 'Begged him', 'score': 10},
      ],
    },
    {
      'questionText': 'What did the lion do to the woman?',
      'answers': [
        {'text': 'Looked at her', 'score': 10},
        {'text': 'Ate her', 'score': -2},
        {'text': 'Ignored her', 'score': -2},
        {'text': 'Roared at her', 'score': -2},
      ],
    },
    {
      'questionText': 'What did the lion do to the child?',
      'answers': [
        {'text': 'Scared it', 'score': -2},
        {'text': 'Kidnapped it', 'score': -2},
        {'text': 'Ate it', 'score': -2},
        {'text': 'Not even the slightest evil', 'score': 10},
      ],
    },
  ];

  var _questionIndex = 0;
  var _storyIndex = 0;
  var _totalScore = 0;
  bool _canShowQuestions = false;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
      _storyIndex = 0;
      _canShowQuestions = false;
    });
  }

  void _answerQuestion(int score) {
    setState(() {
      _totalScore += score;

      _questionIndex = _questionIndex + 1;
    });
    // ignore: avoid_print
    print(_questionIndex);
    if (_questionIndex < _questions.length) {
      // ignore: avoid_print
      print('We have more questions!');
    } else {
      // ignore: avoid_print
      print('No more questions!');
    }
  }

  void _incrementStoryIndex() {
    setState(() {
      _storyIndex++;
      _canShowQuestions = _storyIndex == _story.length - 1;
    });

    // if (_storyIndex == _story.length - 1) {
    //   setState(() {
    //     _canShowQuestions = true;
    //   });
    // }
  }

  Widget _showQuestionOrResult() {
    if (_storyIndex < _story.length) {
      return Story(_canShowQuestions,
          advanceStory: _incrementStoryIndex,
          story: _story,
          storyIndex: _storyIndex);
    } else if (_questionIndex < _questions.length) {
      return Quiz(
          answerQuestion: _answerQuestion,
          questionIndex: _questionIndex,
          questions: _questions);
    } else {
      return Result(resultScore: _totalScore, resetHandler: _resetQuiz);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pay attention.'),
        backgroundColor: const Color(0xFFef7c29),
      ),
      body: Padding(
          padding: const EdgeInsets.all(30.0), child: _showQuestionOrResult()),
    );
  }
}
