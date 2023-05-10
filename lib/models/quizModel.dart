import 'question.dart';
import '/services/database.dart';

class Quiz {
  final List<Question> questions;
  final String topic;

  Quiz( this.topic, this.questions);
}
