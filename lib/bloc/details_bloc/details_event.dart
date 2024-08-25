import 'package:equatable/equatable.dart';

abstract class DetailsEvent extends Equatable {
  const DetailsEvent();
  @override
  List<Object?> get props => [];
}

class GetDataEvent extends DetailsEvent {
  final String id;
  const GetDataEvent({
    required this.id,
  });
  @override
  List<Object?> get props => [id];
}

class AddCommentEvent extends DetailsEvent {
  final String id;
  final Map<String, dynamic> comment;
  const AddCommentEvent({
    required this.comment,
    required this.id,
  });
  @override
  List<Object?> get props => [comment, id];
}

class UpvoteEvent extends DetailsEvent {
  final String id;
  const UpvoteEvent({
    required this.id,
  });
  @override
  List<Object?> get props => [id];
}

class CloseIssueEvent extends DetailsEvent {
  final String id;
  const CloseIssueEvent({
    required this.id,
  });
  @override
  List<Object?> get props => [id];
}

class OpenIssueEvent extends DetailsEvent {
  final String id;
  const OpenIssueEvent({
    required this.id,
  });
  @override
  List<Object?> get props => [id];
}
