import 'package:equatable/equatable.dart';
import 'package:social_media/constants/enums.dart';

class PostState extends Equatable {
  final List<Map<String, dynamic>> posts;
  final StateOfList stateOfList;
  const PostState({
    this.posts = const [],
    this.stateOfList = StateOfList.loading,
  });
  @override
  List<Object?> get props => [posts, stateOfList];

  PostState copyWith(
      List<Map<String, dynamic>>? posts, StateOfList? stateOfList) {
    return PostState(
        posts: posts ?? this.posts,
        stateOfList: stateOfList ?? this.stateOfList);
  }
}
