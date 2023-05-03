import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/learner.dart';
import '/models/question.dart';

class Database{
  final CollectionReference questionsCollection = FirebaseFirestore.instance.collection('question');
  final CollectionReference topicsCollection = FirebaseFirestore.instance.collection('topics');


  Future<dynamic> getQuestionsByTopic(String topic, int n) async {
    try {
      List<Question> questions = [];

      // Query the Firestore collection for questions with the given topic
      final QuerySnapshot snapshot = await questionsCollection
          .where('topic', isEqualTo: topic)
          .get();

      for (var questionInstance in snapshot.docs) {
        dynamic qstatement = questionInstance.get('statement');
        print("${qstatement.runtimeType},${qstatement.toString()}");

        dynamic optionsList = questionInstance.get('options');
        if (optionsList is String){
          optionsList = List.from (optionsList.split(','));
        }
        print("${optionsList.runtimeType},${optionsList.toString()}");

        questions.add(Question(
            difficulty: questionInstance.get('difficulty'),
            points: questionInstance.get('points'),
            statement: questionInstance.get('statement'),
            options: optionsList,
            correctOption: questionInstance.get('correct')));
      }


      // Randomly select 'n' questions from the list
      if (questions.length <= n) {
        return questions;
      } else {
        questions.shuffle();
        return questions.sublist(0, n);
      }
    } on Exception catch (e) {
      return e.toString();
    }
  }


  Future<dynamic> getBasicTopics() async {
    try {
      List<String> topics = [];

      // Query the Firestore collection for topics
      final QuerySnapshot snapshot = await topicsCollection
      .where('difficulty', isEqualTo: 'Beginner')
      .get();

      // Loop through each document and add the topic to the list
      for (var doc in snapshot.docs) {
        topics.add(doc.get('title'));
      }

      return topics;
    } on Exception catch (e) {
      return e.toString();
    }
  }


  Future<dynamic> getAdvancedTopics() async {
    try {
      List<String> topics = [];

      // Query the Firestore collection for topics
      final QuerySnapshot snapshot = await topicsCollection
          .where('difficulty', isEqualTo: 'Advanced')
          .get();

      // Loop through each document and add the topic to the list
      for (var doc in snapshot.docs) {
        topics.add(doc.get('title'));
      }

      return topics;
    } on Exception catch (e) {
      return e.toString();
    }
  }
}