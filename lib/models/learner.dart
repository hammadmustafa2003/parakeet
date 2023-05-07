import 'package:cloud_firestore/cloud_firestore.dart';

class Learner {
  final String username;
  final String email;
  final String name;
  final int points;
  final String rank;

  Learner({
    required this.username,
    required this.email,
    required this.name,
    required this.points,
    required this.rank,
  });

  factory Learner.fromJson(Map<String, dynamic> json) {
    return Learner(
      username: json['username'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      points: json['points'] as int,
      rank: json['rank'] as String,
    );
  }

  factory Learner.fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;

    return Learner(
      username: data['username'] ?? '',
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      points: data['points'] ?? 0,
      rank: data['rank'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'name': name,
      'points': points,
      'rank': rank,
    };
  }

  // function to get all learners from firebase
  static Future<List<Learner>> getAllLearners() async {
    List<Learner> learners = [];
    await FirebaseFirestore.instance
        .collection('learner')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        learners.add(Learner.fromSnapshot(doc));
      });
    });
    return learners;
  }

  // function to get all learners except the current user from firebase
  static Future<List<Learner>> getLearner(String username) async {
    List<Learner> learners = [];
    await FirebaseFirestore.instance
        .collection('learner')
        .where('username', isNotEqualTo: username)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        learners.add(Learner.fromSnapshot(doc));
      });
    });
    return learners;
  }

  // get a learner by username
  static Future<Learner> getLearnerByUsername(String username) async {
    Learner learner = Learner(
      username: '',
      email: '',
      name: '',
      points: 0,
      rank: '',
    );
    await FirebaseFirestore.instance
        .collection('learner')
        .where('username', isEqualTo: username)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        learner = Learner.fromSnapshot(doc);
      });
    });
    return learner;
  }
}
