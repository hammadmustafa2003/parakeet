import 'package:flutter/material.dart';
import '/services/database.dart';
import '/models/question.dart';
import 'loading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'quizScore.dart';
import 'models/learner.dart';

class QuizPage extends StatefulWidget {
  final Learner learner;
  final String topic;

  QuizPage({super.key, required this.topic, required this.learner});

  @override
  State<QuizPage> createState() => _QuizPageState();
}


class _QuizPageState extends State<QuizPage> {
  // List<bool> _selectedOption = List.filled(5, false);

  List<int> _selectedOption = [];
  List<Question> _questions = [];
  bool _loading = false;
  Database db = Database();


  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    setState(() {
      _loading = true;
    });
    _questions = await db.getQuestionsByTopic(widget.topic, 10);
    setState(() {
      _loading = false;
      _selectedOption = List.filled(_questions.length, -1);
    });
  }

  void _handleRadioValueChanged(int index, int optionIndex) {
    setState(() {
      _selectedOption[index] = optionIndex;
    });
  }

  Future<void> _submitForm() async {
    //TODO:Add marking quiz logic here
    int marks = 0;
    for(int i=0; i<_selectedOption.length; i++){
      print('selected option: ${_selectedOption[i]}, correct option: ${_questions[i].correctOption}');
      if(_selectedOption[i] == _questions[i].correctOption){
        marks++;
      }
    }

    setState(() {
      _loading = true;
    });
    await db.saveQuizHistory(widget.learner.username, widget.topic, marks);

    if (context.mounted) {
      setState(() {
        _loading = false;
      });
      Fluttertoast.showToast(msg: "You scored $marks out of ${_selectedOption.length}");
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ScorePage(score: marks, learner: widget.learner)),
      );
    }


  }

  @override
  Widget build(BuildContext context) {
    return _loading? Loading() :Scaffold(
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Column(
            children: [
              ..._questions.asMap().entries.map((entry) {
                int index = entry.key;
                Question question = entry.value;
                return Card(
                  borderOnForeground: false,
                  margin: const EdgeInsets.all(16.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Question ${index + 1}: ${question.statement}',
                          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 16.0),
                        ...question.options.asMap().entries.map((entry) {
                          int optionIndex = entry.key;
                          String optionText = entry.value.toString();
                          return RadioListTile<int>(
                            title: Text(optionText, style: const TextStyle(fontWeight: FontWeight.w600),),
                            value: optionIndex,
                            groupValue: _selectedOption[index],
                            onChanged: (value) =>
                                _handleRadioValueChanged(index, value!),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                );
              }).toList(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 70),
            child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 16),
                    shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
                    elevation: 20
                ),
                child: const Text('Submit', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),)
            ),
          ),
            ],
          ),
        ),
      ),
    );

  }


}