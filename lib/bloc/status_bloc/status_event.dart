import 'package:equatable/equatable.dart';

abstract class StatusEvent extends Equatable {
  const StatusEvent();
}

class GetInitialDataEvent extends StatusEvent {
  final String postId;
  const GetInitialDataEvent({
    required this.postId,
  });
  @override
  List<Object?> get props => [postId];
}

class AddToLikedEvent extends StatusEvent {
  final bool isBookmarked;
  final String postId;
  const AddToLikedEvent({
    required this.postId,
    required this.isBookmarked,
  });
  @override
  List<Object?> get props => [postId, isBookmarked];
}

class RemoveFromLikedEvent extends StatusEvent {
  final String postId;
  final bool isBookmarked;
  const RemoveFromLikedEvent({
    required this.postId,
    required this.isBookmarked,
  });
  @override
  List<Object?> get props => [postId, isBookmarked];
}

class AddToBookmarkEvent extends StatusEvent {
  final bool isLiked;
  final String postId;
  const AddToBookmarkEvent({
    required this.postId,
    required this.isLiked,
  });
  @override
  List<Object?> get props => [postId, isLiked];
}

class RemoveFromBookmarkEvent extends StatusEvent {
  final bool isLiked;
  final String postId;
  const RemoveFromBookmarkEvent({
    required this.postId,
    required this.isLiked,
  });
  @override
  List<Object?> get props => [postId, isLiked];
}
