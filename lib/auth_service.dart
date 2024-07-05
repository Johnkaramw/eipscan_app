import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> registerUser(
      String email, String password, String username, String phone) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        await saveUserData(user.uid, username, email, phone);
      }
    } on FirebaseAuthException catch (e) {
      print("Error creating user: $e");
    }
  }

  Future<void> saveUserData(
      String userId, String username, String email, String phone) async {
    await _firebaseFirestore.collection('users').doc(userId).set({
      'username': username,
      'email': email,
      'phone': phone,
    });
  }
}
