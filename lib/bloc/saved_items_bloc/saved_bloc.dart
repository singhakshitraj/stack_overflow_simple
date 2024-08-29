import 'package:bloc/bloc.dart';
import 'package:social_media/bloc/saved_items_bloc/saved_event.dart';
import 'package:social_media/bloc/saved_items_bloc/saved_state.dart';
import 'package:social_media/constants/enums.dart';
import 'package:social_media/services/auth/auth_services.dart';
import 'package:social_media/services/firestore/get/get_lists.dart';
import 'package:social_media/services/database/get/get_services.dart'
    as database;

class SavedBloc extends Bloc<SavedEvent, SavedState> {
  SavedBloc() : super(const SavedState()) {
    on<LoadSavedList>(_loadData);
  }
  void _loadData(LoadSavedList event, Emitter<SavedState> emit) async {
    // LOADS DATA FOR LISTS ( LIKED , BOOKMARKS , USER POSTS )
    emit(state.copyWith(TileStatus.loading, null));
    final docId = await database.GetServices().getId(AuthServices().username!);
    final listOfData = await GetLists().getSavedList(docId, event.parameter);
    if (listOfData.isEmpty) {
      emit(state.copyWith(TileStatus.error, null));
    } else {
      emit(state.copyWith(TileStatus.done, listOfData));
    }
  }
}
