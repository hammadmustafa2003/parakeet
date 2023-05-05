import 'package:firebase_auth/firebase_auth.dart';
import 'profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/learner.dart';

class EditProfilePage extends StatefulWidget {
  final Learner learner;
  EditProfilePage({Key? key, required this.learner}) : super(key: key);
  @override
  _EditProfilePageState createState() => _EditProfilePageState(learner);
}

// only learner.name is editable

class _EditProfilePageState extends State<EditProfilePage> {
  final Learner learner;
  _EditProfilePageState(this.learner);
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = learner.name;
    _emailController.text = learner.email;
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
                        builder: (context) => ProfilePage(
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
                  );
                },
              ),
            ]),
      ),
      backgroundColor: const Color.fromRGBO(240, 255, 255, 1),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.person,
                  color: Colors.blue,
                ),
                labelText: 'Name',
                labelStyle: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.email,
                  color: Colors.blue,
                ),
                labelText: 'Email',
                labelStyle: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // save the fields..
                    Learner learner = Learner(
                      name: _nameController.text,
                      email: _emailController.text,
                      username: widget.learner.username,
                      rank: widget.learner.rank,
                      points: widget.learner.points,
                    );
                    // loading indicator
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    );
                    // update firebase
                    await FirebaseAuth.instance.currentUser!
                        .updateEmail(_emailController.text);
                    await FirebaseAuth.instance.currentUser!
                        .updateDisplayName(_nameController.text);
                    // route to profile page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(learner: learner),
                      ),
                    );
                  }
                },
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
