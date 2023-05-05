import 'package:flutter/material.dart';
import 'package:parakeet/profile.dart';
import 'quizStartScreen.dart';
import 'home.dart';
import 'models/learner.dart';
import '/services/database.dart';
import 'loading.dart';

class QuizTopicPage extends StatefulWidget {
  final Learner learner;
  const QuizTopicPage({Key? key, required this.learner}) : super(key: key);

  @override
  _quizTopicPage_State createState() => _quizTopicPage_State();
}

class _quizTopicPage_State extends State<QuizTopicPage> {
  bool _loading = false;
  bool _isBasicExpanded = false;
  bool _isAdvancedExpanded = false;

  late List<String> _basicList;
  late List<String> _advancedList;


  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    Database db = Database();
    setState(() {
      _loading = true;
    });
    _basicList = await db.getBasicTopics();
    _advancedList = await db.getAdvancedTopics();

    setState(() {
      _loading = false;
    });
  }

  void loadQuiz(String item) {
    print('Selected item: $item');

    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QuizStartScreen(title: item, learner: widget.learner,)),
    );
  }

  Widget _buildSubListItem(String item) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.5,
          ),
        ),
      ),
      child: ListTile(
        title: Text(item),
        onTap: () {loadQuiz(item);},
      ),
    );
  }

  Widget _buildSubList(List<String> list) {
    return Column(
      children: list.map((item) {
        return _buildSubListItem(item);
      }).toList(),
    );
  }

  Widget _buildBasicList() {
    return Column(
      children: [
        ListTile(
          title: const Text(
            'Basic',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          trailing: IconButton(
            icon: Icon(
              _isBasicExpanded ? Icons.expand_less : Icons.expand_more,
              size: 30,
            ),
            onPressed: () {
              setState(() {
                _isBasicExpanded = !_isBasicExpanded;
              });
            },
          ),
        ),
        if (_isBasicExpanded) _buildSubList(_basicList),
      ],
    );
  }

  Widget _buildAdvancedList() {
    return Column(
      children: [
        ListTile(
          title: const Text(
            'Advanced',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          trailing: IconButton(
            icon: Icon(
              _isAdvancedExpanded ? Icons.expand_less : Icons.expand_more,
              size: 30,
            ),
            onPressed: () {
              setState(() {
                _isAdvancedExpanded = !_isAdvancedExpanded;
              });
            },
          ),
        ),
        if (_isAdvancedExpanded) _buildSubList(_advancedList),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _loading? Loading() :Scaffold(
      backgroundColor: const Color.fromRGBO(240, 255, 255, 1),
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
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen(key: const Key('home'), learner: widget.learner,))
                  );
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
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage(key: Key('home'), learner: widget.learner))
                  );
                },
              ),
            ]
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 20, top: 20),
            child: Text(
              "Select the topic for quiz !",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildBasicList(),
                  _buildAdvancedList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}