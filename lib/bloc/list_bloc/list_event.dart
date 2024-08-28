import 'package:equatable/equatable.dart';

abstract class ListEvent extends Equatable {
  const ListEvent();
}

class GetInitialDataEvent extends ListEvent {
  final String postId;
  const GetInitialDataEvent({
    required this.postId,
  });
  @override
  List<Object?> get props => [postId];
}

class AddToLikedEvent extends ListEvent {
  final String postId;
  const AddToLikedEvent({
    required this.postId,
  });
  @override
  List<Object?> get props => [postId];
}

class RemoveFromLikedEvent extends ListEvent {
  final String postId;
  const RemoveFromLikedEvent({
    required this.postId,
  });
  @override
  List<Object?> get props => [postId];
}

class AddToBookmarkEvent extends ListEvent {
  final String postId;
  const AddToBookmarkEvent({
    required this.postId,
  });
  @override
  List<Object?> get props => [postId];
}

class RemoveFromBookmarkEvent extends ListEvent {
  final String postId;
  const RemoveFromBookmarkEvent({
    required this.postId,
  });
  @override
  List<Object?> get props => [postId];
}
