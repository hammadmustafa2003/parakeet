import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parakeet/models/learner.dart';
import 'package:parakeet/profile.dart';
import 'home.dart';
import 'newchat.dart';
import 'models/models.dart';
import 'widgets/widgets.dart';
import 'package:parakeet/config/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatefulWidget {
  final Learner learner;
  final Future<List<String>> chatUsers;
  const ChatScreen({Key? key, required this.learner, required this.chatUsers})
      : super(key: key);

  @override
  _ChatScreenState createState() =>
      _ChatScreenState(this.learner, this.chatUsers);
}
// display all chats for a learner
// also display a button to start a new chat at the bottom right
// when a chat is clicked, navigate to the chat page
// when the button is clicked, navigate to the new chat page

class _ChatScreenState extends State<ChatScreen> {
  final Learner learner;
  final Future<List<String>> chatUsers;
  _ChatScreenState(this.learner, this.chatUsers);
  @override
  Widget build(BuildContext context) {
    // fetch from firebase and display all users in a list
    // when a user is clicked, navigate to the chat page
    // when the button is clicked, navigate to the new chat page

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
                        builder: (context) => HomeScreen(
                              learner: learner,
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
                  Icons.person_rounded,
                  color: Colors.blue,
                  size: 30,
                ),
                onPressed: () {
                  //TODO: Add profile page
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfilePage(
                              learner: learner,
                            )),
                    // route to home
                  );
                },
              ),
            ]),
      ),
      // display a button to start a new chat at the bottom right
      // when the button is clicked, navigate to the new chat page
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Chats',
                  style: TextStyle(
                      color: Colors.blue, fontSize: 30, fontFamily: 'font1'),
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.blue,
                  child: IconButton(
                    alignment: Alignment.center,
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: () {
                      // present a drop down menu to select a user to chat with
                      // when a user is selected, navigate to the chat page

                      // get all users from firebase
                      Future<List<Learner>> learners =
                          Learner.getLearner(this.learner.username);

                      showDialog(
                          // display a drop down menu to select a user to chat with
                          // when a user is selected, navigate to the chat page

                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                'Select a user to chat with',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20,
                                    fontFamily: 'font1'),
                              ),
                              content: FutureBuilder<List<Learner>>(
                                future: learners,
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<Learner>> snapshot) {
                                  if (snapshot.hasData) {
                                    return Container(
                                      width: double.maxFinite,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: snapshot.data!.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return ListTile(
                                            // make rectangles for each user
                                            // display icon, name, and username
                                            // when a user is clicked, navigate to the chat page

                                            leading: CircleAvatar(
                                              radius: 22,
                                              backgroundColor: Colors.blue,
                                              child: const Icon(
                                                Icons.person_rounded,
                                                color: Colors.white,
                                                size: 22,
                                              ),
                                            ),
                                            title: Text(
                                              snapshot.data![index].name,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontFamily: 'font1'),
                                            ),
                                            subtitle: Text(
                                              snapshot.data![index].username,
                                              style: const TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 12,
                                                  fontFamily: 'font1'),
                                            ),
                                            onTap: () {
                                              // navigate to the chat page
                                              Navigator.pop(context);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder:
                                                        (context) => StartChat(
                                                              sender: learner,
                                                              receiver: snapshot
                                                                  .data![index],
                                                              messages: Message.getMessages(
                                                                  learner
                                                                      .username,
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .username),
                                                            )),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    );
                                  } else {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                },
                              ),
                            );
                          });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // chatUsers is a list of usernames
            // display a rectangle for each user
            // display icon, username
            // when a user is clicked, navigate to the chat page

            FutureBuilder<List<String>>(
              future: chatUsers,
              builder:
                  (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0, 2),
                                blurRadius: 10,
                              )
                            ],
                          ),
                          child: ListTile(
                            // make rectangles for each user
                            // display icon, name, and username
                            // when a user is clicked, navigate to the chat page

                            leading: CircleAvatar(
                              radius: 22,
                              backgroundColor: Colors.blue,
                              child: const Icon(
                                Icons.person_rounded,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                            title: Text(
                              snapshot.data![index],
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontFamily: 'font1'),
                            ),
                            onTap: () async {
                              // navigate to the chat page
                              // get Receiver from Learner.getLearnerbyUsername(snapshot.data![index])
                              // this method returns a Future<Learner>
                              // pass this learner object to the chat page not Future<Learner>

                              Future<Learner> temp =
                                  Learner.getLearnerByUsername(
                                      snapshot.data![index]);
                              Learner receiver = await temp;

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StartChat(
                                          sender: learner,
                                          receiver: receiver,
                                          messages: Message.getMessages(
                                              learner.username,
                                              snapshot.data![index]),
                                        )),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
