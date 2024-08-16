import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object?> get props => [];
}

class Loggingin extends LoginEvent{
  final String userName;
  final String password;
  const Loggingin({
    required this.userName,
    required this.password,
  });
  @override
  List<Object?> get props => [userName,password];
}