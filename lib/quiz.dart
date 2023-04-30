import 'package:flutter/material.dart';
import 'signup.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key, required this.title});
  final String title;
  @override
  State<QuizPage> createState() => _QuizPageState();
}


class Question {
  final String text;
  final List<String> options;

  Question(this.text, this.options);
}


class _QuizPageState extends State<QuizPage> {
  // List<bool> _selectedOption = List.filled(5, false);

  List<int> _selectedOption = [];
  List<Question> _questions = [];

  @override
  void initState() {
    super.initState();
    final List<String> questionsStatements = [
      'What is the capital of France?',
      'What is the highest mountain in the world?',
      'What is the largest country in the world?',
      'What is the currency of Japan?',
      'What is the chemical symbol for gold?',
    ];

    final List<List<String>> questionOptions = [
      ['Paris', 'London', 'Madrid', 'Berlin'],
      ['Mount Kilimanjaro', 'Mount Everest', 'Mount Fuji', 'Mount McKinley'],
      ['Russia', 'China', 'Canada', 'Australia'],
      ['Dollar', 'Euro', 'Yen', 'Pound'],
      ['Au', 'Ag', 'Cu', 'Fe'],
    ];

    for (int i = 0; i < questionsStatements.length; i++) {
      _questions.add(Question(questionsStatements[i], questionOptions[i]));
    }
    _selectedOption = List<int>.generate(_questions.length, (index) => -1);
  }

  void _handleRadioValueChanged(int index, int optionIndex) {
    setState(() {
      _selectedOption[index] = optionIndex;
    });
  }

  void _submitForm() {
    //TODO:Add marking quiz logic here
    print(_selectedOption);
  }

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
                          'Question ${index + 1}: ${question.text}',
                          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 16.0),
                        ...question.options.asMap().entries.map((entry) {
                          int optionIndex = entry.key;
                          String optionText = entry.value;
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
