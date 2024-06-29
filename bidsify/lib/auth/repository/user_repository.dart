import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepository = Provider(
  (ref) => (
    UserRepository(
      auth: FirebaseAuth.instance,
      firestore: FirebaseFirestore.instance,
    ),
  ),
);

class UserRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  UserRepository({
    required this.auth,
    required this.firestore,
  });

  void signin(String name, String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  void login(String email, String password, AuthCredential credential) async {
    try {
      await auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
