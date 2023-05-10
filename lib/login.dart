import 'package:flutter/material.dart';
import 'home.dart';
import 'models/learner.dart';
import 'signup.dart';
import 'services/auth.dart';
import 'loading.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});
  final String title;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  // String _username = '';
  // String _password = '';
  String errorText = '';
  late Learner _learner;
  final myControllerUsername = TextEditingController();
  final myControllerPassword = TextEditingController();
  bool loading = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myControllerUsername.dispose();
    myControllerPassword.dispose();
    super.dispose();
  }

  void changePage(BuildContext context) async {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(learner: _learner),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final String username = myControllerUsername.text;
      final String password = myControllerPassword.text;
      print("Submitting LOGIN up form...\nwith $username and $password");
      final Auth auth = Auth();
      setState(() {
        loading = true;
      });
      final dynamic result =
          await auth.signInWithUsernamePassword(username, password);
      if (context.mounted) {
        setState(() {
          loading = false;
        });
        if (result is Learner) {
          // Login successful
          _learner = result;
          changePage(context);
        } else {
          // Login failed
          setState(() {
            errorText = result;
          });
        }
      }
    }
  }

  Widget _buildUserInput(String label, TextEditingController controller) {
    return TextFormField(
      obscureText: label == 'Password',
      controller: controller,
      decoration: InputDecoration(
        hintText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your $label';
        }
        return null;
      },
    );
  }

  Widget _buildAppbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/images/icon.png',
          fit: BoxFit.contain,
          height: 30,
        ),
        const Padding(
            padding: EdgeInsets.only(top: 6.0),
            // padding: const EdgeInsets.all(5.0),
            child: Text(
              'arekeet',
              style: TextStyle(
                  color: Colors.blue, fontSize: 30, fontFamily: 'font1'),
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: const Color.fromRGBO(240, 255, 255, 1),
            appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                title: _buildAppbar()),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
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
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 80),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
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
                          _buildUserInput('Username', myControllerUsername),
                          const SizedBox(height: 16.0),
                          _buildUserInput('Password', myControllerPassword),
                          const SizedBox(height: 16.0),
                          Text(
                            errorText,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w800,
                              fontSize: 18.0,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 70),
                            child: ElevatedButton(
                                onPressed: _submitForm,
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    elevation: 20),
                                child: const Text(
                                  'Log In',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                )),
                          ),
                          const SizedBox(height: 20.0, width: 50),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupPage()),
                              );
                            },
                            child: const Text(
                              'Create a new account',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
