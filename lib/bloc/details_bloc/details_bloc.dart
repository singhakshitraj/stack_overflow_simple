import 'package:bloc/bloc.dart';
import 'package:social_media/bloc/details_bloc/details_event.dart';
import 'package:social_media/bloc/details_bloc/details_state.dart';
import 'package:social_media/constants/enums.dart';
import 'package:social_media/services/get/get_posts.dart';
import 'package:social_media/services/post/post_format.dart';
import 'package:social_media/services/post/post_services.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc() : super(const DetailsState()) {
    on<GetDataEvent>(_getData);
    on<AddCommentEvent>(_addComment);
    on<UpvoteEvent>(_upvote);
    on<CloseIssueEvent>(_close);
    on<OpenIssueEvent>(_open);
  }
  Future<void> _getData(GetDataEvent event, Emitter<DetailsState> emit) async {
    emit(state.copyWith(StateOfList.loading, null));
    final data = await GetPosts().getPostData(event.id);
    emit(state.copyWith(StateOfList.done, data));
  }

  void _addComment(AddCommentEvent event, Emitter<DetailsState> emit) async {
    emit(state.copyWith(StateOfList.loading, null));
    final comment = PostFormat().toComment(event.comment);
    await PostServices().postComments(event.id, comment);
    final post = await GetPosts().getPostData(event.id);
    emit(state.copyWith(StateOfList.done, post));
  }

  void _upvote(UpvoteEvent event, Emitter<DetailsState> emit) async {
    emit(state.copyWith(StateOfList.loading, null));
    await PostServices().upvote(event.id);
    final post = await GetPosts().getPostData(event.id);
    emit(state.copyWith(StateOfList.done, post));
  }

  void _close(CloseIssueEvent event, Emitter<DetailsState> emit) async {
    emit(state.copyWith(StateOfList.loading, null));
    await PostServices().closeIssue(event.id);
    final post = await GetPosts().getPostData(event.id);
    emit(state.copyWith(StateOfList.done, post));
  }

  void _open(OpenIssueEvent event, Emitter<DetailsState> emit) async {
    emit(state.copyWith(StateOfList.loading, null));
    await PostServices().openIssue(event.id);
    final post = await GetPosts().getPostData(event.id);
    emit(state.copyWith(StateOfList.done, post));
  }
}
