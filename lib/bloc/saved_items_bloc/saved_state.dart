import 'package:equatable/equatable.dart';
import 'package:social_media/constants/enums.dart';

class SavedState extends Equatable {
  final TileStatus status;
  final List<Map<String, dynamic>> requiredPosts;

  const SavedState({
    this.status = TileStatus.notInitiated,
    this.requiredPosts = const [],
  });
  SavedState copyWith(
      TileStatus? status, List<Map<String, dynamic>>? requiredPosts) {
    return SavedState(
        status: status ?? this.status,
        requiredPosts: requiredPosts ?? this.requiredPosts);
  }

  @override
  List<Object?> get props => [status, requiredPosts];
}
