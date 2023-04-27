import 'package:flutter/material.dart';
import 'signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});
  final String title;
  @override
  State<LoginPage> createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';

  final myControllerUsername = TextEditingController();
  final myControllerPassword = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myControllerUsername.dispose();
    myControllerPassword.dispose();
    super.dispose();
  }



  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // TODO: Add login logic here
      _username = myControllerUsername.text;
      _password = myControllerPassword.text;
      print("Submitting LOGIN up form...\nwith $_username and $_password");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 255, 255, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/icon.png',
              fit: BoxFit.contain,
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.only (top:6.0),
                // padding: const EdgeInsets.all(5.0),
                child: Text(
                'arekeet',
                style: TextStyle( color: Colors.blue, fontSize: 30, fontFamily: 'font1') ,
                )
            )
          ],
        ),
      ),
      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            "Welcome !",
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.w700,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Login to Continue',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 30.0,
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  TextFormField(
                    controller: myControllerUsername,
                    decoration: InputDecoration(
                      hintText: 'Username',
                      border: OutlineInputBorder( borderRadius: BorderRadius.circular(10.0),),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: myControllerPassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 70),
                    child: ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 16),
                            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
                            elevation: 20
                        ),
                        child: const Text('Log In', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),)
                    ),
                  ),
                  const SizedBox(height: 20.0,width: 50),

                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupPage()),
                      );
                    },
                    child: const Text(
                      'Create a new account',
                      textAlign: TextAlign.center,
                      style: TextStyle( color: Colors.grey, fontWeight: FontWeight.w600,),
                    ),
                  ),


                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
