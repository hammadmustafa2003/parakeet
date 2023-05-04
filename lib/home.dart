import 'package:flutter/material.dart';
import 'tutorialTopics.dart';
import 'quizTopics.dart';
import 'package:flutter/services.dart';
import 'models/learner.dart';
import 'profile.dart';

class HomeScreen extends StatelessWidget {
  final Learner learner;
  const HomeScreen({Key? key, required this.learner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.blue,
                size: 30,
              ),
              onPressed: () {
                // Navigator.pop(context);
                SystemNavigator.pop();
              },
            ),

            Center(
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/icon.png',
                    fit: BoxFit.contain,
                    height: 30,
                  ),
                  const Padding(
                      padding: EdgeInsets.only (right: 6, top: 10),
                      // padding: const EdgeInsets.all(5.0),
                      child: Text(
                        'arekeet',
                        style: TextStyle( color: Colors.blue, fontSize: 30, fontFamily: 'font1') ,
                      )
                  )
                ],
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.person_rounded,
                color: Colors.blue,
                size: 30,
              ),
              onPressed: () {
                //TODO: Add profile page
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage(learner: learner,)),
                );
              },
            ),
          ]
      ),
    ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        padding: const EdgeInsets.all(12.0),
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        children: <Widget>[
          _buildTile('Tutorial', Icons.book, Colors.blue, context, TutorialTopicPage(learner: learner,)),
          _buildTile('Quiz', Icons.question_answer, Colors.green, context, QuizTopicPage(learner: learner,)),
          _buildTile( 'Public Thread', Icons.forum, Colors.orangeAccent, context, TutorialTopicPage(learner: learner,)),
          _buildTile( 'Chat', Icons.chat, Colors.purple, context, TutorialTopicPage(learner: learner,)),
          _buildTile( 'Chat', Icons.chat, Colors.purple, context, const ChatHomeScreen()),
        ]
      ),
    );
  }

  Widget _buildTile(String title, IconData icon, Color color,  BuildContext context, dynamic route) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => route),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.all(7),
        padding: const EdgeInsets.all(15),
        child: Stack(
          children: [
            Opacity(
              opacity: 0.2,
              child: Icon(
                icon,
                size: 90,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 50,
                  color: Colors.white,
                ),
                const SizedBox(height: 20),
                Text(
                  title,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Colors.white)
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
