import 'package:equatable/equatable.dart';

abstract class ListEvent extends Equatable {
  const ListEvent();
  @override
  List<Object?> get props => [];
}

class GetListEvent extends ListEvent {
  const GetListEvent();
  @override
  List<Object?> get props => [];
}

class AddToListEvent extends ListEvent {
  final Map<String, dynamic> post;
  const AddToListEvent({
    required this.post,
  });
  @override
  List<Object?> get props => [post];
}

class RefreshEvent extends ListEvent {}
