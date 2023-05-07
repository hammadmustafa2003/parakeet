import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parakeet/chathomescreen.dart';
import 'package:parakeet/models/learner.dart';
import 'package:parakeet/profile.dart';
import 'home.dart';
import 'models/models.dart';
import 'widgets/widgets.dart';
import 'package:parakeet/config/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'models/message_model.dart';

class StartChat extends StatefulWidget {
  final Learner sender;
  final Learner receiver;
  final Future<List<Message>> messages;
  const StartChat(
      {Key? key,
      required this.sender,
      required this.receiver,
      required this.messages})
      : super(key: key);

  @override
  _StartChatState createState() => _StartChatState(sender, receiver, messages);
}

class _StartChatState extends State<StartChat> {
  final Learner sender;
  final Learner receiver;
  late Future<List<Message>> messages;
  _StartChatState(this.sender, this.receiver, this.messages);

  final _formKey = GlobalKey<FormState>();
  final _messageController = TextEditingController();
  Timer _timer = Timer.periodic(Duration(seconds: 3), (_) {});

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 3), (_) async {
      Future<List<Message>> temp =
          Message.getMessages(sender.username, receiver.username);
      List<Message> message = await temp;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // code to reload the page here
        if (mounted) {
          setState(() {
            messages = temp;
            // scroll to the bottom of the list
            Scrollable.ensureVisible(context);
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _timer
        .cancel(); // cancel the timer when the widget is removed from the widget tree
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
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
                  // Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatScreen(
                              learner: sender,
                              chatUsers: Message.getChatUsers(sender.username),
                            )),
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
                        padding: EdgeInsets.only(right: 6, top: 10),
                        // padding: const EdgeInsets.all(5.0),
                        child: Text(
                          'arekeet',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 30,
                              fontFamily: 'font1'),
                        ))
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.home,
                  color: Colors.blue,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreen(
                              learner: sender,
                            )),
                  );
                },
              ),
            ]),
      ),
      body: Container(
        // create a big rectangle box with receiver's name on top left
        child: Column(
          children: [
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    receiver.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontFamily: 'font1',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: FutureBuilder<List<Message>>(
                          future: messages,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              // if senderId == sender.username, then allign the message to the right
                              // else allign the message to the left
                              // rectangle box with message text should be displayed with length of text

                              return ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  Message message = snapshot.data![index];
                                  String formatedTime = message.createdAt
                                      .toDate()
                                      .toString()
                                      .substring(11, 19);
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 05, vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          message.senderId == sender.username
                                              ? MainAxisAlignment.end
                                              : MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: message.senderId ==
                                                    sender.username
                                                ? Colors.blue
                                                : Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 05),
                                            // message text and time should be displayed
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  message.text,
                                                  style: TextStyle(
                                                    color: message.senderId ==
                                                            sender.username
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontSize: 16,
                                                    fontFamily: 'font1',
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  formatedTime,
                                                  style: TextStyle(
                                                    color: message.senderId ==
                                                            sender.username
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 12,
                                                    fontFamily: 'font2',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            return const CircularProgressIndicator();
                          },
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: TextFormField(
                                  controller: _messageController,
                                  decoration: const InputDecoration(
                                    hintText: 'Type a message',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: InkWell(
                              onTap: () {
                                // get the text from the text field
                                String text = _messageController.text;
                                Message message = Message(
                                  senderId: sender.username,
                                  recipientId: receiver.username,
                                  text: text,
                                  createdAt: Timestamp.now(),
                                );
                                // send the message to firebase
                                FirebaseAuth auth = FirebaseAuth.instance;
                                String uid = auth.currentUser!.uid;
                                FirebaseFirestore.instance
                                    .collection('message')
                                    .add(message.toMap());
                                // clear the text field
                                _messageController.clear();

                                // update the list of messages
                                setState(() {
                                  messages.then((value) => value.add(message));
                                });
                              },
                              child: const Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
