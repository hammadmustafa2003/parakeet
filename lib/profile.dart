import 'dart:typed_data';
import 'login.dart';
import 'models/learner.dart';
import 'home.dart';

import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {

  final Learner learner;
  const ProfilePage({Key? key, required this.learner}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // make sure its full screen
  @override
  Widget build(BuildContext context) {
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
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen(learner: widget.learner,)),
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
                        padding: EdgeInsets.only (right: 6, top: 10),
                        // padding: const EdgeInsets.all(5.0),
                        child: Text(
                          'arekeet',
                          style: TextStyle( color: Colors.blue, fontSize: 30, fontFamily: 'font1') ,
                        )
                    )
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.home_rounded,
                  color: Colors.blue,
                  size: 30,
                ),
                onPressed: () {
                  //TODO: Add profile page
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen(learner: widget.learner,)),
                  );
                },
              ),
            ]
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 35.0),
                  child: Padding(
                    padding: const EdgeInsets.only(top:15),
                    child: Text(
                      widget.learner.name[0],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 90,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Username: ${widget.learner.username}",
                  style: const TextStyle(
                    color: Colors.cyan,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 05,
                ),
                Text(
                  "Name: ${widget.learner.name}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 05,
                ),
                Text(
                  "Email: ${widget.learner.email}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 05,
                ),
                Text(
                  "Rank: ${widget.learner.rank}",
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 05,
                ),
                Text(
                  "Points: ${widget.learner.points}",
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 0,
                ),
                // History Button
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(05.0),
                    ),
                  ),
                  child: const Text(
                    "History",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 0,
                ),
                // Edit Profile Button
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(05.0),
                    ),
                  ),
                  child: const Text(
                    "Edit Profile",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                // Logout Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(
                          title: 'Login Page',
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(05.0),
                    ),
                  ),
                  child: const Text(
                    "Logout",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}