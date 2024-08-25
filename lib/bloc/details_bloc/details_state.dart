import 'package:equatable/equatable.dart';
import 'package:social_media/constants/enums.dart';

class DetailsState extends Equatable {
  final StateOfList state;
  final Map<String, dynamic> data;
  const DetailsState({this.data = const {}, this.state = StateOfList.loading});
  @override
  List<Object?> get props => [state, data];
  DetailsState copyWith(StateOfList? state, Map<String, dynamic>? data) {
    return DetailsState(
      data: data ?? this.data,
      state: state ?? this.state,
    );
  }
}
