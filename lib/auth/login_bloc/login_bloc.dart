import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_society/constents/local_storage.dart';
import 'package:my_society/models/login_model.dart';

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
      final loginData = await login(event.email, event.password);
      _loginModel = loginData;
      if (_loginModel!.status == 200) {
        LocalStoragePref().storeLoginModel(_loginModel!);
        LocalStoragePref().setLoginBool(true);

        final ss = LocalStoragePref().getLoginModel();
        String dd = ss?.user?.societyName ?? "NAAAA";
        log(" Local : $dd");
        log(" Model : ${_loginModel?.user?.societyName}");

        emit(LoginSuccessState(loginModel: _loginModel!));
      } else {
        log(" error");
        emit(LoginErrorState(errMsg: _loginModel!.message.toString()));
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
