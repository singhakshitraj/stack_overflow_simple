import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media/bloc/login_bloc/login_event.dart';
import 'package:social_media/bloc/login_bloc/login_state.dart';
import 'package:social_media/constants/enums.dart';
import 'package:social_media/services/auth/auth_services.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<Loggingin>(_login);
    on<LogoutEvent>(_logout);
  }
  void _login(Loggingin event, Emitter<LoginState> emit) async {
    emit(state.copyWith(null, 'loading', LoadingState.loading));
    try {
      final user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: event.userName, password: event.password)
          .then((userCred) => userCred.user);
      emit(state.copyWith(user, 'success', LoadingState.done));
    } catch (e) {
      return emit(state.copyWith(null, e.toString(), LoadingState.error));
    }
  }

  void _logout(LogoutEvent event, Emitter<LoginState> emit) {
    AuthServices().logout();
    emit(state.copyWith(null, 'not initialised', LoadingState.notInitiated));
  }
}
