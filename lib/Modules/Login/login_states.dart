import 'package:shop_app/Models/login_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSucsessState extends LoginStates {
  final LoginModel loginModel;

  LoginSucsessState(this.loginModel);
}

class LoginErrorlState extends LoginStates {
  final String error;

  LoginErrorlState(this.error);
}

class PassVisabilityState extends LoginStates {}
