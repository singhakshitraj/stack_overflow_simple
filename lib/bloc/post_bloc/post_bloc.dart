import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/bloc/post_bloc/post_event.dart';
import 'package:social_media/bloc/post_bloc/post_state.dart';
import 'package:social_media/constants/enums.dart';
import 'package:social_media/services/firestore/get/get_posts.dart';
import 'package:social_media/services/firestore/post/post_services.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(const PostState()) {
    on<GetPostEvent>(_getList);
    on<AddToPostEvent>(_addToList);
    on<RefreshEvent>(_refresh);
  }
  Future<void> _getList(GetPostEvent event, Emitter<PostState> emit) async {
    emit(state.copyWith(null, StateOfList.loading));
    final List<Map<String, dynamic>> posts = await GetPosts().getPosts();
    emit(state.copyWith(posts, StateOfList.done));
  }

  Future<void> _addToList(AddToPostEvent event, Emitter<PostState> emit) async {
    emit(state.copyWith(null, StateOfList.adding));
    await PostServices().post(event.post);
    final List<Map<String, dynamic>> posts = await GetPosts().getPosts();
    emit(state.copyWith(posts, StateOfList.done));
  }

  void _refresh(RefreshEvent event, Emitter<PostState> emit) async {
    emit(state.copyWith(null, StateOfList.loading));
    final List<Map<String, dynamic>> posts = await GetPosts().getPosts();
    emit(state.copyWith(posts, StateOfList.done));
  }
}
