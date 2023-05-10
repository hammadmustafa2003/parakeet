import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parakeet/models/learner.dart';
import 'package:parakeet/home.dart';
import 'package:parakeet/models/models.dart';
import 'package:parakeet/services/thread_db.dart';
import 'threads_reply.dart';
import 'threads_create.dart';

class ThreadScreen extends StatefulWidget {
  final Learner learner;

  const ThreadScreen({super.key, required this.learner});


  @override
  _ThreadScreenState createState() => _ThreadScreenState();
}

class _ThreadScreenState extends State<ThreadScreen> {

  final Thread_db thDB = Thread_db();
  dynamic allData;

  dynamic _getThread() async {
    final a = await thDB.fetchThreads();
    allData = await a.docs.map((doc) => doc.data()).toList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // call your function here
    Timer.periodic(Duration(seconds: 2), (timer) {
      _getThread();
    });
  }

  @override
  Widget build(BuildContext context) {



    // TODO: implement build


    return Scaffold(
        backgroundColor: const Color.fromRGBO(255, 255, 255,1),
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
                            builder: (context) => HomeScreen(
                                key: Key('home'), learner: widget.learner)));
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
          children: <Widget>[
            Row(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(25),
                  child: Text(
                    "Threads",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 135),
                  child: IconButton(
                      icon: const Icon(
                        Icons.add_circle_rounded,
                        color: Colors.blue,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                            ThreadCreateScreen(key: Key('thread-create-new'),
                                learner: widget.learner)
                         )
                        );
                      }),
                ),
              ],
            ),
            Expanded(
              child: ListView.separated(
                itemCount: allData?.length ?? 0,
                itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(allData[index]['title']),
                      leading: IconButton(
                          icon: const Icon(
                            Icons.account_circle,
                            color: Colors.blue,
                            size: 30,
                          ),
                          onPressed: () {

                            ThreadHeader hdr = ThreadHeader(desc: allData[index]['desc'], title: allData[index]['title']);

                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>
                                      ThreadReplyScreen(key: Key('thread-reply'),
                                          learner: widget.learner,header: hdr,))
                              );
                          }
                      ),
                    );
                    },
                separatorBuilder: (BuildContext context,int index){
                    return const Divider();
                },
              ),
            )
          ],
        ));
    throw UnimplementedError();
  }
}
