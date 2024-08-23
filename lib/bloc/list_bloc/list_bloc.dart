import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/bloc/list_bloc/list_event.dart';
import 'package:social_media/bloc/list_bloc/list_state.dart';
import 'package:social_media/constants/enums.dart';
import 'package:social_media/services/get/get_posts.dart';
import 'package:social_media/services/post/post_services.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  late List<Map<String, dynamic>> posts;
  num isChanged = 0;
  ListBloc() : super(const ListState()) {
    on<GetListEvent>(_getList);
    on<AddToListEvent>(_addToList);
    on<UpVoteEvent>(_upvote);
  }
  Future<void> _getList(GetListEvent event, Emitter<ListState> emit) async {
    emit(state.copyWith(null, StateOfList.loading));
    posts = await GetPosts().getPosts();
    emit(state.copyWith(posts, StateOfList.done));
  }

  Future<void> _addToList(AddToListEvent event, Emitter<ListState> emit) async {
    emit(state.copyWith(posts, StateOfList.adding));
    posts.add(event.post);
    PostServices().post(event.post);
    emit(state.copyWith(posts, StateOfList.done));
  }

  Future<void> _upvote(UpVoteEvent event, Emitter<ListState> emit) async {
    posts[event.index]['upvotes'] += 1;
    print(posts[event.index]['upvotes']);
    emit(state.copyWith(posts, StateOfList.done));
  }
}
