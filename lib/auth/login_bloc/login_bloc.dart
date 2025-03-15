import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
        emit(LoginSuccessState(loginModel: _loginModel!));
      } else {
        emit(LoginErrorState(errMsg: _loginModel!.message.toString()));
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
