import 'package:equatable/equatable.dart';

abstract class HomepageEvent extends Equatable {}

final class GetHomePageDataEvent extends HomepageEvent {
  @override
  List<Object?> get props => [];
}
