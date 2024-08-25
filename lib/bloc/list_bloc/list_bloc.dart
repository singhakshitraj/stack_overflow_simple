import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/bloc/list_bloc/list_event.dart';
import 'package:social_media/bloc/list_bloc/list_state.dart';
import 'package:social_media/constants/enums.dart';
import 'package:social_media/services/get/get_posts.dart';
import 'package:social_media/services/post/post_services.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  //late List<Map<String, dynamic>> posts;
  num isChanged = 0;
  ListBloc() : super(const ListState()) {
    on<GetListEvent>(_getList);
    on<AddToListEvent>(_addToList);
    on<RefreshEvent>(_refresh);
  }
  Future<void> _getList(GetListEvent event, Emitter<ListState> emit) async {
    emit(state.copyWith(null, StateOfList.loading));
    final List<Map<String, dynamic>> posts = await GetPosts().getPosts();
    emit(state.copyWith(posts, StateOfList.done));
  }

  Future<void> _addToList(AddToListEvent event, Emitter<ListState> emit) async {
    emit(state.copyWith(null, StateOfList.adding));
    await PostServices().post(event.post);
    final List<Map<String, dynamic>> posts = await GetPosts().getPosts();
    emit(state.copyWith(posts, StateOfList.done));
  }

  void _refresh(RefreshEvent event, Emitter<ListState> emit)  async {
    emit(state.copyWith(null, StateOfList.loading));
    final List<Map<String, dynamic>> posts = await GetPosts().getPosts();
    emit(state.copyWith(posts, StateOfList.done));
  }
}
