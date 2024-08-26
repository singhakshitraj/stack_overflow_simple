import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media/bloc/sign_up_bloc/sign_up_event.dart';
import 'package:social_media/bloc/sign_up_bloc/sign_up_state.dart';
import 'package:social_media/constants/enums.dart';
import 'package:social_media/services/auth/auth_services.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(const SignUpState()) {
    on<SignUp>(_signUp);
    on<SignOut>(_signOut);
  }
  void _signUp(SignUp event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(null, 'loading', LoadingState.loading));
    try {
      final user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: event.userName, password: event.password)
          .then((userCred) => userCred.user);
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
