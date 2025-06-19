part of 'dailyneeds_bloc.dart';

abstract class DailyneedsEvent extends Equatable {}

class GetShopsList extends DailyneedsEvent {
  @override
  List<Object?> get props => [];
}

class AddShopEvent extends DailyneedsEvent {
  final String image, shopName, shopType, ownerName, shopPhone, shopAddress;
  AddShopEvent(
      {required this.image,
      required this.shopName,
      required this.shopType,
      required this.ownerName,
      required this.shopPhone,
      required this.shopAddress});
  @override
  List<Object?> get props =>
      [image, shopName, shopType, ownerName, shopPhone, shopAddress];
}
