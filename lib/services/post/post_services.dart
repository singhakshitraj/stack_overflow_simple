import 'package:cloud_firestore/cloud_firestore.dart';

class PostServices {
  Future<void> post(Map<String,dynamic> data) async {
    await FirebaseFirestore.instance.collection('posts').add(data);
  }
}
