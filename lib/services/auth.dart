import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/models/learner.dart';


class Auth{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  dynamic signInWithUsernamePassword(String username, String password) async{
    try {
      // Get the Learner document with the matching username
      final DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('learner')
          .doc(username)
          .get();

      if (!doc.exists) {
        // No document found with matching username
        return 'Username does not exist';
      }

      // Retrieve email from the Learner document
      final String email = doc.get('email');

      // Authenticate user with email and password
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);

      // Get the authenticated user
      final User? user = userCredential.user;

      if (user == null) {
        // Authentication failed
        return 'Invalid Password';
      }

      // Authentication successful, retrieve Learner object
      final Learner learner = Learner.fromSnapshot(doc);
      return learner;

    } on FirebaseAuthException catch (e) {
      // Authentication failed
      return e.message;
    } catch (e) {
      // Other error occurred
      return 'Error: $e';
    }
  }

  Future<dynamic> createUser(String username, String password, String email, String name) async {
    try {
      // Create user in Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create a new Learner object with the provided details
      Learner newLearner = Learner(
        username: username,
        email: email,
        name: name,
        points: 0,
        rank: "Beginner",
      );

      // Store the Learner object in Firestore
      await FirebaseFirestore.instance.collection('learner').doc(username).set(newLearner.toMap());
      return "Success";

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }
}