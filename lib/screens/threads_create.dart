import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:parakeet/models/learner.dart';
import 'package:parakeet/home.dart';
import 'package:parakeet/screens/home_screen_public_thread.dart';
import 'package:parakeet/services/thread_db.dart';

class ThreadCreateScreen extends StatefulWidget {
  final Learner learner;

  const ThreadCreateScreen({super.key, required this.learner});

  @override
  _ThreadCreateScreenState createState() => _ThreadCreateScreenState();
}

class _ThreadCreateScreenState extends State<ThreadCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final title = TextEditingController();
  final description = TextEditingController();

  void _submit() async {
    if (_formKey.currentState!.validate()) {

      final titleText = title.text.trim();
      final descText = description.text.trim();

      Thread_db thDB = Thread_db();

      final result = thDB.createThread(titleText, descText);

      title.text = "";
      description.text = "";


    }
  }

  Widget _buildUserInput(String label, TextEditingController controller){
    return TextFormField(
      obscureText: label == 'Password',
      controller: controller,
      decoration: InputDecoration(
        hintText: label,
        border: OutlineInputBorder( borderRadius: BorderRadius.circular(10.0),),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your $label';
        }
        return null;
      },
    );
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
        body: Form(
            key: _formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Public Thread',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 30.0,
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  _buildUserInput('Title Of Thread', title),
                  const SizedBox(height: 16.0),
                  _buildUserInput('Description', description),
                  const SizedBox(height: 16.0),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 70),
                    child: ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 20),
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        )),
                  )
                ])));
    throw UnimplementedError();
  }
}
