import 'package:equatable/equatable.dart';

abstract class SavedEvent extends Equatable {
  const SavedEvent();
}

class LoadSavedList extends SavedEvent {
  final String parameter;
  const LoadSavedList({
    required this.parameter,
  });
  @override
  List<Object?> get props => [parameter];
}
