part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitialState extends LoginState {}

final class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final LoginModel loginModel;
  const LoginSuccessState({required this.loginModel});
  @override
  List<Object> get props => [loginModel];
}

class LoginErrorState extends LoginState {
  final String errMsg;
  const LoginErrorState({required this.errMsg});

  @override
  List<Object> get props => [errMsg];
}

class LoginNotApproveState extends LoginState {
  final String approvemsg;
  const LoginNotApproveState({required this.approvemsg});

  @override
  List<Object> get props => [approvemsg];
}

class IsAmenitiesAvailableState extends LoginState {
  final bool isAmenitiesAvailable;
  const IsAmenitiesAvailableState({required this.isAmenitiesAvailable});

  @override
  List<Object> get props => [isAmenitiesAvailable];
}
