import 'package:flutter/material.dart';
import 'TutorialScreen.dart';
import 'home.dart';
class TutorialTopicPage extends StatefulWidget {
  const TutorialTopicPage({Key? key}) : super(key: key);

  @override
  _tutorialTopicPage_State createState() => _tutorialTopicPage_State();
}

class _tutorialTopicPage_State extends State<TutorialTopicPage> {
  bool _isBasicExpanded = false;
  bool _isAdvancedExpanded = false;

  final List<String> _basicList = [
    'Basic Option 1',
    'Basic Option 2',
    'Basic Option 3',
  ];
  final List<String> _advancedList = [
    'Advanced Option 1',
    'Advanced Option 2',
    'Advanced Option 3',
    'Advanced Option 4',
  ];

  void loadTutorial(String item) {
    print('Selected item: $item');

    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TutorialScreen(topic: item)),
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
        onTap: () {loadTutorial(item);},
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
    return Scaffold(
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
                      MaterialPageRoute(builder: (context) => const HomeScreen(key: Key('home')))
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
                  //TODO: Add profile page
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
              "What do you want to learn !",
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