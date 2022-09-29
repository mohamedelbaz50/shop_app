import 'package:shop_app/Models/login_model.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSucsessState extends RegisterStates {
  final LoginModel loginModel;

  RegisterSucsessState(this.loginModel);
}

class RegisterErrorlState extends RegisterStates {
  final String error;

  RegisterErrorlState(this.error);
}

class RegisterPassVisabilityState extends RegisterStates {}
