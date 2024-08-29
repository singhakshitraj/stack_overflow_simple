import 'package:cloud_firestore/cloud_firestore.dart';

class GetStatus {
  Future<bool> isLiked(String id, String postId) async {
    final data = await FirebaseFirestore.instance
        .doc(id)
        .get()
        .then((value) => value['liked']);
    final list = Set<String>.from(data);
    return list.contains(postId);
  }

  Future<bool> isBookmarked(String id, String postId) async {
    final data = await FirebaseFirestore.instance
        .doc(id)
        .get()
        .then((value) => value['bookmarked']);
    final list = Set<String>.from(data);
    return list.contains(postId);
  }
}
