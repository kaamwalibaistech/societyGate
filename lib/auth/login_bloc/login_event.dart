part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {}

class LoginButtonEvent extends LoginEvent {
  final String? phoneNo;
  final String? password;
  LoginButtonEvent(this.phoneNo, this.password);

  @override
  List<Object?> get props => [phoneNo, password];
}
