import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
  @override
  List<Object?> get props => [];
}

class SignUp extends SignUpEvent {
  final String userName;
  final String password;
  const SignUp({
    required this.userName,
    required this.password,
  });
  @override
  List<Object?> get props => [userName,password];
}

