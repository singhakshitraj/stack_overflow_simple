import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media/services/firestore/get/get_posts.dart';

class GetLists {
  // GET SAVED LISTS LIKE FAVORITE, SAVED AND BOOKMARKED POSTS
  Future<List<Map<String, dynamic>>> getSavedList(
      String docId, String parameter) async {
    final rawData = await FirebaseFirestore.instance
        .collection('users')
        .doc(docId)
        .get()
        .then((val) => val.data()![parameter]);
    List<Map<String, dynamic>> posts = [];
    for (dynamic value in rawData) {
      final post = await GetPosts().getPostData(value);
      posts.add(post);
    }
    return posts;
  }
}
