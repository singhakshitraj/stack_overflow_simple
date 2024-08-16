import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media/constants/enums.dart';

class SignUpState extends Equatable {
  final LoadingState loadingState;
  final User? user;
  final String? message;
  const SignUpState({
    this.user,
    this.message = '',
    this.loadingState  = LoadingState.notInitiated,
  });
  @override
  List<Object?> get props => [user, message,loadingState];

  SignUpState copyWith(User? user, String? message,LoadingState? loadingState) {
    return SignUpState(
      user: user ?? this.user,
      message: message ?? this.message,
      loadingState: loadingState ?? this.loadingState
    );
  }
}
