import 'package:equatable/equatable.dart';

import '../models/announcements_model.dart';

abstract class HomepageState extends Equatable {}

final class HomePageInitialState extends HomepageState {
  @override
  List<Object?> get props => [];
}

final class HomePageLoadingState extends HomepageState {
  @override
  List<Object?> get props => [];
}

final class HomePageLoadedState extends HomepageState {
  final Announcementmodel? mydata;
  HomePageLoadedState({required this.mydata});
  @override
  List<Object?> get props => [mydata];
}

final class HomePageErrorState extends HomepageState {
  final String msg;
  HomePageErrorState({required this.msg});

  @override
  List<Object?> get props => [msg];
}
