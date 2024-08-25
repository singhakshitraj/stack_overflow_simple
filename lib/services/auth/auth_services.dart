import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  User? get currentUser => FirebaseAuth.instance.currentUser;
  String? get email => FirebaseAuth.instance.currentUser?.email;
  String? get username => email?.substring(0, email?.indexOf('@').toInt());
  void logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
