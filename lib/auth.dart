import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> sendPasswordResetEmail({
    required String email,
  }) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    // await FirebaseFirestore.instance.collection('users').add({
    //   'email': email,
    //   'projects':{
    //     'name': "Car",
    //     'date': "02-02-2023",
    //     'instructions': "Your instructions",
    //     'task': "Text",
    //     'type': "Named Entity Recognition",
    //     'progress': "50%",
    //   }
    // });

    // CollectionReference userss = FirebaseFirestore.instance.collection('users');

// add user
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .set({
      'email': email,
    });

// add project
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .collection('projects')
        .add({
      "name": "Car Detection",
      "date": "02/09/2022",
      "progress": "0%",
      "status": "New",
      "task":"Image Classification",
      "labels":["Toyota","Nissan","Mazda"],
      "instructions": "Classify each sample to one label based on the sample's content"
    },
    );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .collection('projects')
        .add({
      "name": "Tweets",
      "date": "02/09/2022",
      "progress": "100%",
      "status": "Completed",
      "task":"Named Entity Recognition",
      "labels":["Positive","Negative","Normal"],
      "instructions": "Classify each sample to one label based on the sample's content"
    },
    );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .collection('projects')
        .add({
      "name": "Voice",
      "date": "02/09/2022",
      "progress": "100%",
      "status": "Completed",
      "task":"Audio Classification",
      "labels":["Ahmed","Khalid","Mohannad"],
      "instructions": "Guess who is talking in the voice"

    },
    );
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
