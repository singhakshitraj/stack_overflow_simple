import 'package:firebase_database/firebase_database.dart';

class GetServices {
  final _database = FirebaseDatabase.instance;

  Future getId(String username) async {
    final vals = await _database.ref('users/$username/id').get();
    return vals.value;
  }
}
