import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  User? get currentUser => FirebaseAuth.instance.currentUser;
  void logout() {
    FirebaseAuth.instance.signOut();
  }
}
