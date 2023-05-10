

import 'package:flutter/material.dart';

import 'home.dart';
import 'models/learner.dart';

class ScorePage extends StatelessWidget {
  final int score;
  final Learner learner;

  ScorePage({required this.score, required this.learner});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 255, 255, 1),
      appBar: AppBar(
        automaticallyImplyLeading: true,
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
          children: [
            Text(
              score > 6 ? 'Congratulations, you got' : 'Keep up, you got',
              style: const TextStyle(
                  fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32.0),
            Container(
              height: 200.0,
              width: 200.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: Center(
                child: Text(
                  score.toString(),
                  style: const TextStyle(fontSize: 80.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(learner: learner),
                  ),
                );
              },
              child: const Text('Return to Home'),
            ),
          ],
        ),
      ),
    );
  }
}