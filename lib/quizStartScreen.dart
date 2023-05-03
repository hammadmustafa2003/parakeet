import 'package:flutter/material.dart';
import 'quiz.dart';

class QuizStartScreen extends StatefulWidget {
  QuizStartScreen({Key? key, required this.title}) : super(key: key);

  var title;

  @override
  _QuizStartScreenState createState() => _QuizStartScreenState(title: title);
}

class _QuizStartScreenState extends State<QuizStartScreen> {
  var title;
  _QuizStartScreenState({required this.title});

  bool _startButtonEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 255, 255, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/icon.png',
              fit: BoxFit.contain,
              height: 30,
            ),
            const Padding(
                padding: EdgeInsets.only (top:6.0),
                // padding: const EdgeInsets.all(5.0),
                child: Text(
                  'arekeet',
                  style: TextStyle( color: Colors.blue, fontSize: 30, fontFamily: 'font1') ,
                )
            )
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Tap to start quiz',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24.0),
            GestureDetector(
              onTap: _startButtonEnabled ? _startQuiz : null,
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: _startButtonEnabled ? Colors.blue : Colors.grey,
                  borderRadius: BorderRadius.circular(100.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 48.0),
                child: const Padding(
                  padding: EdgeInsets.only(top:45),
                  child: Text(
                    'Start',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startQuiz() {
    // Call your function here that starts the quiz
    print('Quiz started');
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QuizPage(topic: title)),
    );
  }
}