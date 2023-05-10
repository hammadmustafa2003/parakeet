import 'package:cloud_firestore/cloud_firestore.dart';

class MessageHeader {
  final String message;
  final String title;
  final String username;
  final Timestamp ts;

  MessageHeader({
    required this.message,
    required this.title,
    required this.username,
    required this.ts
  });



  Map<String, dynamic> toMap() {
    return {
      'username' : username,
      'title' : title,
      'message' : message,
      'Timestamp' : ts,
    };
  }


}
