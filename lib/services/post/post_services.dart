import 'package:cloud_firestore/cloud_firestore.dart';

class PostServices {
  Future<void> post(Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection('posts')
        .add(data)
        .then((docs) => addId(docs.id));
  }

  Future<void> addId(String id) async {
    await FirebaseFirestore.instance.collection('posts').doc(id).set(
      {'id': id},
      SetOptions(merge: true),
    );
  }

  Future<void> postComments(String id, Map<String, dynamic> comment) async {
    final comments = (await FirebaseFirestore.instance
        .collection('posts')
        .doc(id)
        .get()
        .then((comm) => comm.data()?['comments']));
    comments.add(comment);
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(id)
        .set({'comments': comments}, SetOptions(merge: true));
  }
}
