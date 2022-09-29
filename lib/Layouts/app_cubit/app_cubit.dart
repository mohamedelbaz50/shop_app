import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layouts/app_cubit/app_states.dart';
import 'package:shop_app/Models/categories_model.dart';
import 'package:shop_app/Models/change_favorites_model.dart';
import 'package:shop_app/Models/favorites_model.dart';
import 'package:shop_app/Models/home_model.dart';
import 'package:shop_app/Models/login_model.dart';
import 'package:shop_app/Modules/categories_screen/categories_screen.dart';
import 'package:shop_app/Modules/favorites_screen/favorites_screen.dart';
import 'package:shop_app/Modules/products_screen/products_screen.dart';
import 'package:shop_app/Modules/profile_screen/profile_screen.dart';
import 'package:shop_app/Shared/Component/constatnt.dart';
import 'package:shop_app/Shared/Network/Local/cache_helper.dart';
import 'package:shop_app/Shared/Network/Remote/dio_helper.dart';
import 'package:shop_app/Shared/Network/Remote/end_points.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppStatesInitialState());
  AppCubit get(context) => BlocProvider.of(context);
  List<String> titles = ["Moshtariat", "Categories", "Favorites", "Profile"];
  List<Widget> bottomNavScreens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    ProfileScreen()
  ];
  int currentIndex = 0;
  void changeBottomNav(index) {
    currentIndex = index;
    emit(BottomNavChangeState());
  }

  HomeModel? homeModel;
  Map<int, bool>? favorites = {};

  void getHomeData() {
    emit(HomeDataLoadingState());
    DioHelper.getData(url: home, token: CacheHelper.getData(key: "token"))
        .then((value) {
      homeModel = HomeModel.fromjson(value.data);
      homeModel!.data!.products.forEach((element) {
        favorites!.addAll(({element.id: element.favorites}));
      });
      emit(HomeDataSuccesState());
    }).catchError((error) {
      emit(HomeDataErorrState());
      print(error.toString());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoriesData() {
    DioHelper.getData(
      url: getCategories,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(HomeCategoriesSuccesState());
    }).catchError((error) {
      emit(HomeCategoriesErorrState());
      print(error.toString());
    });
  }

  FavoritesModel? favoritesModel;
  void getFavoritesData() {
    emit(GetFavoritesLoadingState());
    DioHelper.getData(
      token: CacheHelper.getData(key: "token"),
      url: putInFavorites,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(GetFavoritesSuccesState());
    }).catchError((error) {
      emit(GetFavoritesErorrState());
      print(error.toString());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites![productId] = !favorites![productId]!;
    emit(ChangeButtonFavoriteState());
    DioHelper.postData(
            url: putInFavorites,
            data: {"product_id": productId},
            token: CacheHelper.getData(key: "token"))
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (!changeFavoritesModel!.status!) {
        favorites![productId] = !favorites![productId]!;
      } else {
        getFavoritesData();
      }

      emit(ChangeFavoritesSuccesState(changeFavoritesModel!));
    }).catchError((error) {
      favorites![productId] = !favorites![productId]!;
      emit(ChangeFavoritesErorrState());
    });
  }

  LoginModel? loginModel;
  void getUserData() {
    emit(UserDataLoadingState());
    DioHelper.getData(
      token: CacheHelper.getData(key: "token"),
      url: profile,
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(UserDataSuccesState());
      print(loginModel!.data!.email);
    }).catchError((error) {
      emit(UserDataErorrState());
      print(error.toString());
    });
  }

  void updateUserData({
    required String? name,
    required String? email,
    required String? phone,
  }) {
    emit(UpdateUserDataLoadingState());
    DioHelper.putData(
        token: CacheHelper.getData(key: "token"),
        url: updateProfile,
        data: {
          "name": name,
          "email": email,
          "phone": phone,
        }).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(UpdateUserDataSuccesState());
      print(loginModel!.data!.email);
    }).catchError((error) {
      emit(UpdateUserDataErorrState());
      print(error.toString());
    });
  }
}
