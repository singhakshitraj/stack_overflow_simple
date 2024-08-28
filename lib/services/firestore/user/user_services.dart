import 'package:cloud_firestore/cloud_firestore.dart';

class UserServices {
  // GENERATED TWO EMPTY LISTS OF LIKED AND BOOKMARKED POSTS AND STORED IT IN FIRESTORE DATABASE. THE ID OF STORAGE IS THEN SENT TO BE STORED IN FIREBASE DATABASE.
  Future<String> getListStorageId() async {
    final id = await FirebaseFirestore.instance
        .collection('users')
        .add({'liked': [], 'bookmarked': []}).then((x) => x.id);
    return id;
  }

  Future<bool> isLiked(String userId, String postId) async {
    final liked = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((snapshot) => snapshot.data()!['liked']);
    final likedList = List<String>.from(liked);
    return likedList.contains(postId);
  }

  Future<bool> isBookmarked(String userId, String postId) async {
    final bookmarked = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((snapshot) => snapshot.data()!['bookmarked']);
    final bookmarkedList = List<String>.from(bookmarked);
    return bookmarkedList.contains(postId);
  }

  Future<void> addToLiked(String userId, String postId) async {
    final data = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((value) => value.data()?['liked']);
    Set<String> liked = Set<String>.from(data);
    liked.add(postId);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set({'liked': liked}, SetOptions(merge: true));
  }

  Future<void> removeFromLiked(String userId, String postId) async {
    final data = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((value) => value.data()?['liked']);
    Set<String> liked = Set<String>.from(data);
    liked.remove(postId);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set({'liked': liked}, SetOptions(merge: true));
  }

  Future<void> addToBookmarked(String userId, String postId) async {
    final data = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((value) => value.data()?['bookmarked']);
    Set<String> bookmarked = Set<String>.from(data);
    bookmarked.add(postId);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set({'bookmarked': bookmarked}, SetOptions(merge: true));
  }

  Future<void> removeFromBookmarked(String userId, String postId) async {
    final data = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((value) => value.data()?['bookmarked']);
    Set<String> bookmarked = Set<String>.from(data);
    bookmarked.remove(postId);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set({'bookmarked': bookmarked}, SetOptions(merge: true));
  }
}
