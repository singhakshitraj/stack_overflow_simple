import 'package:cloud_firestore/cloud_firestore.dart';

class GetPosts {
  Future<dynamic> getPosts() async {
    List<Map<String, dynamic>> list = [];
    await FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((snapshot) =>
            // ignore: avoid_function_literals_in_foreach_calls
            snapshot.docs.forEach((item) => list.add(item.data())));
    return list;
  }

  Future<dynamic> getPostData(String docId) async {
    final postData = await FirebaseFirestore.instance
        .collection('posts')
        .doc(docId)
        .get()
        .then((doc) => doc.data());
    return postData;
  }
}
