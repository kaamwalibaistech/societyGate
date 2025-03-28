import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_society/constents/local_storage.dart';
import 'package:my_society/models/login_model.dart';
import 'package:my_society/models/shoplist_model.dart';
import 'package:my_society/shops/network/shop_apis.dart';

part 'dailyneeds_event.dart';
part 'dailyneeds_state.dart';

class DailyneedsBloc extends Bloc<DailyneedsEvent, DailyneedsState> {
  DailyneedsBloc() : super(DailyneedsInitial()) {
    on<GetShopsList>(_getShopsList);
    on<AddShopEvent>(_addShopList);
  }

  void _getShopsList(GetShopsList event, Emitter<DailyneedsState> emit) async {
    ShopListModel? shopListModel;
    LoginModel? loginModel = LocalStoragePref().getLoginModel();

    try {
      shopListModel =
          await shopList(loginModel?.user?.societyId.toString() ?? "");

      if (shopListModel!.status == 200) {
        emit(DailyneedsSuccessState(shopListModel: shopListModel));
      } else {
        emit(DailyneedsErrorState());
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  void _addShopList(AddShopEvent event, Emitter<DailyneedsState> emit) async {
    // emit(DailyneedsInitial());
    AddShopModel? addShopModel;

    try {
      LoginModel? loginModel = LocalStoragePref().getLoginModel();
      addShopModel = await addShopAPI(
          loginModel!.user!.societyId.toString(),
          event.shopName,
          event.shopType,
          event.ownerName,
          event.shopPhone,
          event.shopAddress);

      if (addShopModel?.status == 200) {
        emit(ShopAddSuccessState());
      } else {
        emit(ShopAddErrorState(msg: addShopModel?.message ?? "Try again!"));
      }
    } catch (e) {
      emit(ShopAddErrorState(msg: "Something went wrong, Try again!"));
    }
  }
}
