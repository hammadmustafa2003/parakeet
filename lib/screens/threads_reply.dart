import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parakeet/models/learner.dart';
import 'package:parakeet/home.dart';
import 'package:parakeet/models/models.dart';
import 'package:parakeet/screens/home_screen_public_thread.dart';
import 'package:parakeet/services/thread_db.dart';

class ThreadReplyScreen extends StatefulWidget {
  final Learner learner;
  final ThreadHeader header;

  const ThreadReplyScreen(
      {super.key, required this.learner, required this.header});

  @override
  _ThreadReplyScreenState createState() => _ThreadReplyScreenState();
}

class _ThreadReplyScreenState extends State<ThreadReplyScreen> {
  final replyMessageController = TextEditingController();
  String text = "";
  Thread_db thDB = Thread_db();
  dynamic reply;

  Timer _timer = Timer.periodic(Duration(seconds: 3), (_) {});


  void getReply() async {
    final a  = await thDB.fetchReply();
    final notFiltered =  await a.docs.map((doc) => doc.data()).toList();
    reply = notFiltered.where((element) => element['title'] == widget.header.title).toList();
    setState(() { });
  }



  void _submitMessage(){
    final text = replyMessageController.text.trim();
    Thread_db thDB = Thread_db();

    Timestamp ts = Timestamp.now();

    thDB.createMessage(widget.header.title, text, widget.learner.username,ts);

    replyMessageController.text = '';

    getReply();
  }


  @override
  void initState(){
    super.initState();
    Timer.periodic(Duration(seconds: 2), (timer) {
      getReply();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

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
                    //TODO: Add profile page
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ThreadScreen(
                                key: Key('thread-home'),
                                learner: widget.learner)));
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
                            'Parekeet',
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
                    Icons.person_rounded,
                    color: Colors.blue,
                    size: 30,
                  ),
                  onPressed: () {
                    //TODO: Add profile page
                  },
                ),
              ]),
        ),
        body: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(25),
                child: Text(
                  widget.header.title,
                  style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                )),
            Padding(
                padding: const EdgeInsets.all(25),
                child: Text(
                  widget.header.desc,
                  style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.italic),
                )),
            Expanded(
                child: Container(
                    child: ListView.separated(
                        itemCount: reply?.length ?? 0,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(reply[index]['username']),
                                subtitle: Text(reply[index]['message']),
                            leading: const Icon(Icons.add_alert_rounded),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider();
                        },
                        ))),
            TextFormField(
              controller: replyMessageController,
              onChanged: (value) {
                setState(() {
                  text = value;
                });
              },
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                filled: true,
                fillColor:
                    Theme.of(context).colorScheme.secondary.withAlpha(150),
                hintText: 'Type here...',
                hintStyle: Theme.of(context).textTheme.bodyMedium,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.all(20.0),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                      _submitMessage();
                  },
                ),
              ),
            ),
          ],
        ));
    throw UnimplementedError();
  }
}
