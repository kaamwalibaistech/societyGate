part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {}

class LoginButtonEvent extends LoginEvent {
  final String email;
  final String password;
  LoginButtonEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}
