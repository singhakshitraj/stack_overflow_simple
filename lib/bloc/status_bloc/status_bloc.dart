import 'package:bloc/bloc.dart';
import 'package:social_media/bloc/status_bloc/status_event.dart';
import 'package:social_media/bloc/status_bloc/status_state.dart';
import 'package:social_media/constants/enums.dart';
import 'package:social_media/services/auth/auth_services.dart';
import 'package:social_media/services/database/get/get_services.dart'
    as database;
import 'package:social_media/services/firestore/user/user_services.dart';

class StatusBloc extends Bloc<StatusEvent, StatusState> {
  StatusBloc() : super(const StatusState()) {
    on<GetInitialDataEvent>(_initialData);
    on<AddToLikedEvent>(_addToLiked);
    on<RemoveFromLikedEvent>(_removeFromLiked);
    on<AddToBookmarkEvent>(_addToBookMark);
    on<RemoveFromBookmarkEvent>(_removeFromBookmark);
  }
  Future<void> _initialData(
      GetInitialDataEvent event, Emitter<StatusState> emit) async {
    emit(state.copyWith(null, null, state.count! + 1, TileStatus.loading));
    final userId = await database.GetServices().getId(AuthServices().username!);
    bool isLiked = await UserServices().isLiked(userId, event.postId);
    bool isBookmarked = await UserServices().isBookmarked(userId, event.postId);
    emit(state.copyWith(
        isLiked, isBookmarked, state.count! + 1, TileStatus.done));
  }

  void _addToLiked(AddToLikedEvent event, Emitter<StatusState> emit) async {
    emit(state.copyWith(null, null, state.count! + 1, TileStatus.processing));
    final userId = await database.GetServices().getId(AuthServices().username!);
    await UserServices().addToLiked(userId, event.postId);
    emit(state.copyWith(
        true, state.isBookmarked, state.count! + 1, TileStatus.done));
  }

  void _removeFromLiked(
      RemoveFromLikedEvent event, Emitter<StatusState> emit) async {
    emit(state.copyWith(null, null, state.count! + 1, TileStatus.processing));
    final userId = await database.GetServices().getId(AuthServices().username!);
    await UserServices().removeFromLiked(userId, event.postId);
    emit(state.copyWith(
        false, state.isBookmarked, state.count! + 1, TileStatus.done));
  }

  void _addToBookMark(
      AddToBookmarkEvent event, Emitter<StatusState> emit) async {
    emit(state.copyWith(null, null, state.count! + 1, TileStatus.processing));
    final userId = await database.GetServices().getId(AuthServices().username!);
    await UserServices().addToBookmarked(userId, event.postId);
    emit(
        state.copyWith(state.isLiked, true, state.count! + 1, TileStatus.done));
  }

  void _removeFromBookmark(
      RemoveFromBookmarkEvent event, Emitter<StatusState> emit) async {
    emit(state.copyWith(null, null, state.count! + 1, TileStatus.processing));
    final userId = await database.GetServices().getId(AuthServices().username!);
    await UserServices().removeFromBookmarked(userId, event.postId);
    emit(state.copyWith(
        state.isLiked, false, state.count! + 1, TileStatus.done));
  }
}
