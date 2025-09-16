import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:app/core/firebase/firebase_options.dart';

class FirebaseService {
  static Future<FirebaseFirestore> initializeFirebase() async {
    // Initialize Firebase
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    return FirebaseFirestore.instance;
  }
}
