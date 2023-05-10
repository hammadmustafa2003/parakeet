import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:parakeet/models/message_header.dart';
import 'package:parakeet/models/models.dart';


class Thread_db {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<dynamic> createThread(String title_, String description_) async {
    try {
      ThreadHeader newthread = ThreadHeader(desc: description_, title: title_);

      // Store the Learner object in Firestore
      await FirebaseFirestore.instance.collection('thread').doc(title_).set(
          newthread.toMap());
      return "Success";
    }
    on FirebaseAuthException catch (e) {
      return e.message;
    }
    catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> createMessage(String title_, String message_,String username_, Timestamp ts_) async {
    try {

      // Store the Learner object in Firestore

      MessageHeader msgHeader = MessageHeader(message: message_, title: title_, username: username_,ts: ts_);
      await FirebaseFirestore.instance.collection('threadReply').doc().set(
          msgHeader.toMap());
      return "Success";
    }
    on FirebaseAuthException catch (e) {
      return e.message;
    }
    catch (e) {
      return e.toString();
    }
  }


  dynamic fetchThreads() async {
    try {
      CollectionReference doc = FirebaseFirestore.instance.collection('thread');

      QuerySnapshot querySnapshot = await doc.get();

      return querySnapshot;

      //final ThreadHeader thDb = ThreadHeader.fromSnapshot(doc);
      //return thDb;

    }
    catch (e) {
      return 'Error: $e';
    }
  }

  dynamic fetchReply() async {
    try {
      CollectionReference doc = FirebaseFirestore.instance.collection('threadReply');

      QuerySnapshot querySnapshot = await doc.orderBy('Timestamp',descending: false).get();

      return querySnapshot;

      //final ThreadHeader thDb = ThreadHeader.fromSnapshot(doc);
      //return thDb;

    }
    catch (e) {
      return 'Error: $e';
    }
  }








}



