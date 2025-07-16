import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:society_gate/api/api_repository.dart';

import '../../constents/local_storage.dart';
import '../../models/login_model.dart';
import '../network/login_api.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginModel? _loginModel;
  LoginBloc() : super(LoginInitialState()) {
    on<LoginButtonEvent>(_loginMethod);
    // on<AmenitiesChecker>(_amenitiesChecker);
  }

  // void _amenitiesChecker(
  //     AmenitiesChecker event, Emitter<LoginState> emit) async {
  //   emit(LoginLoadingState());
  //   ApiRepository apiRepository = ApiRepository();

  //   final approveStatus = await apiRepository
  //       .getExistingAmenitiesData(_loginModel!.user!.societyId);

  //   emit(IsAmenitiesAvailableState(isAmenitiesAvailable: approveStatus!));
  // }

  void _loginMethod(LoginButtonEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    bool? approveStatus;
    try {
      final loginData =
          await login(event.phoneNo.toString(), event.password.toString());
      _loginModel = loginData;
      if (_loginModel!.status == 200) {
        LocalStoragePref().storeLoginModel(_loginModel!);
        LocalStoragePref().setLoginBool(true);
        if (_loginModel?.user?.role == "admin") {
          approveStatus = await ApiRepository()
              .getExistingAmenitiesData(_loginModel!.user!.societyId);
          if (approveStatus == true) {
            LocalStoragePref().setAmenitiesBool(true);
          }
        }

        final ss = LocalStoragePref().getLoginModel();
        String dd = ss?.user?.societyName ?? "NAAAA";
        log(" Local : $dd");
        log(" Model : ${_loginModel?.user?.societyName}");
        if (loginData?.status == 200 && loginData?.user?.role == "admin") {
          approveStatus = await ApiRepository()
              .getExistingAmenitiesData(_loginModel!.user!.societyId);
        } else {
          approveStatus = true;
        }
        // emit(IsAmenitiesAvailableState(isAmenitiesAvailable: approveStatus!));

        emit(LoginSuccessState(
            loginModel: _loginModel!,
            isAmenitiesAvailable: approveStatus ?? false));
      } else if (_loginModel!.status == 403) {
        log(" error");
        emit(LoginNotApproveState(approvemsg: _loginModel!.message.toString()));
      } else if (_loginModel!.status == 401 || _loginModel!.status == 404) {
        emit(LoginErrorState(errMsg: _loginModel!.message.toString()));
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
