import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Models/login_model.dart';
import 'package:shop_app/Modules/Login/login_states.dart';
import 'package:shop_app/Modules/Register/register_states.dart';
import 'package:shop_app/Shared/Network/Remote/dio_helper.dart';
import 'package:shop_app/Shared/Network/Remote/end_points.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());
  RegisterCubit get(context) => BlocProvider.of(context);
  void userRegister(
      {String? name, String? email, String? password, String? phone}) {
    emit(RegisterLoadingState());
    DioHelper.postData(url: register, data: {
      "name": name,
      "email": email,
      'password': password,
      "phone": phone
    }).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(RegisterSucsessState(loginModel!));
      print(loginModel!.message);
    }).catchError((error) {
      emit(RegisterErrorlState(error.toString()));
    });
  }

  LoginModel? loginModel;

  bool isVisible = true;
  IconData passIcon = Icons.visibility;
  void changePasswordVisability() {
    isVisible = !isVisible;
    passIcon = isVisible ? Icons.visibility : Icons.visibility_off;
    emit(RegisterPassVisabilityState());
  }
}
