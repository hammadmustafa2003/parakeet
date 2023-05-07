import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String recipientId;
  final String text;
  final Timestamp createdAt;

  const Message({
    required this.senderId,
    required this.recipientId,
    required this.text,
    required this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      senderId: json['senderId'] as String,
      recipientId: json['recipientId'] as String,
      text: json['text'] as String,
      createdAt: json['createdAt'] as Timestamp,
    );
  }

  factory Message.fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;

    return Message(
      senderId: data['senderId'] ?? '',
      recipientId: data['recipientId'] ?? '',
      text: data['text'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'recipientId': recipientId,
      'text': text,
      'createdAt': createdAt,
    };
  }

  // function to get all messages from firebase
  static Future<List<Message>> getAllMessages() async {
    List<Message> messages = [];
    await FirebaseFirestore.instance
        .collection('message')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        messages.add(Message.fromSnapshot(doc));
      });
    });
    return messages;
  }

  // function to get all messages of a particular user from firebase
  static Future<List<Message>> getAllSentMessages(String senderId) async {
    List<Message> messages = [];
    await FirebaseFirestore.instance
        .collection('message')
        .where('senderId', isEqualTo: senderId)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        messages.add(Message.fromSnapshot(doc));
      });
    });
    return messages;
  }

  // function to get all messages of a particular user either sent or received from firebase
  static Future<List<Message>> getAllMessagesOfUser(String userId) async {
    List<Message> messages = [];
    await FirebaseFirestore.instance
        .collection('message')
        .where('senderId', isEqualTo: userId)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        messages.add(Message.fromSnapshot(doc));
      });
    });
    await FirebaseFirestore.instance
        .collection('message')
        .where('recipientId', isEqualTo: userId)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        messages.add(Message.fromSnapshot(doc));
      });
    });
    return messages;
  }

  // get messages between two users
  static Future<List<Message>> getMessages(
      String senderId, String recipientId) async {
    List<Message> messages = [];
    await FirebaseFirestore.instance
        .collection('message')
        .where('senderId', isEqualTo: senderId)
        .where('recipientId', isEqualTo: recipientId)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        messages.add(Message.fromSnapshot(doc));
      });
    });
    await FirebaseFirestore.instance
        .collection('message')
        .where('senderId', isEqualTo: recipientId)
        .where('recipientId', isEqualTo: senderId)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        messages.add(Message.fromSnapshot(doc));
      });
    });
    // make timestamp in HH:mm format
    messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return messages;
  }

  // unique chat users
  static Future<List<String>> getChatUsers(String userId) async {
    List<String> chatUsers = [];
    await FirebaseFirestore.instance
        .collection('message')
        .where('senderId', isEqualTo: userId)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        chatUsers.add(doc['recipientId']);
      });
    });
    await FirebaseFirestore.instance
        .collection('message')
        .where('recipientId', isEqualTo: userId)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        chatUsers.add(doc['senderId']);
      });
    });
    return chatUsers.toSet().toList();
  }
}
