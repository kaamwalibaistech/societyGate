part of 'members_bloc.dart';

sealed class MembersState extends Equatable {
  const MembersState();
  
  @override
  List<Object> get props => [];
}

final class MembersInitial extends MembersState {}
