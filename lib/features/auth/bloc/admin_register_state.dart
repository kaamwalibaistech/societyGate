import 'package:equatable/equatable.dart';

abstract class AuthBlocState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthBlocInitial extends AuthBlocState {
  @override
  List<Object> get props => [];
}

class AuthBlocLoading extends AuthBlocState {
  @override
  List<Object> get props => [];
}

class AuthBlocLoaded extends AuthBlocState {
  @override
  List<Object> get props => [];
}

class AuthBlocFailed extends AuthBlocState {
  @override
  List<Object> get props => [];
}
