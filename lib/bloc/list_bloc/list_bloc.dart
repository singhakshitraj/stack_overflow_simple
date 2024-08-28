import 'package:bloc/bloc.dart';
import 'package:social_media/bloc/list_bloc/list_event.dart';
import 'package:social_media/bloc/list_bloc/list_state.dart';
import 'package:social_media/constants/enums.dart';
import 'package:social_media/services/auth/auth_services.dart';
import 'package:social_media/services/database/get/get_services.dart'
    as database;
import 'package:social_media/services/firestore/user/user_services.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  ListBloc() : super(const ListState()) {
    on<GetInitialDataEvent>(_initialData);
    on<AddToLikedEvent>(_addToLiked);
    on<RemoveFromLikedEvent>(_removeFromLiked);
    on<AddToBookmarkEvent>(_addToBookMark);
    on<RemoveFromBookmarkEvent>(_removeFromBookmark);
  }
  Future<void> _initialData(
      GetInitialDataEvent event, Emitter<ListState> emit) async {
    emit(state.copyWith(null, null, state.count! + 1, TileStatus.loading));
    final userId = await database.GetServices().getId(AuthServices().username!);
    bool isLiked = await UserServices().isLiked(userId, event.postId);
    bool isBookmarked = await UserServices().isBookmarked(userId, event.postId);
    emit(state.copyWith(
        isLiked, isBookmarked, state.count! + 1, TileStatus.done));
  }

  void _addToLiked(AddToLikedEvent event, Emitter<ListState> emit) async {
    emit(state.copyWith(null, null, state.count! + 1, TileStatus.processing));
    final userId = await database.GetServices().getId(AuthServices().username!);
    await UserServices().addToLiked(userId, event.postId);
    bool isLiked = await UserServices().isLiked(userId, event.postId);
    bool isBookmarked = await UserServices().isBookmarked(userId, event.postId);
    emit(state.copyWith(
        isLiked, isBookmarked, state.count! + 1, TileStatus.done));
  }

  void _removeFromLiked(
      RemoveFromLikedEvent event, Emitter<ListState> emit) async {
    emit(state.copyWith(null, null, state.count! + 1, TileStatus.processing));
    final userId = await database.GetServices().getId(AuthServices().username!);
    await UserServices().removeFromLiked(userId, event.postId);
    bool isLiked = await UserServices().isLiked(userId, event.postId);
    bool isBookmarked = await UserServices().isBookmarked(userId, event.postId);
    emit(state.copyWith(
        isLiked, isBookmarked, state.count! + 1, TileStatus.done));
  }

  void _addToBookMark(AddToBookmarkEvent event, Emitter<ListState> emit) async {
    emit(state.copyWith(null, null, state.count! + 1, TileStatus.loading));
    final userId = await database.GetServices().getId(AuthServices().username!);
    await UserServices().addToBookmarked(userId, event.postId);
    bool isLiked = await UserServices().isLiked(userId, event.postId);
    bool isBookmarked = await UserServices().isBookmarked(userId, event.postId);
    emit(state.copyWith(
        isLiked, isBookmarked, state.count! + 1, TileStatus.done));
  }

  void _removeFromBookmark(
      RemoveFromBookmarkEvent event, Emitter<ListState> emit) async {
    emit(state.copyWith(null, null, state.count! + 1, TileStatus.processing));
    final userId = await database.GetServices().getId(AuthServices().username!);
    await UserServices().removeFromBookmarked(userId, event.postId);
    bool isLiked = await UserServices().isLiked(userId, event.postId);
    bool isBookmarked = await UserServices().isBookmarked(userId, event.postId);
    emit(state.copyWith(
        isLiked, isBookmarked, state.count! + 1, TileStatus.done));
  }
}
