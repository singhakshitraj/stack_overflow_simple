import 'package:firebase_database/firebase_database.dart';

class PostServices {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Future<void> postUserData(String username, Map<String, dynamic> data) async {
    await _database.ref('users/$username').set(data);
  }
}
