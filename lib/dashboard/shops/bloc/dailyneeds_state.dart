part of 'dailyneeds_bloc.dart';

sealed class DailyneedsState extends Equatable {}

final class DailyneedsInitial extends DailyneedsState {
  @override
  List<Object?> get props => [];
}

class DailyneedsSuccessState extends DailyneedsState {
  final ShopListModel? shopListModel;

  DailyneedsSuccessState({required this.shopListModel});
  @override
  List<Object?> get props => [shopListModel];
}

class DailyneedsErrorState extends DailyneedsState {
  @override
  List<Object?> get props => [];
}

class ShopAddSuccessState extends DailyneedsState {
  @override
  List<Object?> get props => [];
}

class ShopAddErrorState extends DailyneedsState {
  final dynamic msg;
  ShopAddErrorState({required this.msg});
  @override
  List<Object?> get props => [msg];
}
