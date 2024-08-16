import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media/constants/enums.dart';

class LoginState extends Equatable{
  final LoadingState loadingState;
  final User? user;
  final String? message;
  const LoginState({
    this.user,
    this.message = '',
    this.loadingState  = LoadingState.notInitiated,
  });
  @override
  List<Object?> get props => [user, message,loadingState];

  LoginState copyWith(User? user, String? message,LoadingState? loadingState) {
    return LoginState(
      user: user ?? this.user,
      message: message ?? this.message,
      loadingState: loadingState ?? this.loadingState
    );
  }
}