import 'package:equatable/equatable.dart';
import 'package:social_media/constants/enums.dart';

class ListState extends Equatable {
  final List<Map<String, dynamic>> posts;
  final StateOfList stateOfList;
  const ListState({
    this.posts = const [],
    this.stateOfList = StateOfList.loading,
  });
  @override
  List<Object?> get props => [posts, stateOfList];

  ListState copyWith(List<Map<String, dynamic>>? posts, StateOfList? stateOfList) {
    return ListState(
        posts: posts ?? this.posts, stateOfList: stateOfList ?? this.stateOfList);
  }
}
