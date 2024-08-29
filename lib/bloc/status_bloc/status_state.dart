import 'package:equatable/equatable.dart';
import 'package:social_media/constants/enums.dart';

class StatusState extends Equatable {
  final bool? isLiked;
  final bool? isBookmarked;
  final num? count;
  final TileStatus tileStatus;
  const StatusState(
      {this.isBookmarked = false,
      this.isLiked = false,
      this.count = 0,
      this.tileStatus = TileStatus.notInitiated});

  StatusState copyWith(
      bool? isLiked, bool? isBookmarked, num? count, TileStatus? tileStatus) {
    return StatusState(
        isBookmarked: isBookmarked ?? this.isBookmarked,
        isLiked: isLiked ?? this.isLiked,
        count: count ?? this.count,
        tileStatus: tileStatus ?? this.tileStatus);
  }

  @override
  List<Object?> get props => [isBookmarked, isLiked, count, tileStatus];
}
