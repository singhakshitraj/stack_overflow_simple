import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media/bloc/sign_up_bloc/sign_up_event.dart';
import 'package:social_media/bloc/sign_up_bloc/sign_up_state.dart';
import 'package:social_media/constants/enums.dart';
import 'package:social_media/services/auth/auth_services.dart';
import 'package:social_media/services/database/post/post_services.dart'
    as database;
import 'package:social_media/services/database/post/post_format.dart';

import '../../services/firestore/user/user_services.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(const SignUpState()) {
    on<SignUp>(_signUp);
    on<SignOut>(_signOut);
  }
  void _signUp(SignUp event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(null, 'loading', LoadingState.loading));
    try {
      // Try to Create A User with Username And Password
      final user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: event.userName, password: event.password)
          .then((userCred) => userCred.user);
      // Generate An ID of Firestore for storing liked and bookmarked. This ID is stored in Database
      final String id = await UserServices().getListStorageId();
      // Post User Data To Database
      await database.PostServices().postUserData(
          AuthServices().username!,
          PostFormat().userDetails({
            'name': event.name,
            'email': event.userName,
            'id': id,
          }));
      emit(state.copyWith(user, 'success', LoadingState.done));
    } catch (e) {
      return emit(state.copyWith(null, e.toString(), LoadingState.error));
    }
  }

  void _signOut(SignOut event, Emitter<SignUpState> emit) {
    AuthServices().logout();
    emit(state.copyWith(null, 'not initialised', LoadingState.notInitiated));
  }
}
