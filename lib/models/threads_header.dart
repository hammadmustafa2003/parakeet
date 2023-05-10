import 'package:cloud_firestore/cloud_firestore.dart';

class ThreadHeader {
  final String desc;
  final String title;

  ThreadHeader({
    required this.desc,
    required this.title,
  });

  factory ThreadHeader.fromJson(Map<String, dynamic> json) {
    return ThreadHeader(
     desc: json['desc'] as String,
     title: json['title'] as String,
    );
  }

  factory ThreadHeader.fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;

    return ThreadHeader(
      desc: data['desc'] ?? '',
      title: data['title'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'desc' : desc,
      'title' : title
    };
  }
}
