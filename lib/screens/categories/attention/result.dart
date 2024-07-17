import 'package:flutter/material.dart';
import 'package:bigbrain/screens/home_screen.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final VoidCallback resetHandler;

  const Result(
      {super.key, required this.resultScore, required this.resetHandler});

  //Remark Logic
  String get resultPhrase {
    String resultText;
    if (resultScore >= 70) {
      resultText = 'Awesome!';
      print(resultScore);
    } else if (resultScore >= 60) {
      resultText = 'Pretty good!';
      print(resultScore);
    } else if (resultScore >= 40) {
      resultText = 'You need more practice!';
    } else if (resultScore >= 1) {
      resultText = 'You definitely need more practice!';
    } else {
      resultText = 'What happened?';
      print(resultScore);
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            resultPhrase,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Text(
            'Score ' '$resultScore' '/90',
            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 100),
          ElevatedButton(
            onPressed: resetHandler,
            style: ButtonStyle(
                textStyle: WidgetStateProperty.all(
                    const TextStyle(color: Colors.white)),
                backgroundColor:
                    WidgetStateProperty.all(const Color(0xFFef7c29))),
            child: const Text(
              'Restart Quiz',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            style: ButtonStyle(
                textStyle: WidgetStateProperty.all(
                    const TextStyle(color: Colors.white)),
                backgroundColor:
                    WidgetStateProperty.all(const Color(0xFFef7c29))),
            child: const Text(
              'To home',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
