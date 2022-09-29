import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Models/login_model.dart';
import 'package:shop_app/Modules/Login/login_states.dart';
import 'package:shop_app/Shared/Network/Remote/dio_helper.dart';
import 'package:shop_app/Shared/Network/Remote/end_points.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  LoginCubit get(context) => BlocProvider.of(context);
  void userLogin({String? email, String? password}) {
    emit(LoginLoadingState());
    DioHelper.postData(url: lOGIN, data: {"email": email, 'password': password})
        .then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(LoginSucsessState(loginModel!));
    }).catchError((error) {
      emit(LoginErrorlState(error.toString()));
    });
  }

  LoginModel? loginModel;

  bool isVisible = true;
  IconData passIcon = Icons.visibility;
  void changePasswordVisability() {
    isVisible = !isVisible;
    passIcon = isVisible ? Icons.visibility : Icons.visibility_off;
    emit(PassVisabilityState());
  }
}
