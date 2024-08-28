import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
  @override
  List<Object?> get props => [];
}

class GetPostEvent extends PostEvent {
  const GetPostEvent();
  @override
  List<Object?> get props => [];
}

class AddToPostEvent extends PostEvent {
  final Map<String, dynamic> post;
  const AddToPostEvent({
    required this.post,
  });
  @override
  List<Object?> get props => [post];
}

class RefreshEvent extends PostEvent {}
