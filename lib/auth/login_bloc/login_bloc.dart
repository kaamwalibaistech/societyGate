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
  }

  void _loginMethod(LoginButtonEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    try {
      ApiRepository apiRepository = ApiRepository();
      final loginData =
          await login(event.phoneNo.toString(), event.password.toString());
      _loginModel = loginData;
      if (_loginModel!.status == 200) {
        LocalStoragePref().storeLoginModel(_loginModel!);
        LocalStoragePref().setLoginBool(true);

        final ss = LocalStoragePref().getLoginModel();
        String dd = ss?.user?.societyName ?? "NAAAA";
        log(" Local : $dd");
        log(" Model : ${_loginModel?.user?.societyName}");

        emit(LoginSuccessState(loginModel: _loginModel!));

        final approveStatus = await apiRepository
            .getExistingAmenitiesData(loginData!.user!.societyId);

        emit(IsAmenitiesAvailableState(isAmenitiesAvailable: approveStatus!));
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
